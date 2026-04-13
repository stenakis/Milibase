import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_content_dialog.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/templates/delete_button.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../templates/info_bar.dart';

class SailorWidgetAdeies extends StatefulWidget {
  const SailorWidgetAdeies({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<SailorWidgetAdeies> createState() => _SailorWidgetAdeiesState();
}

class _SailorWidgetAdeiesState extends State<SailorWidgetAdeies> {
  final _adeiaKey = GlobalKey<ComboBoxState>(debugLabel: 'Adeia Key');
  late Stream<List<Adeies>> _stream;
  Adeia? selectedAdeia;
  bool isLoading = false;

  late int daysKanoniki;
  @override
  void initState() {
    if (widget.sailor.servingMonths == 6) {
      daysKanoniki = 9;
    } else if (widget.sailor.servingMonths == 9) {
      daysKanoniki = 15;
    } else {
      daysKanoniki = 18;
    }
    _stream =
        (db.select(
          db.tableAdeies,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).watch().map(
          (rows) => rows.map((row) => Adeies.fromJson(row.toJson())).toList(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Adeies>>(
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
          final List<Adeies> adeies = snapshot.data!;
          final List<Adeies> selectedList = selectedAdeia == null
              ? adeies
              : adeies.where((adeia) => adeia.type == selectedAdeia).toList();
          final sortedAdeies = selectedList.toList()
            ..sort((a, b) => a.dateStart.compareTo(b.dateStart));

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
                      'Άδειες',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        children: [
                          Icon(FluentIcons.add),
                          Gap(5),
                          Text('Νέα Άδεια'),
                        ],
                      ),
                      onPressed: () => showContentDialog(context, null),
                    ),
                    Gap(padding),
                    if (adeies.isNotEmpty)
                      ComboBox<Adeia>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            Gap(5),
                            Text(selectedAdeia?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: selectedAdeia,
                        key: _adeiaKey,
                        onChanged: (Adeia? adeia) {
                          setState(() {
                            selectedAdeia = adeia!;
                          });
                        },
                        items:
                            (Adeia.values.toList()
                                  ..sort((a, b) => a.label.compareTo(b.label)))
                                .map((Adeia e) {
                                  return ComboBoxItem<Adeia>(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                })
                                .toList(),
                      ),
                    if (selectedAdeia != null)
                      IconButton(
                        onPressed: () => setState(() {
                          selectedAdeia = null;
                        }),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                Gap(padding),
                Wrap(
                  alignment: .start,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...Adeia.values.map((adeiaType) {
                      final totalDays = adeies
                          .where((item) => item.type == adeiaType)
                          .fold<int>(
                            0,
                            (sum, item) =>
                                sum +
                                item.dateEnd.difference(item.dateStart).inDays +
                                1,
                          );
                      if (totalDays == 0) {
                        return const SizedBox.shrink();
                      }
                      String days = totalDays == 1 ? 'ημέρα' : 'ημέρες';
                      final labelText = adeiaType == .kanoniki
                          ? '${adeiaType.label}: $totalDays/$daysKanoniki ημέρες'
                          : '${adeiaType.label}: $totalDays $days';
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              adeiaType == .kanoniki && totalDays > daysKanoniki
                              ? Colors.orange.withOpacity(0.3)
                              : secColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(labelText),
                      );
                    }),
                  ],
                ),
                if (adeies.isNotEmpty) Gap(padding * 1.5),
                adeies.isEmpty
                    ? Text('Δεν υπάρχουν καταχωρημένες άδειες.')
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
                                'Έναρξη',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col3Flex,
                              child: Text(
                                'Λήξη',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col4Flex,
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
                    itemCount: adeies.length,
                    separatorBuilder: (context, _) => Divider(),
                    padding: .only(bottom: padding),
                    itemBuilder: (context, int index) {
                      final adeia = sortedAdeies[index];
                      final isLast = index == adeies.length - 1;
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
                              child: Text(adeia.type.label),
                            ),
                            Expanded(
                              flex: col2Flex,
                              child: Text(
                                DateFormat(
                                  'EEE dd MMM yy',
                                  'el',
                                ).format(adeia.dateStart),
                              ),
                            ),
                            Expanded(
                              flex: col3Flex,
                              child: Text(
                                DateFormat(
                                  'EEE dd MMM yy',
                                  'el',
                                ).format(adeia.dateEnd),
                              ),
                            ),
                            Expanded(
                              flex: col4Flex,
                              child: Text(adeia.sima ?? ''),
                            ),
                            Expanded(
                              flex: col6Flex,
                              child: Row(
                                mainAxisAlignment: .end,
                                children: [
                                  IconButton(
                                    icon: const WindowsIcon(WindowsIcons.edit),
                                    onPressed: () =>
                                        showContentDialog(context, adeia),
                                  ),
                                  Gap(5),
                                  DeleteFlyout(
                                    title: 'Διαγραφή άδειας;',
                                    onPressed: () async {
                                      await deleteAdeia(adeia.id);
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

  void showContentDialog(BuildContext context, Adeies? adeia) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ShowAdeiesDialog(sailor: widget.sailor, id: adeia),
    );
  }
}
