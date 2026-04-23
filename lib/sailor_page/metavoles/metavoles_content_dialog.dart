import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';
import 'package:uuid/uuid.dart';

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
  String statusText = 'Αποθήκευση Μεταβολής';
  late TextEditingController simaController;
  int selectedDuration = 9;

  @override
  void initState() {
    selectedDate = widget.id == null ? DateTime.now() : widget.id!.date;
    selectedMetavoli = widget.id == null ? Metavoli.meiomeni : widget.id!.type;
    simaController = TextEditingController(text: widget.id?.sima ?? "");
    super.initState();
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
        children: [
          Flexible(
            child: Text(
              widget.id == null ? 'Νέα Μεταβολή' : 'Επεξεργασία Μεταβολή',
              overflow: .ellipsis,
              maxLines: 1,
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
                child: RadioGroup<int>(
                  groupValue: selectedDuration,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedDuration = newValue ?? selectedDuration;
                    });
                  },
                  child: const Row(
                    spacing: padding,
                    children: [
                      RadioButton<int>(value: 6, content: Text('6 μήνες')),
                      RadioButton<int>(value: 9, content: Text('9 μήνες')),
                    ],
                  ),
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
                    setState(() {
                      selectedDate = data.selectedDates.first;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        isLoading
            ? Row(children: [ProgressRing(), const Gap(10), Text(statusText)])
            : FilledButton(
                child: const Text('Εισαγωγή'),
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
                      if (context.mounted && mounted) Navigator.pop(context);
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
    );
  }
}
