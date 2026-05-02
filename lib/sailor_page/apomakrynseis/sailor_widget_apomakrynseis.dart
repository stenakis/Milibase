import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_content_dialog.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../templates/info_bar.dart';

class SailorWidgetApomakrynseis extends StatefulWidget {
  const SailorWidgetApomakrynseis({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetApomakrynseis> createState() =>
      _SailorWidgetApomakrynseisState();
}

class _SailorWidgetApomakrynseisState extends State<SailorWidgetApomakrynseis> {
  final apomakrynsiKey = GlobalKey<ComboBoxState>(
    debugLabel: 'Apomakrynsi Key',
  );
  List<Apomakrynseis> _allApomakrynseis = [];
  List<Apomakrynseis> _displayedApomakrynseis = [];
  late Stream<List<Apomakrynseis>> _stream;
  Apomakrynsi? selectedApomakrynsi;
  bool isLoading = false;

  void _applyFilter() {
    final filtered = selectedApomakrynsi == null
        ? _allApomakrynseis
        : _allApomakrynseis
              .where((a) => a.type == selectedApomakrynsi)
              .toList();
    _displayedApomakrynseis = filtered
      ..sort((a, b) => a.dateStart.compareTo(b.dateStart));
  }

  @override
  void initState() {
    _stream =
        (db.select(
          db.tableApomakrynseis,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).watch().map(
          (rows) =>
              rows.map((row) => Apomakrynseis.fromJson(row.toJson())).toList(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Apomakrynseis>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        }
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              showCustomInfoBar(
                context: context,
                text: snapshot.error.toString(),
              );
            }
          });
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _allApomakrynseis = snapshot.data!;
                _applyFilter();
              });
            }
          });
          return Padding(
            padding: .symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const Gap(padding),
                Row(
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      'Απομακρύνσεις',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        children: [
                          Icon(FluentIcons.add),
                          const Gap(5),
                          Text('Νέα Απομάκρυνση'),
                        ],
                      ),
                      onPressed: () => showContentDialog(context, null),
                    ),
                    if (_allApomakrynseis.isNotEmpty) const Gap(padding),
                    if (_allApomakrynseis.isNotEmpty)
                      ComboBox<Apomakrynsi>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            const Gap(5),
                            Text(selectedApomakrynsi?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: selectedApomakrynsi,
                        key: apomakrynsiKey,
                        onChanged: (Apomakrynsi? apomakrynsi) {
                          setState(() {
                            selectedApomakrynsi = apomakrynsi; // remove the !
                            _applyFilter();
                          });
                        },

                        items:
                            (Apomakrynsi.values.toList()
                                  ..sort((a, b) => a.label.compareTo(b.label)))
                                .map((Apomakrynsi e) {
                                  return ComboBoxItem<Apomakrynsi>(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                })
                                .toList(),
                      ),
                    if (selectedApomakrynsi != null)
                      IconButton(
                        onPressed: () => setState(() {
                          selectedApomakrynsi = null;
                          _applyFilter();
                        }),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                const Gap(padding),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...Apomakrynsi.values.map((apomakrynsiType) {
                      if (apomakrynsiType != .metathesi) {
                        final totalDays = _allApomakrynseis
                            .where((item) => item.type == apomakrynsiType)
                            .fold<int>(
                              0,
                              (sum, item) =>
                                  sum +
                                  item.dateEnd
                                      .difference(item.dateStart)
                                      .inDays +
                                  1,
                            );
                        if (totalDays == 0) {
                          return const SizedBox.shrink();
                        }
                        final labelText = apomakrynsiType == .diathesi
                            ? '${apomakrynsiType.label}: $totalDays/${Apomakrynsi.maxDaysDiathesi} ημέρες'
                            : '${apomakrynsiType.label}: $totalDays/${Apomakrynsi.maxDaysApospasi} ημέρες';

                        return Container(
                          margin: .only(right: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                apomakrynsiType == .apospasi &&
                                        totalDays >
                                            Apomakrynsi.maxDaysApospasi ||
                                    apomakrynsiType == .diathesi &&
                                        totalDays > Apomakrynsi.maxDaysDiathesi
                                ? Colors.orange.withAlpha(77)
                                : secColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(labelText),
                        );
                      } else {
                        return const SizedBox.shrink(); // add const
                      }
                    }),
                  ],
                ),
                if (_allApomakrynseis.isNotEmpty) const Gap(padding),
                _allApomakrynseis.isEmpty
                    ? Text('Δεν υπάρχουν καταχωρημένες απομακρύνσεις.')
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
                                'Υπηρεσία',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            Expanded(
                              flex: col5Flex,
                              child: Text(
                                'Σήμα',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _allApomakrynseis.length,
                    separatorBuilder: (context, _) => Divider(),
                    padding: .only(bottom: padding),
                    itemBuilder: (BuildContext context, int index) {
                      final apomakrynsi = _displayedApomakrynseis[index];
                      final isLast = index == _allApomakrynseis.length - 1;
                      final bottomRadius = Radius.circular(isLast ? 5 : 0);
                      return HoverButton(
                        onPressed: () =>
                            showContentDialog(context, apomakrynsi),
                        builder: (context, state) {
                          final isHovered = state.isHovered;
                          final isPressed = state.isPressed;
                          return Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: isPressed
                                  ? Colors.white.withAlpha(150)
                                  : isHovered
                                  ? Colors.white.withAlpha(200)
                                  : Colors.white,
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
                                  child: Text(apomakrynsi.type.label),
                                ),
                                Expanded(
                                  flex: col2Flex,
                                  child: Text(
                                    DateFormat(
                                      'EEE dd MMM yy',
                                      'el',
                                    ).format(apomakrynsi.dateStart),
                                  ),
                                ),
                                Expanded(
                                  flex: col3Flex,
                                  child: Text(
                                    DateFormat(
                                      'EEE dd MMM yy',
                                      'el',
                                    ).format(apomakrynsi.dateEnd),
                                  ),
                                ),
                                Expanded(
                                  flex: col4Flex,
                                  child: Text(apomakrynsi.ypiresia),
                                ),
                                Expanded(
                                  flex: col5Flex,
                                  child: Text(apomakrynsi.sima),
                                ),
                              ],
                            ),
                          );
                        },
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

  void showContentDialog(
    BuildContext context,
    Apomakrynseis? apomakrynsi,
  ) async {
    await showDialog<String>(
      context: context,
      builder: (context) =>
          ShowApomakrynseisDialog(sailor: widget.sailor, id: apomakrynsi),
    );
  }
}
