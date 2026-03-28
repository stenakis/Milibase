import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_functions.dart';

import '../../variables.dart';

class ShowApomakrynseisDialog extends StatefulWidget {
  const ShowApomakrynseisDialog({super.key, required this.sailor});
  final Sailor sailor;
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
  TextEditingController simaController = TextEditingController();
  TextEditingController ypiresiaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        children: [
          const Text('Νέα Απομάκρυνση'),
          Spacer(),
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
                placeholder: 'Εισαγωγή υπηρεσίας',
                controller: ypiresiaController,
                validator: (text) {
                  if (text == '') {
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
                prefix: Padding(padding: .only(left: 10), child: Text('WAF')),
                controller: simaController,
                validator: (text) {
                  if (text == '') {
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
                    placeholderText:
                        '${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}',
                    onSelectionChanged: (CalendarSelectionData data) {
                      if (data.selectedDates.isNotEmpty) {
                        setState(() {
                          selectedStartDate = data.selectedDates.first;
                          selectedEndDate = data.selectedDates.first;
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
                    placeholderText:
                        '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}',
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
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await addNewApomakrynsi(
                        Apomakrynseis(
                          type: selectedApomakrynsi,
                          dateStart: selectedStartDate,
                          dateEnd: selectedEndDate,
                          sailorId: widget.sailor.id,
                          sima: simaController.text,
                          ypiresia: ypiresiaController.text,
                        ),
                      );
                      Navigator.pop(context, 'success');
                    } catch (error) {
                      await displayInfoBar(
                        context,
                        builder: (context, close) {
                          return InfoBar(
                            title: const Text('An error occurred:'),
                            content: Text(error.toString()),
                            action: IconButton(
                              icon: const WindowsIcon(WindowsIcons.error),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.error,
                          );
                        },
                      );
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
