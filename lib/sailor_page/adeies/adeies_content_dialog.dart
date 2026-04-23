import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';
import 'package:uuid/uuid.dart';

class ShowAdeiesDialog extends StatefulWidget {
  const ShowAdeiesDialog({super.key, required this.sailor, this.id});
  final Sailor sailor;
  final Adeies? id;
  @override
  State<ShowAdeiesDialog> createState() => _ShowAdeiesDialogState();
}

class _ShowAdeiesDialogState extends State<ShowAdeiesDialog> {
  static final dateFormat = DateFormat('dd/MM/yy', 'el');
  bool isLoading = false;
  final adeiaKey = GlobalKey<ComboBoxState>(debugLabel: 'Adeies Key');
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedStartDate, selectedEndDate;
  late Adeia selectedAdeia;
  late TextEditingController simaController;

  @override
  void initState() {
    selectedAdeia = widget.id == null ? Adeia.kanoniki : widget.id!.type;
    selectedStartDate = widget.id == null
        ? DateTime.now()
        : widget.id!.dateStart;
    selectedEndDate = widget.id == null ? DateTime.now() : widget.id!.dateEnd;
    simaController = TextEditingController(text: widget.id?.sima ?? '');
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
              widget.id == null ? 'Νέα Άδεια' : 'Επεξεργασία Άδειας',
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
              child: ComboBox<Adeia>(
                isExpanded: true,
                value: selectedAdeia,
                key: adeiaKey,
                onChanged: (Adeia? newValue) {
                  setState(() {
                    selectedAdeia = newValue!;
                    simaController.clear();
                  });
                },
                items: Adeia.values.map((Adeia e) {
                  return ComboBoxItem<Adeia>(value: e, child: Text(e.label));
                }).toList(),
              ),
            ),
            const Gap(padding),
            if (selectedAdeia == Adeia.oikos_nosileias ||
                selectedAdeia == Adeia.anarrotiki)
              InfoLabel(
                label: 'Σήμα',
                child: TextFormBox(
                  controller: simaController,
                  placeholder: 'Εισαγωγή σήματος',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Παρακαλώ συμπληρώστε το σήμα';
                    }
                    return null;
                  },
                ),
              ),
            const Gap(10),
            Row(
              children: [
                InfoLabel(
                  label: 'Έναρξη',
                  child: CalendarDatePicker(
                    initialStart: selectedStartDate,
                    isTodayHighlighted: false,
                    locale: Locale('el'),
                    placeholderText: dateFormat.format(
                      widget.id?.dateStart ?? selectedStartDate,
                    ),
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
                const Gap(10),
                InfoLabel(
                  label: 'Λήξη',
                  child: CalendarDatePicker(
                    initialStart: selectedEndDate,
                    isTodayHighlighted: false,
                    locale: Locale('el'),
                    placeholderText: dateFormat.format(
                      widget.id?.dateEnd ?? selectedEndDate,
                    ),
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
            ? Row(
                children: [
                  ProgressRing(),
                  const Gap(10),
                  Text('Αποθήκευση Άδειας'),
                ],
              )
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedStartDate.isAfter(selectedEndDate)) {
                      showCustomInfoBar(
                        context: context,
                        text:
                            'Η ημερομηνία έναρξης πρέπει να είναι πριν την ημερομηνία λήξης.',
                        severity: InfoBarSeverity.warning,
                      );
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final newAdeia = Adeies(
                        id: widget.id != null ? widget.id!.id : Uuid().v4(),
                        type: selectedAdeia,
                        dateStart: selectedStartDate,
                        dateEnd: selectedEndDate,
                        sailorId: widget.sailor.id,
                        sima: simaController.text,
                      );
                      await addNewAdeia(newAdeia);
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
