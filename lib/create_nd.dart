import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'db/add_nd.dart';
import 'objects/sailor.dart';
import 'variables.dart';
import 'objects/rank.dart';
import 'objects/specialty.dart';

class ShowCreateNdDialog extends StatefulWidget {
  final Sailor? sailor;
  const ShowCreateNdDialog({super.key, this.sailor});

  @override
  State<ShowCreateNdDialog> createState() => _ShowCreateNdDialogState();
}

final specialtyKey = GlobalKey<ComboBoxState>(debugLabel: 'Specialty Key 1');
final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Rank Key 1');
final monthsKey = GlobalKey<ComboBoxState>(debugLabel: 'Months Key 1');

class _ShowCreateNdDialogState extends State<ShowCreateNdDialog> {
  bool isLoading = false;
  late TextEditingController surnameController,
      nameController,
      agmController,
      addressController,
      mobileController,
      landlineController,
      educationController;
  late Rank selectedRank;
  late Specialty selectedSpecialty;
  late int servingMonths;
  late DateTime? selectedArrivalDate;
  late DateTime? selectedEntryDate;
  late DateTime? selectedRemovalDate;
  final validateKey = GlobalKey<FormState>();
  late DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    surnameController = TextEditingController(
      text: widget.sailor?.surname ?? "",
    );
    nameController = TextEditingController(text: widget.sailor?.name ?? "");
    agmController = TextEditingController(text: widget.sailor?.agm ?? "");
    addressController = TextEditingController(
      text: widget.sailor?.address ?? "",
    );
    mobileController = TextEditingController(text: widget.sailor?.mobile ?? "");
    landlineController = TextEditingController(
      text: widget.sailor?.landline ?? "",
    );
    educationController = TextEditingController(
      text: widget.sailor?.education ?? "",
    );
    selectedSpecialty = widget.sailor?.specialty ?? .diax;
    selectedRank = widget.sailor?.rank ?? .naftis;
    servingMonths = widget.sailor?.servingMonths ?? 12;
    selectedArrivalDate = widget.sailor?.dateArrival ?? now;
    selectedEntryDate = widget.sailor?.dateInsert ?? now;

    selectedRemovalDate =
        widget.sailor?.dateRemoval ??
        DateTime(now.year, now.month + servingMonths, now.day);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: .tightFor(
        width: MediaQuery.of(context).size.width * 75 / 100,
      ),
      title: Row(
        children: [
          Text(widget.sailor == null ? 'Προσθήκη Ν/Δ' : 'Επεξεργασία Ν/Δ'),
          Spacer(),
          IconButton(
            icon: WindowsIcon(WindowsIcons.chrome_close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Form(
        key: validateKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Gap(10),
            Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InfoLabel(
                              label: 'Επώνυμο',
                              child: TextFormBox(
                                controller: surnameController,
                                placeholder: widget.sailor?.surname ?? '',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Παρακαλώ συμπληρώστε επίθετο';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Gap(padding),
                          Expanded(
                            child: InfoLabel(
                              label: 'Όνομα',
                              child: TextFormBox(
                                controller: nameController,
                                placeholder: widget.sailor?.name ?? '',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Παρακαλώ συμπληρώστε όνομα';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(padding),
                      Row(
                        children: [
                          Expanded(
                            child: InfoLabel(
                              label: 'ΑΓΜ',
                              child: TextFormBox(
                                controller: agmController,
                                maxLength: 5,
                                placeholder: widget.sailor?.agm ?? '',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Παρακαλώ συμπληρώστε ΑΓΜ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Gap(padding),
                          InfoLabel(
                            label: 'Βαθμός',
                            child: SizedBox(
                              height: 40,
                              child: ComboBox<Rank>(
                                value: selectedRank,
                                key: rankKey,
                                onChanged: (Rank? newValue) {
                                  setState(() {
                                    selectedRank = newValue!;
                                  });
                                },
                                items: Rank.values.map((Rank e) {
                                  return ComboBoxItem<Rank>(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Gap(padding),
                          InfoLabel(
                            label: 'Ειδικότητα',
                            child: SizedBox(
                              height: 40,
                              child: ComboBox<Specialty>(
                                isExpanded: false,
                                value: selectedSpecialty,
                                key: specialtyKey,
                                onChanged: (Specialty? newSpecialty) {
                                  setState(() {
                                    selectedSpecialty = newSpecialty!;
                                  });
                                },
                                items: Specialty.values.map((Specialty e) {
                                  return ComboBoxItem<Specialty>(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Διεύθυνση',
                        child: TextFormBox(
                          controller: addressController,
                          placeholder: widget.sailor?.address ?? '',
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Παρακαλώ συμπληρώστε διεύθυνση';
                            }
                            return null;
                          },
                        ),
                      ),

                      Gap(padding),
                      Row(
                        children: [
                          Expanded(
                            child: InfoLabel(
                              label: 'Κινητό τηλέφωνο',
                              child: TextFormBox(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"),
                                  ),
                                ],
                                controller: mobileController,
                                placeholder: widget.sailor?.mobile ?? '',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Παρακαλώ συμπληρώστε κινητό';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Gap(padding),
                          Expanded(
                            child: InfoLabel(
                              label: 'Σταθερό τηλέφωνο',
                              child: TextFormBox(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"),
                                  ),
                                ],
                                controller: landlineController,
                                placeholder: widget.sailor?.landline ?? '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Γνώσεις / Πτυχίο',
                        child: TextFormBox(
                          controller: educationController,
                          placeholder: widget.sailor?.education ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(padding * 2),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    InfoLabel(
                      label: 'Κατάταξη',
                      child: CalendarDatePicker(
                        isTodayHighlighted: false,
                        locale: Locale('el'),
                        placeholderText: DateFormat(
                          'dd/MM/yyyy',
                        ).format(selectedEntryDate!),
                        onSelectionChanged: (change) => setState(() {
                          selectedEntryDate = DateTime(
                            change.startDate!.year,
                            change.startDate!.month,
                            change.startDate!.day,
                          );
                          selectedRemovalDate = DateTime(
                            change.startDate!.year,
                            change.startDate!.month + servingMonths,
                            change.startDate!.day,
                          );
                        }),
                      ),
                    ),
                    Gap(10),
                    InfoLabel(
                      label: 'Άφιξη στην Υπηρεσία',
                      child: CalendarDatePicker(
                        locale: Locale('el'),
                        placeholderText: DateFormat(
                          'dd/MM/yyyy',
                        ).format(selectedArrivalDate!),
                        onSelectionChanged: (change) => setState(() {
                          selectedArrivalDate = DateTime(
                            change.startDate!.year,
                            change.startDate!.month,
                            change.startDate!.day,
                          );
                        }),
                      ),
                    ),
                    Gap(10),
                    InfoLabel(
                      label: 'Μήνες Υπηρεσίας',
                      child: ComboBox<int>(
                        value: servingMonths,
                        key: monthsKey,
                        onChanged: (int? newMonths) {
                          setState(() {
                            servingMonths = newMonths!;
                            selectedRemovalDate = DateTime(
                              selectedEntryDate!.year,
                              selectedEntryDate!.month + newMonths,
                              selectedEntryDate!.day,
                            );
                          });
                        },
                        items: [
                          ComboBoxItem<int>(
                            value: 6,
                            child: Text(6.toString()),
                          ),
                          ComboBoxItem<int>(
                            value: 9,
                            child: Text(9.toString()),
                          ),
                          ComboBoxItem<int>(
                            value: 12,
                            child: Text(12.toString()),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    InfoLabel(
                      label: 'Απόλυση',
                      child: CalendarDatePicker(
                        isTodayHighlighted: false,
                        locale: Locale('el'),
                        placeholderText: DateFormat(
                          'dd/MM/yyyy',
                        ).format(selectedRemovalDate!),
                        onSelectionChanged: (change) => setState(() {
                          selectedRemovalDate = DateTime(
                            change.startDate!.year,
                            change.startDate!.month,
                            change.startDate!.day,
                          );
                        }),
                      ),
                    ),
                    Gap(padding * 4),
                    isLoading
                        ? Row(
                            children: [
                              ProgressRing(),
                              Gap(10),
                              Text('Καταχώρηση...'),
                            ],
                          )
                        : FilledButton(
                            child: Row(
                              children: [
                                WindowsIcon(WindowsIcons.add),
                                Gap(10),
                                Text('Υποβολή'),
                              ],
                            ),
                            onPressed: () async {
                              if (validateKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  final newSailor = Sailor(
                                    id: widget.sailor?.id ?? '',
                                    name: nameController.text,
                                    surname: surnameController.text,
                                    agm: agmController.text,
                                    specialty: selectedSpecialty,
                                    address: addressController.text,
                                    mobile: mobileController.text,
                                    landline: landlineController.text,
                                    education: educationController.text,
                                    dateArrival: selectedArrivalDate!,
                                    dateInsert: selectedEntryDate!,
                                    dateRemoval: selectedRemovalDate!,
                                    rank: selectedRank,
                                    servingMonths: servingMonths,
                                  );

                                  addND(newSailor);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(
                                    context,
                                    widget.sailor != null ? newSailor : null,
                                  );
                                } catch (error) {
                                  await displayInfoBar(
                                    context,
                                    duration: Duration(seconds: 5),
                                    builder: (context, close) {
                                      return InfoBar(
                                        title: const Text('An error occurred:'),
                                        content: Text(error.toString()),
                                        action: IconButton(
                                          icon: const WindowsIcon(
                                            WindowsIcons.error,
                                          ),
                                          onPressed: close,
                                        ),
                                        severity: InfoBarSeverity.error,
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
