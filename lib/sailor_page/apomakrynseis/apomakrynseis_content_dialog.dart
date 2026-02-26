import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_functions.dart';

class ShowApomakrynseisDialog extends StatefulWidget {
  const ShowApomakrynseisDialog({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<ShowApomakrynseisDialog> createState() => _ShowApomakrynseisDialog();
}

class _ShowApomakrynseisDialog extends State<ShowApomakrynseisDialog> {
  bool isLoading = false;
  final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Apomakrynseis Key');
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Apomakrynsi selectedApomakrynsi = Apomakrynsi.apospasi;
  String statusText = 'Προσθήκη Απομάκρυνσης';
  TextEditingController simaController = TextEditingController();
  TextEditingController ypiresiaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Νέα Απομάκρυνση'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: 'Τύπος',
            child: SizedBox(
              height: 40,
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
          ),
          Gap(10),
          InfoLabel(
            label: 'Υπηρεσία',
            child: SizedBox(
              height: 40,
              child: TextBox(
                placeholder: 'Εισαγωγή υπηρεσίας',
                controller: ypiresiaController,
              ),
            ),
          ),
          Gap(10),
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
                    isTodayHighlighted: false,
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
                    isTodayHighlighted: false,
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
        Button(
          child: const Text('Άκυρο'),
          onPressed: () {
            Navigator.pop(context, 'User deleted file');
          },
        ),
        isLoading
            ? Row(
                children: [
                  Expanded(child: Text(statusText)),
                  isLoading ? Container() : Gap(10),
                  isLoading ? Container() : ProgressRing(),
                ],
              )
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
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
                },
              ),
      ],
    );
  }
}
