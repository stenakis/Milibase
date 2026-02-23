import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/rank.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/objects/specialty.dart';
import 'package:milibase/variables.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: .all(padding),
      children: [
        Text('Στοιχεία', style: FluentTheme.of(context).typography.title),
        Gap(padding),
        InfoLabel(
          label: 'Επώνυμο',
          child: SizedBox(
            height: 40,
            child: TextBox(
              controller: _controller,
              placeholder: widget.sailor.surname,
            ),
          ),
        ),
        Gap(padding),
        InfoLabel(
          label: 'Όνομα',
          child: SizedBox(
            height: 40,
            child: TextBox(placeholder: widget.sailor.name),
          ),
        ),
        Gap(padding),
        InfoLabel(
          label: 'ΑΓΜ',
          child: SizedBox(
            height: 40,
            child: TextBox(
              keyboardType: TextInputType.number,
              placeholder: widget.sailor.agm,
            ),
          ),
        ),
        Gap(padding),
        Row(
          children: [
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
                    return ComboBoxItem<Rank>(value: e, child: Text(e.label));
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
            child: TextBox(placeholder: widget.sailor.address),
          ),
        ),
        Gap(padding),
        InfoLabel(
          label: 'Κινητό Τηλέφωνο',
          child: SizedBox(
            height: 40,
            child: TextBox(placeholder: widget.sailor.mobile),
          ),
        ),
        Gap(padding),
        InfoLabel(
          label: 'Σταθερό Τηλέφωνο',
          child: SizedBox(
            height: 40,
            child: TextBox(placeholder: widget.sailor.landline),
          ),
        ),
        Gap(padding),
        InfoLabel(
          label: 'Γνώσεις / Πτυχίο',
          child: SizedBox(
            height: 40,
            child: TextBox(placeholder: widget.sailor.education),
          ),
        ),

        Gap(padding),
        Row(
          children: [
            InfoLabel(
              label: 'Κατάταξη',
              child: SizedBox(
                height: 40,
                child: CalendarDatePicker(
                  isTodayHighlighted: false,

                  locale: Locale('el'),
                  placeholderText:
                      '${selectedEntryDate!.day}/${selectedEntryDate!.month}/${selectedEntryDate!.year}',
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
                    ComboBoxItem<int>(value: 6, child: Text(6.toString())),
                    ComboBoxItem<int>(value: 9, child: Text(9.toString())),
                    ComboBoxItem<int>(value: 12, child: Text(12.toString())),
                  ],
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

                  placeholderText:
                      '${selectedArrivalDate!.day}/${selectedArrivalDate!.month}/${selectedArrivalDate!.year}',
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
                  placeholderText:
                      '${selectedRemovalDate!.day}/${selectedRemovalDate!.month}/${selectedRemovalDate!.year}',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
