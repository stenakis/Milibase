import 'package:drift/native.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/add_nd.dart';
import 'package:milibase/variables.dart';

import 'objects/rank.dart';
import 'objects/specialty.dart';

class ShowCreateNdDialog extends StatefulWidget {
  const ShowCreateNdDialog({super.key});

  @override
  State<ShowCreateNdDialog> createState() => _ShowCreateNdDialogState();
}

final specialtyKey = GlobalKey<ComboBoxState>(debugLabel: 'Specialty Key 1');
final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Rank Key 1');
final monthsKey = GlobalKey<ComboBoxState>(debugLabel: 'Months Key 1');

class _ShowCreateNdDialogState extends State<ShowCreateNdDialog> {
  bool isLoading = false;
  late TextEditingController _controller;
  late Rank selectedRank;
  late Specialty selectedSpecialty;
  late int servingMonths;
  late DateTime? selectedArrivalDate;
  late DateTime? selectedEntryDate;
  late DateTime? selectedRemovalDate;
  late DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    selectedSpecialty = .diax;
    selectedRank = .naftis;
    servingMonths = 12;
    selectedArrivalDate = now;
    selectedEntryDate = now;
    selectedRemovalDate = DateTime(
      now.year,
      now.month + servingMonths,
      now.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: .tightFor(
        width: MediaQuery.of(context).size.width * 75 / 100,
      ),
      title: Row(
        children: [
          const Text('Προσθήκη Ν/Δ'),
          Spacer(),
          IconButton(
            icon: WindowsIcon(WindowsIcons.chrome_close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
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
                            child: SizedBox(
                              height: 40,
                              child: TextBox(
                                controller: _controller,
                                placeholder: '',
                              ),
                            ),
                          ),
                        ),
                        Gap(padding),
                        Expanded(
                          child: InfoLabel(
                            label: 'Όνομα',
                            child: SizedBox(
                              height: 40,
                              child: TextBox(placeholder: ''),
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
                            child: SizedBox(
                              height: 40,
                              child: TextBox(
                                keyboardType: TextInputType.number,
                                placeholder: '',
                              ),
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
                      child: SizedBox(
                        height: 40,
                        child: TextBox(placeholder: ''),
                      ),
                    ),
                    Gap(padding),
                    Row(
                      children: [
                        Expanded(
                          child: InfoLabel(
                            label: 'Κινητό Τηλέφωνο',
                            child: SizedBox(
                              height: 40,
                              child: TextBox(placeholder: ''),
                            ),
                          ),
                        ),

                        Gap(padding),
                        Expanded(
                          child: InfoLabel(
                            label: 'Σταθερό Τηλέφωνο',
                            child: SizedBox(
                              height: 40,
                              child: TextBox(placeholder: ''),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(padding),
                    InfoLabel(
                      label: 'Γνώσεις / Πτυχίο',
                      child: SizedBox(
                        height: 40,
                        child: TextBox(placeholder: ''),
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
                    child: SizedBox(
                      height: 40,
                      child: CalendarDatePicker(
                        isTodayHighlighted: false,
                        locale: Locale('el'),
                        placeholderText: '${now.day}/${now.month}/${now.year}',
                        onSelectionChanged: (change) => setState(() {
                          selectedRemovalDate = DateTime(
                            change.startDate!.year,
                            change.startDate!.month + servingMonths,
                            change.startDate!.day,
                          );
                        }),
                      ),
                    ),
                  ),

                  Gap(10),

                  InfoLabel(
                    label: 'Άφιξη στην Υπηρεσία',
                    child: SizedBox(
                      height: 40,
                      child: CalendarDatePicker(
                        locale: Locale('el'),
                        placeholderText: '${now.day}/${now.month}/${now.year}',
                      ),
                    ),
                  ),
                  Gap(10),
                  InfoLabel(
                    label: 'Μήνες Υπηρεσίας',
                    child: SizedBox(
                      height: 40,
                      child: ComboBox<int>(
                        value: servingMonths,
                        key: monthsKey,
                        onChanged: (int? newMonths) {
                          setState(() {
                            servingMonths = newMonths!;
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
                  ),
                  Gap(10),
                  InfoLabel(
                    label: 'Απόλυση',
                    child: SizedBox(
                      height: 40,
                      child: CalendarDatePicker(
                        isTodayHighlighted: false,
                        locale: Locale('el'),
                        placeholderText: '${now.day}/${now.month}/${now.year}',
                      ),
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
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              addND();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context, 'success');
                            } on SqliteException catch (e) {
                              await displayInfoBar(
                                context,
                                duration: Duration(seconds: 5),
                                builder: (context, close) {
                                  String errorText =
                                      e.extendedResultCode == 1555
                                      ? 'A sailor with this ID already exists!'
                                      : e.extendedResultCode.toString();
                                  return InfoBar(
                                    title: Text(errorText),
                                    content: Text(
                                      e.extendedResultCode.toString(),
                                    ),
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
                              // Handle specific SQLite errors
                              print(
                                'SQLite Error Code: ${e.extendedResultCode}',
                              );
                              print('Message: ${e.message}');

                              if (e.extendedResultCode == 1555) {
                                // Unique constraint failed code
                                print('A sailor with this ID already exists!');
                              }
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
                          },
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
