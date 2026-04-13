import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/templates/delete_button.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../objects/metavoles.dart';
import '../../styles/colors.dart';
import '../../templates/info_bar.dart';
import 'metavoles_content_dialog.dart';
import 'metavoles_functions.dart';

class SailorWidgetMetavoles extends StatefulWidget {
  const SailorWidgetMetavoles({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<SailorWidgetMetavoles> createState() => _SailorWidgetMetavolesState();
}

class _SailorWidgetMetavolesState extends State<SailorWidgetMetavoles> {
  final _metavoliKey = GlobalKey<ComboBoxState>(debugLabel: 'Metavoli Key');
  late Stream<List<Metavoles>> _stream;
  Metavoli? selectedMetavoli;
  bool isLoading = false;

  @override
  void initState() {
    _stream =
        (db.select(
          db.tableMetavoles,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).watch().map(
          (rows) =>
              rows.map((row) => Metavoles.fromJson(row.toJson())).toList(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Metavoles>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        }
        if (snapshot.hasError) {
          showCustomInfoBar(
            context: context,
            text: snapshot.error.toString(),
          );
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Metavoles> metavoles = snapshot.data!;
          final List<Metavoles> selectedList = selectedMetavoli == null
              ? metavoles
              : metavoles
                    .where((metavoli) => metavoli.type == selectedMetavoli)
                    .toList();
          final sortedMetavoles = selectedList.toList()
            ..sort((a, b) => a.date.compareTo(b.date));
          return Padding(
            padding: .symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Gap(padding),
                Row(
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      'Μεταβολές',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        children: [
                          Icon(FluentIcons.add),
                          Gap(5),
                          Text('Νέα Μεταβολή'),
                        ],
                      ),
                      onPressed: () => showContentDialog(context, null),
                    ),
                    Gap(padding),

                    if (metavoles.isNotEmpty)
                      ComboBox<Metavoli>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            Gap(5),
                            Text(selectedMetavoli?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: selectedMetavoli,
                        key: _metavoliKey,
                        onChanged: (Metavoli? metavoli) {
                          setState(() {
                            selectedMetavoli = metavoli!;
                          });
                        },
                        items:
                            (Metavoli.values.toList()
                                  ..sort((a, b) => a.label.compareTo(b.label)))
                                .map((Metavoli e) {
                                  return ComboBoxItem<Metavoli>(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                })
                                .toList(),
                      ),
                    if (selectedMetavoli != null)
                      IconButton(
                        onPressed: () => setState(() {
                          selectedMetavoli = null;
                        }),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                if (metavoles.isNotEmpty) Gap(padding * 1.5),
                Gap(10),
                metavoles.isEmpty
                    ? Text('Δεν υπάρχουν καταχωρημένες μεταβολές.')
                    : Container(
                        decoration: BoxDecoration(
                          color: secColor,
                          borderRadius: .only(
                            topRight: .circular(5),
                            topLeft: .circular(5),
                          ),
                        ),
                        padding: .symmetric(horizontal: padding, vertical: 10),
                        child: Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              flex: col1Flex,
                              child: Text(
                                'Τύπος',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col2Flex,
                              child: Text(
                                'Ημερομηνία',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col3Flex,
                              child: Text(
                                'Σήμα',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col6Flex,
                              child: Text(
                                '',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                Expanded(
                  child: ListView.separated(
                    padding: .only(bottom: padding),
                    separatorBuilder: (context, _) => Divider(),
                    itemCount: metavoles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final metavoli = sortedMetavoles[index];
                      final isLast = index == metavoles.length - 1;
                      final bottomRadius = Radius.circular(isLast ? 5 : 0);
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: .only(
                            bottomLeft: bottomRadius,
                            bottomRight: bottomRadius,
                          ),
                        ),

                        padding: .symmetric(
                          horizontal: padding,
                          vertical: padding - 5,
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              flex: col1Flex,
                              child: Text(
                                metavoli.type == .meiomeni
                                    ? 'Μεταφέρθηκε στους υπόχρεους ${metavoli.duration}μηνης θητείας'
                                    : metavoli.type == .ekkremei
                                    ? 'Υπέχει στρατολογική εκκρεμότητα'
                                    : 'Πραγματοποιήθηκε εξαγορά 1 μήνα θητείας',
                              ),
                            ),
                            Expanded(
                              flex: col2Flex,
                              child: Text(
                                DateFormat(
                                  'EEE dd MMM yy',
                                  'el',
                                ).format(metavoli.date),
                              ),
                            ),
                            Expanded(
                              flex: col3Flex,
                              child: Text(metavoli.sima),
                            ),
                            Expanded(
                              flex: col6Flex,
                              child: Row(
                                mainAxisAlignment: .end,
                                children: [
                                  IconButton(
                                    icon: const WindowsIcon(WindowsIcons.edit),
                                    onPressed: () =>
                                        showContentDialog(context, metavoli),
                                  ),
                                  Gap(5),
                                  DeleteFlyout(
                                    title: 'Διαγραφή μεταβολής;',
                                    onPressed: () async {
                                      await deleteMetavoli(metavoli.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Άγνωστο σφάλμα'));
        }
      },
    );
  }

  void showContentDialog(BuildContext context, Metavoles? metavoli) async {
    await showDialog<String>(
      context: context,
      builder: (context) =>
          ShowMetavolesDialog(sailor: widget.sailor, id: metavoli),
    );
  }
}
