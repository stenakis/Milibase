import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';

class ShowAdeiesDialog extends StatefulWidget {
  const ShowAdeiesDialog({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<ShowAdeiesDialog> createState() => _ShowAdeiesDialogState();
}

class _ShowAdeiesDialogState extends State<ShowAdeiesDialog> {
  bool isLoading = false;
  final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Adeies Key');
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Adeia selectedAdeia = Adeia.kanoniki;
  String statusText = 'Προσθήκη Άδειας';
  TextEditingController simaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        children: [
          const Text('Νέα Άδεια'),
          Spacer(),
          IconButton(
            icon: WindowsIcon(WindowsIcons.chrome_close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: 'Τύπος',
            child: SizedBox(
              height: 40,
              child: ComboBox<Adeia>(
                isExpanded: true,
                value: selectedAdeia,
                key: rankKey,
                onChanged: (Adeia? newValue) {
                  setState(() {
                    selectedAdeia = newValue!;
                  });
                },
                items: Adeia.values.map((Adeia e) {
                  return ComboBoxItem<Adeia>(value: e, child: Text(e.label));
                }).toList(),
              ),
            ),
          ),
          Gap(10),
          if (selectedAdeia == Adeia.oikos_nosileias ||
              selectedAdeia == Adeia.anarrotiki)
            InfoLabel(
              label: 'Σήμα',
              child: SizedBox(
                height: 40,
                child: TextBox(placeholder: 'WAF', controller: simaController),
              ),
            ),
          Gap(10),
          Row(
            children: [
              InfoLabel(
                label: 'Έναρξη',
                child: SizedBox(
                  height: 40,
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
              ),
              Gap(10),
              InfoLabel(
                label: 'Λήξη',
                child: SizedBox(
                  height: 40,
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
              ),
            ],
          ),
        ],
      ),
      actions: [
        isLoading
            ? Row(children: [ProgressRing(), Gap(10), Text(statusText)])
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await addNewAdeia(
                      Adeies(
                        type: selectedAdeia,
                        dateStart: selectedStartDate,
                        dateEnd: selectedEndDate,
                        sailorId: widget.sailor.id,
                        sima: simaController.text,
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
                },
              ),
      ],
    );
  }
}
