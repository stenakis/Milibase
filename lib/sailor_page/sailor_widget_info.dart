import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/create_nd.dart';
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
  late Rank selectedRank;
  late Specialty selectedSpecialty;
  late int servingMonths;
  late DateTime? selectedArrivalDate;
  late DateTime? selectedEntryDate;
  late DateTime? selectedRemovalDate;
  late DateTime now = DateTime.now();
  late Future<Sailor> _future;
  late Sailor _currentSailor;

  void setFuture() {
    _future =
        (db.select(db.tableSailors)
              ..where((t) => t.id.equals(_currentSailor.id)))
            .getSingle()
            .then((row) => Sailor.fromJson(row.toJson()));
  }

  @override
  void initState() {
    _currentSailor = widget.sailor;
    selectedSpecialty = _currentSailor.specialty;
    selectedRank = _currentSailor.rank;
    servingMonths = _currentSailor.servingMonths;
    selectedArrivalDate = now;
    selectedEntryDate = now;
    selectedRemovalDate = DateTime(
      now.year,
      now.month + servingMonths,
      now.day,
    );
    setFuture();

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
            padding: .all(padding + 10),
            children: [
              Row(
                children: [
                  Text(
                    'Στοιχεία',
                    style: FluentTheme.of(context).typography.title,
                  ),
                  Spacer(),
                  FilledButton(
                    child: Row(
                      children: [
                        WindowsIcon(WindowsIcons.edit),
                        Gap(10),
                        Text('Επεξεργασία'),
                      ],
                    ),
                    onPressed: () => showContentDialog(context),
                  ),
                ],
              ),
              Gap(padding * 2),
              Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            InfoLabel(
                              label: 'Επώνυμο',
                              child: Text(
                                sailor.surname,
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Gap(padding * 2),
                            InfoLabel(
                              label: 'Όνομα',
                              child: Text(
                                sailor.name,
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(padding),
                        Row(
                          children: [
                            InfoLabel(
                              label: 'ΑΓΜ',
                              child: Text(
                                sailor.agm,
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Gap(padding * 2),
                            InfoLabel(
                              label: 'Βαθμός',
                              child: Text(
                                '${sailor.rank.label} (${sailor.specialty.label})',
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(padding),
                        InfoLabel(
                          label: 'Κινητό Τηλέφωνο',
                          child: Text(
                            sailor.mobile,
                            style: TextStyle(fontWeight: .bold, fontSize: 24),
                          ),
                        ),

                        Gap(padding),
                        Row(
                          crossAxisAlignment: .end,
                          children: [
                            Text('Σταθερό Τηλέφωνο: '),
                            Text(
                              sailor.landline,
                              style: TextStyle(fontWeight: .bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Gap(padding),
                        Row(
                          crossAxisAlignment: .end,
                          children: [
                            Text('Διεύθυνση: '),
                            Text(
                              sailor.address,
                              style: TextStyle(fontWeight: .bold, fontSize: 16),
                            ),
                          ],
                        ),

                        Gap(padding),
                        Row(
                          crossAxisAlignment: .end,
                          children: [
                            Text('Γνώσεις / Πτυχίο: '),
                            Text(
                              sailor.education,
                              style: TextStyle(fontWeight: .bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(padding),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      InfoLabel(
                        label: 'Μήνες Υπηρεσίας',
                        child: Text(
                          sailor.servingMonths.toString(),
                          style: TextStyle(fontWeight: .bold, fontSize: 18),
                        ),
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Κατάταξη',
                        child: Text(
                          locale: .new('el'),
                          DateFormat(
                            'EEE dd MMM yy',
                            'el',
                          ).format(_currentSailor.dateInsert),
                          style: TextStyle(fontWeight: .bold, fontSize: 18),
                        ),
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Άφιξη στην Υπηρεσία',
                        child: Text(
                          DateFormat(
                            'EEE dd MMM yy',
                            'el',
                          ).format(_currentSailor.dateArrival),
                          style: TextStyle(fontWeight: .bold, fontSize: 18),
                        ),
                      ),
                      Gap(padding),
                      InfoLabel(
                        label: 'Απόλυση',
                        child: Text(
                          DateFormat(
                            'EEE dd MMM yy',
                            'el',
                          ).format(_currentSailor.dateRemoval),
                          style: TextStyle(fontWeight: .bold, fontSize: 18),
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

  void showContentDialog(BuildContext context) async {
    final result = await showDialog<Sailor>(
      context: context,
      builder: (context) => ShowCreateNdDialog(sailor: _currentSailor),
    );

    if (result != null) {
      setFuture();
      setState(() {
        _currentSailor = result;
      });
    }
  }
}
