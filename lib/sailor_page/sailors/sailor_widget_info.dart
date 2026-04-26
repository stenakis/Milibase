import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/create_nd.dart';
import 'package:milibase/sailor_page/sailors/calendar_view.dart';
import 'package:milibase/sailor_page/sailors/info_widget.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';
import '../../main.dart';

class SailorWidgetInfo extends StatefulWidget {
  const SailorWidgetInfo({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<SailorWidgetInfo> createState() => _SailorWidgetInfoState();
}

class _SailorWidgetInfoState extends State<SailorWidgetInfo> {
  final DateTime now = DateTime.now();
  late Stream<Sailor> _stream;
  @override
  void initState() {
    _stream =
        (db.select(db.tableSailors)
              ..where((t) => t.id.equals(widget.sailor.id)))
            .watchSingle()
            .map((row) => Sailor.fromJson(row.toJson()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Sailor>(
      stream: _stream,
      initialData: widget.sailor,
      builder: (context, snapshot) {
        final sailor = snapshot.data!;

        return Row(
          children: [
            Expanded(
              child: ListView(
                padding: .all(padding),
                children: [
                  Row(
                    children: [
                      Text(
                        'Επισκόπηση',
                        style: FluentTheme.of(context).typography.title,
                      ),
                      Spacer(),
                      FilledButton(
                        child: Row(
                          children: [
                            WindowsIcon(WindowsIcons.edit),
                            const Gap(10),
                            Text('Επεξεργασία'),
                          ],
                        ),
                        onPressed: () => showContentDialog(context),
                      ),
                    ],
                  ),
                  const Gap(padding),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      spacing: 10,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: .all(.circular(5)),
                            child: Container(
                              color: secColor,
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Gap(10),
                                  Text(
                                    'Κατάταξη',
                                    textAlign: .center,
                                    style: FluentTheme.of(context)
                                        .typography
                                        .body
                                        ?.copyWith(fontWeight: .bold),
                                  ),
                                  Gap(10),
                                  Container(
                                    width: double.infinity,
                                    padding: .symmetric(vertical: padding / 2),
                                    color: Colors.white,
                                    child: Text(
                                      textAlign: .center,
                                      DateFormat(
                                        'dd/MM/yy',
                                        'el',
                                      ).format(sailor.dateInsert),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: .all(.circular(5)),
                            child: Container(
                              color: secColor,
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Gap(10),
                                  Text(
                                    'Άφιξη στην Υπηρεσία',
                                    textAlign: .center,
                                    style: FluentTheme.of(context)
                                        .typography
                                        .body
                                        ?.copyWith(fontWeight: .bold),
                                  ),
                                  Gap(10),
                                  Container(
                                    width: double.infinity,
                                    padding: .symmetric(vertical: padding / 2),
                                    color: Colors.white,
                                    child: Text(
                                      textAlign: .center,
                                      DateFormat(
                                        'dd/MM/yy',
                                        'el',
                                      ).format(sailor.dateArrival),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: .all(.circular(5)),
                            child: Container(
                              color: secColor,
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Gap(10),
                                  Text(
                                    'Απόλυση',
                                    textAlign: .center,
                                    style: FluentTheme.of(context)
                                        .typography
                                        .body
                                        ?.copyWith(fontWeight: .bold),
                                  ),
                                  Gap(10),
                                  Container(
                                    width: double.infinity,
                                    padding: .symmetric(vertical: padding / 2),
                                    color: Colors.white,
                                    child: Text(
                                      textAlign: .center,
                                      DateFormat(
                                        'dd/MM/yy',
                                        'el',
                                      ).format(sailor.dateRemoval),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(padding),
                  InfoOverview(
                    title: 'Στρατιωτικά στοιχεία',
                    items: [
                      {'ΑΓΜ': widget.sailor.agm},
                      {
                        'Βαθμός / Ειδικότητα':
                            '${widget.sailor.rank.label} (${widget.sailor.specialty.label})',
                      },
                    ],
                  ),
                  const Gap(padding),
                  InfoOverview(
                    title: 'Προσωπικά στοιχεία',
                    items: [
                      {'Κινητό': sailor.mobile},
                      {'Σταθερό': sailor.landline},
                      {'Διεύθυνση': sailor.address},
                      {'Γνώσεις/Πτυχίο': sailor.education},
                    ],
                  ),
                ],
              ),
            ),
            Gap(padding),
            Expanded(child: SailorCalendarOverview(sailor: sailor)),
          ],
        );
      },
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<Sailor>(
      context: context,
      builder: (context) => ShowCreateNdDialog(sailor: widget.sailor),
    );
  }
}
