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
  static final dateFormat = DateFormat('dd/MM/yy', 'el');
  bool isLoading = false;
  final apomakrynsiKey = GlobalKey<ComboBoxState>(
    debugLabel: 'Apomakrynseis Key',
  );
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedStartDate, selectedEndDate;
  late Apomakrynsi selectedApomakrynsi;
  late TextEditingController simaController;
  late TextEditingController ypiresiaController;
  bool enableEnd = true;

  @override
  void initState() {
    selectedApomakrynsi = widget.id == null
        ? Apomakrynsi.apospasi
        : widget.id!.type;
    selectedStartDate = widget.id == null
        ? DateTime.now()
        : widget.id!.dateStart;
    selectedEndDate = widget.id == null ? DateTime.now() : widget.id!.dateEnd;
    simaController = TextEditingController(text: widget.id?.sima ?? "");
    ypiresiaController = TextEditingController(text: widget.id?.ypiresia ?? "");
    super.initState();
  }

  @override
  void dispose() {
    simaController.dispose();
    ypiresiaController.dispose();
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
              widget.id == null
                  ? 'Νέα Απομάκρυνση'
                  : 'Επεξεργασία Απομάκρυνσης',
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
              child: ComboBox<Apomakrynsi>(
                isExpanded: true,
                value: selectedApomakrynsi,
                key: apomakrynsiKey,
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
            const Gap(padding),
            InfoLabel(
              label: 'Υπηρεσία',
              child: TextFormBox(
                placeholder: 'Εισαγωγή υπηρεσίας',
                controller: ypiresiaController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Παρακαλώ συμπληρώστε την υπηρεσία';
                  }
                  return null;
                },
              ),
            ),
            const Gap(padding),
            InfoLabel(
              label: 'Σήμα',
              child: TextFormBox(
                placeholder: 'Επεξεργασία σήματος',
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
            Row(
              crossAxisAlignment: .start,
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
                      selectedStartDate = data.selectedDates.first;
                      if (widget.id == null) {
                        selectedEndDate = data.selectedDates.first;
                      }
                    },
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        Text('Λήξη'),
                        const Gap(10),
                        ToggleSwitch(
                          checked: enableEnd,
                          onChanged: (change) =>
                              setState(() => enableEnd = change),
                        ),
                      ],
                    ),

                    enableEnd
                        ? CalendarDatePicker(
                            initialStart: selectedEndDate,
                            isTodayHighlighted: false,
                            locale: Locale('el'),
                            placeholderText: dateFormat.format(
                              widget.id?.dateEnd ?? selectedEndDate,
                            ),
                            onSelectionChanged: (CalendarSelectionData data) {
                              selectedEndDate = data.selectedDates.first;
                            },
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        isLoading
            ? const Row(
                children: [
                  ProgressRing(),
                  Gap(10),
                  Text('Αποθήκευση Απομάκρυνσης'),
                ],
              )
            : Row(
                mainAxisAlignment: .end,
                children: [
                  if (widget.id != null)
                    Button(
                      onPressed: () async {
                        try {
                          await deleteApomakrynsi(widget.id!);
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
                          Gap(5),
                          const Text('Διαγραφή'),
                        ],
                      ),
                    ),
                  if (widget.id != null) Gap(10),
                  FilledButton(
                    autofocus: true,
                    child: Row(
                      children: [
                        WindowsIcon(WindowsIcons.save),
                        Gap(5),
                        Text(widget.id == null ? 'Εισαγωγή' : 'Αποθήκευση'),
                      ],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectedStartDate.isAfter(selectedEndDate)) {
                          showCustomInfoBar(
                            context: context,
                            text:
                                'Η ημερομηνία έναρξης πρέπει να είναι πριν την ημερομηνία λήξης.',
                            severity: .warning,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final newApomakrynsi = Apomakrynseis(
                              id: widget.id != null
                                  ? widget.id!.id
                                  : Uuid().v4(),
                              type: selectedApomakrynsi,
                              dateStart: selectedStartDate,
                              dateEnd: enableEnd
                                  ? selectedEndDate
                                  : widget.sailor.dateRemoval,
                              sailorId: widget.sailor.id,
                              sima: simaController.text,
                              ypiresia: ypiresiaController.text,
                            );
                            await addNewApomakrynsi(newApomakrynsi);
                            if (context.mounted && mounted) {
                              Navigator.pop(context);
                            }
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
              ),
      ],
    );
  }
}
