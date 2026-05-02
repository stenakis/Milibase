import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../objects/metavoles.dart';
import '../../styles/colors.dart';
import '../../templates/info_bar.dart';
import 'metavoles_content_dialog.dart';

class SailorWidgetMetavoles extends StatefulWidget {
  const SailorWidgetMetavoles({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<SailorWidgetMetavoles> createState() => _SailorWidgetMetavolesState();
}

class _SailorWidgetMetavolesState extends State<SailorWidgetMetavoles> {
  final _metavoliKey = GlobalKey<ComboBoxState>(debugLabel: 'Metavoli Key');
  List<Metavoles> _allMetavoles = [];
  List<Metavoles> _displayedMetavoles = [];
  late Stream<List<Metavoles>> _stream;
  Metavoli? selectedMetavoli;
  bool isLoading = false;

  void _applyFilter() {
    final filtered = selectedMetavoli == null
        ? _allMetavoles
        : _allMetavoles.where((m) => m.type == selectedMetavoli).toList();
    _displayedMetavoles = filtered..sort((a, b) => a.date.compareTo(b.date));
  }

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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              showCustomInfoBar(
                context: context,
                text: snapshot.error.toString(),
              );
            }
          });
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              setState(() {
                _allMetavoles = snapshot.data!;
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
                      'Μεταβολές',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        children: [
                          Icon(FluentIcons.add),
                          const Gap(5),
                          Text('Νέα Μεταβολή'),
                        ],
                      ),
                      onPressed: () => showContentDialog(context, null),
                    ),
                    if (_allMetavoles.isNotEmpty) const Gap(padding),
                    if (_allMetavoles.isNotEmpty)
                      ComboBox<Metavoli>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            const Gap(5),
                            Text(selectedMetavoli?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: selectedMetavoli,
                        key: _metavoliKey,
                        onChanged: (Metavoli? metavoli) {
                          setState(() {
                            selectedMetavoli = metavoli; // remove the !
                            _applyFilter();
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
                          _applyFilter();
                        }),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                const Gap(padding),
                _allMetavoles.isEmpty
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
                          ],
                        ),
                      ),
                Expanded(
                  child: ListView.separated(
                    padding: .only(bottom: padding),
                    separatorBuilder: (context, _) => Divider(),
                    itemCount: _allMetavoles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final metavoli = _displayedMetavoles[index];
                      final isLast = index == _allMetavoles.length - 1;
                      final bottomRadius = Radius.circular(isLast ? 5 : 0);
                      return HoverButton(
                        onPressed: () => showContentDialog(context, metavoli),
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
                                  child: Text(
                                    metavoli.type.description,
                                    maxLines: 2,
                                    overflow: .ellipsis,
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

  void showContentDialog(BuildContext context, Metavoles? metavoli) async {
    await showDialog<String>(
      context: context,
      builder: (context) =>
          ShowMetavolesDialog(sailor: widget.sailor, id: metavoli),
    );
  }
}
