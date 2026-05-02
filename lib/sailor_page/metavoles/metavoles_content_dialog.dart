import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../objects/metavoles.dart';
import 'metavoles_functions.dart';

class ShowMetavolesDialog extends StatefulWidget {
  const ShowMetavolesDialog({super.key, required this.sailor, this.id});
  final Sailor sailor;
  final Metavoles? id;
  @override
  State<ShowMetavolesDialog> createState() => _ShowMetavolesDialog();
}

class _ShowMetavolesDialog extends State<ShowMetavolesDialog> {
  bool isLoading = false;
  final metavoliKey = GlobalKey<ComboBoxState>(debugLabel: 'Metavoli Key');
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;
  late Metavoli selectedMetavoli;
  late TextEditingController simaController;
  late int selectedDuration;
  late Stream<bool> _meiomeniThiteia;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.id == null ? DateTime.now() : widget.id!.date;
    selectedMetavoli = widget.id == null ? Metavoli.meiomeni : widget.id!.type;
    simaController = TextEditingController(text: widget.id?.sima ?? "");
    selectedDuration = (widget.id == null ? 9 : widget.id!.duration)!;
    _meiomeniThiteia = (db.select(
      db.vars,
    )).watchSingle().map((row) => row.enableMeiomeniThiteia);
  }

  @override
  void dispose() {
    simaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Flexible(
            child: Text(
              widget.id == null ? 'Νέα Μεταβολή' : 'Επεξεργασία Μεταβολής',
              overflow: .ellipsis,
              maxLines: 2,
            ),
          ),
          const Gap(10),
          IconButton(
            icon: WindowsIcon(WindowsIcons.chrome_close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            InfoLabel(
              label: 'Τύπος',
              child: ComboBox<Metavoli>(
                isExpanded: true,
                value: selectedMetavoli,
                key: metavoliKey,
                onChanged: (Metavoli? newValue) {
                  setState(() {
                    selectedMetavoli = newValue!;
                  });
                },
                items: Metavoli.values.map((Metavoli e) {
                  return ComboBoxItem<Metavoli>(value: e, child: Text(e.label));
                }).toList(),
              ),
            ),
            const Gap(5),
            Text(
              selectedMetavoli.description,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            if (selectedMetavoli == .meiomeni) const Gap(padding),
            if (selectedMetavoli == .meiomeni)
              InfoLabel(
                label: 'Διάρκεια Θητείας',
                child: StreamBuilder<bool>(
                  stream: _meiomeniThiteia,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == .waiting) {
                      return ProgressBar();
                    } else if (!snapshot.hasData) {
                      return Text('Σφάλμα');
                    } else if (snapshot.hasData) {
                      bool isTrue = snapshot.data!;
                      return RadioGroup<int>(
                        groupValue: selectedDuration,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedDuration = newValue ?? selectedDuration;
                          });
                        },
                        child: Wrap(
                          runSpacing: 5,
                          spacing: padding,
                          children: [
                            if (isTrue)
                              RadioButton<int>(
                                value: 5,
                                content: Text('5 μήνες'),
                              ),
                            RadioButton<int>(
                              value: 6,
                              content: Text('6 μήνες'),
                            ),
                            if (isTrue)
                              RadioButton<int>(
                                value: 5,
                                content: Text('8 μήνες'),
                              ),

                            RadioButton<int>(
                              value: 9,
                              content: Text('9 μήνες'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('Σφάλμα');
                    }
                  },
                ),
              ),
            const Gap(padding),
            InfoLabel(
              label: 'Σήμα',
              child: TextFormBox(
                placeholder: 'Εισαγωγή σήματος',
                controller: simaController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Παρακαλώ συμπληρώστε το σήμα';
                  }
                  return null;
                },
              ),
            ),
            const Gap(padding),
            InfoLabel(
              label: 'Ημερομηνία',
              child: CalendarDatePicker(
                initialStart: selectedDate,
                isTodayHighlighted: false,
                locale: Locale('el'),
                placeholderText: DateFormat(
                  'dd/MM/yy',
                  'el',
                ).format(widget.id?.date ?? selectedDate),
                onSelectionChanged: (CalendarSelectionData data) {
                  if (data.selectedDates.isNotEmpty) {
                    selectedDate = data.selectedDates.first;
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        isLoading
            ? const Row(
                children: [
                  ProgressRing(),
                  const Gap(10),
                  Text('Αποθήκευση Μεταβολής'),
                ],
              )
            : Row(
                mainAxisAlignment: .end,
                children: [
                  if (widget.id != null)
                    Button(
                      onPressed: () async {
                        try {
                          await deleteMetavoli(widget.id!);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (error) {
                          if (context.mounted) {
                            showCustomInfoBar(
                              context: context,
                              text: error.toString(),
                            );
                          }
                        }
                      },
                      child: Row(
                        children: [
                          WindowsIcon(WindowsIcons.delete),
                          const Gap(5),
                          const Text('Διαγραφή'),
                        ],
                      ),
                    ),
                  if (widget.id != null) const Gap(10),
                  FilledButton(
                    autofocus: true,
                    child: Row(
                      children: [
                        WindowsIcon(WindowsIcons.save),
                        const Gap(5),
                        Text(widget.id == null ? 'Εισαγωγή' : 'Αποθήκευση'),
                      ],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final newMetavoli = Metavoles(
                            id: widget.id != null ? widget.id!.id : Uuid().v4(),
                            type: selectedMetavoli,
                            date: selectedDate,
                            sailorId: widget.sailor.id,
                            sima: simaController.text,
                            duration: selectedDuration,
                          );
                          await addNewMetavoli(newMetavoli);
                          if (context.mounted && mounted)
                            Navigator.pop(context);
                        } catch (e) {
                          if (context.mounted && mounted) {
                            showCustomInfoBar(
                              context: context,
                              text: e.toString(),
                              severity: .error,
                            );
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
