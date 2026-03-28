import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

import '../../objects/metavoles.dart';
import 'metavoles_functions.dart';

class ShowMetavolesDialog extends StatefulWidget {
  const ShowMetavolesDialog({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<ShowMetavolesDialog> createState() => _ShowMetavolesDialog();
}

class _ShowMetavolesDialog extends State<ShowMetavolesDialog> {
  bool isLoading = false;
  final metavoliKey = GlobalKey<ComboBoxState>(debugLabel: 'Metavoli Key');
  final durationKey = GlobalKey<ComboBoxState>(debugLabel: 'Duration Key');
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Metavoli selectedMetavoli = Metavoli.meiomeni;
  String statusText = 'Προσθήκη Μεταβολής';
  TextEditingController simaController = TextEditingController();
  int selectedDuration = 9;
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        children: [
          const Text('Νέα Μεταβολή'),
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
            Gap(5),
            Opacity(
              opacity: 0.75,
              child: Text(
                (selectedMetavoli == .meiomeni)
                    ? 'Μεταφέρθηκε στους υπόχρεους $selectedDurationμηνης θητείας'
                    : selectedMetavoli == .ekkremei
                    ? 'Υπέχει στρατολογική εκκρεμότητα'
                    : 'Πραγματοποιήθηκε εξαγορά 1 μήνα θητείας',
                style: TextStyle(fontStyle: .italic),
              ),
            ),
            if (selectedMetavoli == .meiomeni) Gap(padding),
            if (selectedMetavoli == .meiomeni)
              InfoLabel(
                label: 'Διάρκεια Θητείας',
                child: RadioGroup<int>(
                  key: durationKey,
                  groupValue: selectedDuration,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedDuration = newValue ?? selectedDuration;
                    });
                  },
                  child: Row(
                    spacing: padding,
                    children: [
                      RadioButton<int>(
                        value: 6,
                        content: const Text('6 μήνες'),
                      ),
                      RadioButton<int>(
                        value: 9,
                        content: const Text('9 μήνες'),
                      ),
                    ],
                  ),
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
            InfoLabel(
              label: 'Ημερομηνία',
              child: CalendarDatePicker(
                locale: Locale('el'),
                placeholderText:
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
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
            ? Row(children: [ProgressRing(), Gap(10), Text(statusText)])
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await addNewMetavoli(
                        Metavoles(
                          type: selectedMetavoli,
                          date: selectedDate,
                          sailorId: widget.sailor.id,
                          sima: 'WAF ${simaController.text}',
                          duration: selectedDuration,
                        ),
                      );
                      Navigator.pop(context, 'success');
                    } catch (error) {
                      print(error);
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
