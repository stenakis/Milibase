import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/rank.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/objects/specialty.dart';
import 'package:milibase/variables.dart';

import '../main.dart';

class SailorWidgetInfo extends StatefulWidget {
  const SailorWidgetInfo({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetInfo> createState() => _SailorWidgetInfoState();
}

final specialtyKey = GlobalKey<ComboBoxState>(debugLabel: 'Specialty Key');
final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Rank Key');
final monthsKey = GlobalKey<ComboBoxState>(debugLabel: 'Months Key');

class _SailorWidgetInfoState extends State<SailorWidgetInfo> {
  late TextEditingController _controller;
  late Rank selectedRank;
  late Specialty selectedSpecialty;
  late int servingMonths;
  late DateTime? selectedArrivalDate;
  late DateTime? selectedEntryDate;
  late DateTime? selectedRemovalDate;
  late DateTime now = DateTime.now();
  late Future<Sailor> _future;
  @override
  void initState() {
    _controller = TextEditingController();
    selectedSpecialty = widget.sailor.specialty;
    selectedRank = widget.sailor.rank;
    servingMonths = widget.sailor.servingMonths;
    selectedArrivalDate = now;
    selectedEntryDate = now;
    selectedRemovalDate = DateTime(
      now.year,
      now.month + servingMonths,
      now.day,
    );
    _future =
        (db.select(db.tableSailors)
              ..where((t) => t.id.equals(widget.sailor.id)))
            .getSingle()
            .then((row) => Sailor.fromJson(row.toJson()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final sailor = snapshot.data!;
          return ListView(
            padding: .all(padding),
            children: [
              Text('Στοιχεία', style: FluentTheme.of(context).typography.title),
              Gap(padding),
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
                                    placeholder: sailor.surname,
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
                                  child: TextBox(placeholder: sailor.name),
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
                                    placeholder: sailor.agm,
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
                            child: TextBox(placeholder: sailor.address),
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
                                  child: TextBox(placeholder: sailor.mobile),
                                ),
                              ),
                            ),

                            Gap(padding),
                            Expanded(
                              child: InfoLabel(
                                label: 'Σταθερό Τηλέφωνο',
                                child: SizedBox(
                                  height: 40,
                                  child: TextBox(placeholder: sailor.landline),
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
                            child: TextBox(placeholder: sailor.education),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(padding),
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
                            placeholderText:
                                '${sailor.dateInsert.day}/${sailor.dateInsert.month}/${sailor.dateInsert.year}',
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

                      Gap(padding),
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
                      Gap(padding),
                      InfoLabel(
                        label: 'Άφιξη στην Υπηρεσία',
                        child: SizedBox(
                          height: 40,
                          child: CalendarDatePicker(
                            locale: Locale('el'),
                            placeholderText:
                                '${sailor.dateArrival.day}/${sailor.dateArrival.month}/${sailor.dateArrival.year}',
                          ),
                        ),
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Απόλυση',
                        child: SizedBox(
                          height: 40,
                          child: CalendarDatePicker(
                            isTodayHighlighted: false,
                            locale: Locale('el'),
                            placeholderText:
                                '${sailor.dateRemoval.day}/${sailor.dateRemoval.month}/${sailor.dateRemoval.year}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
