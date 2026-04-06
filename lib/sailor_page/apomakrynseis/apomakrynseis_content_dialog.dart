import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_functions.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:uuid/uuid.dart';

import '../../variables.dart';

class ShowApomakrynseisDialog extends StatefulWidget {
  const ShowApomakrynseisDialog({super.key, required this.sailor, this.id});
  final Sailor sailor;
  final Apomakrynseis? id;
  @override
  State<ShowApomakrynseisDialog> createState() => _ShowApomakrynseisDialog();
}

class _ShowApomakrynseisDialog extends State<ShowApomakrynseisDialog> {
  bool isLoading = false;
  final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Apomakrynseis Key');
  final _formKey = GlobalKey<FormState>();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Apomakrynsi selectedApomakrynsi = Apomakrynsi.apospasi;
  String statusText = 'Προσθήκη Απομάκρυνσης';
  late TextEditingController simaController;
  late TextEditingController ypiresiaController;

  @override
  void initState() {
    simaController = TextEditingController(text: widget.id?.sima ?? "");
    ypiresiaController = TextEditingController(text: widget.id?.ypiresia ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.id == null
                  ? 'Νέα Απομάκρυνση'
                  : 'Επεξεργασία Απομάκρυνσης',
              overflow: .ellipsis,
              maxLines: 1,
            ),
          ),
          Gap(10),
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
            Gap(10),
            InfoLabel(
              label: 'Τύπος',
              child: ComboBox<Apomakrynsi>(
                isExpanded: true,
                value: selectedApomakrynsi,
                key: rankKey,
                onChanged: (Apomakrynsi? newValue) {
                  setState(() {
                    selectedApomakrynsi = newValue!;
                  });
                },
                items: Apomakrynsi.values.map((Apomakrynsi e) {
                  return ComboBoxItem<Apomakrynsi>(
                    value: e,
                    child: Text(e.label),
                  );
                }).toList(),
              ),
            ),
            Gap(padding),
            InfoLabel(
              label: 'Υπηρεσία',
              child: TextFormBox(
                placeholder: ypiresiaController.text.isEmpty
                    ? 'Εισαγωγή υπηρεσίας'
                    : widget.id?.ypiresia ?? 'Εισαγωγή υπηρεσίας',
                controller: ypiresiaController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Παρακαλώ συμπληρώστε την υπηρεσία';
                  }
                  return null;
                },
              ),
            ),
            Gap(padding),
            InfoLabel(
              label: 'Σήμα',
              child: TextFormBox(
                placeholder: simaController.text.isEmpty
                    ? 'Εισαγωγή σήματος'
                    : widget.id?.sima ?? 'Εισαγωγή σήματος',
                controller: simaController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Παρακαλώ συμπληρώστε το σήμα';
                  }
                  return null;
                },
              ),
            ),
            Gap(padding),
            Row(
              children: [
                InfoLabel(
                  label: 'Έναρξη',
                  child: CalendarDatePicker(
                    locale: Locale('el'),
                    placeholderText: DateFormat(
                      'dd/MM/yy',
                      'el',
                    ).format(widget.id?.dateStart ?? selectedStartDate),
                    onSelectionChanged: (CalendarSelectionData data) {
                      if (data.selectedDates.isNotEmpty) {
                        setState(() {
                          selectedStartDate = data.selectedDates.first;
                          if (widget.id == null) {
                            selectedEndDate = data.selectedDates.first;
                          }
                        });
                      }
                    },
                  ),
                ),
                Gap(10),
                InfoLabel(
                  label: 'Λήξη',
                  child: CalendarDatePicker(
                    locale: Locale('el'),
                    placeholderText: DateFormat(
                      'dd/MM/yy',
                      'el',
                    ).format(widget.id?.dateEnd ?? selectedEndDate),
                    onSelectionChanged: (CalendarSelectionData data) {
                      if (data.selectedDates.isNotEmpty) {
                        setState(() {
                          selectedEndDate = data.selectedDates.first;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        isLoading
            ? Row(children: [ProgressRing(), Gap(10), Text(statusText)])
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedStartDate.isAfter(selectedEndDate)) {
                      showCustomInfoBar(
                        context: context,
                        text:
                            'Η ημερομηνία ένραξης πρέπει να είναι πριν την ημερομηνία λήξης.',
                        severity: .warning,
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final newApomakrynsi = Apomakrynseis(
                          id: widget.id != null ? widget.id!.id : Uuid().v4(),
                          type: selectedApomakrynsi,
                          dateStart: selectedStartDate,
                          dateEnd: selectedEndDate,
                          sailorId: widget.sailor.id,
                          sima: simaController.text,
                          ypiresia: ypiresiaController.text,
                        );
                        await addNewApomakrynsi(newApomakrynsi);
                        if (context.mounted && mounted) Navigator.pop(context);
                      } catch (e) {
                        if (context.mounted && mounted) {
                          showCustomInfoBar(
                            context: context,
                            text: e.toString(),
                          );
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  }
                },
              ),
      ],
    );
  }
}
