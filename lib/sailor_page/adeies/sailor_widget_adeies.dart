import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_content_dialog.dart';
import 'package:milibase/styles/colors.dart';
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
  static final _dateFormat = DateFormat('EEE dd MMM yy', 'el');
  late Stream<List<Adeies>> _stream;
  Adeia? _selectedAdeia;

  List<Adeies> _applyFilter(List<Adeies> all) {
    final filtered = _selectedAdeia == null
        ? List<Adeies>.from(all)
        : all.where((a) => a.type == _selectedAdeia).toList();
    return filtered..sort((a, b) => a.dateStart.compareTo(b.dateStart));
  }

  int get _daysKanoniki => Adeia.kanonikiDays(widget.sailor.servingMonths);

  @override
  void initState() {
    super.initState();
    _stream =
        (db.select(
          db.tableAdeies,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).watch().map(
          (rows) => rows.map((r) => Adeies.fromJson(r.toJson())).toList(),
        );
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
          final allAdeies = snapshot.data!;
          final displayed = _applyFilter(allAdeies);
          final daysKanoniki = _daysKanoniki;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(padding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Άδειες',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      onPressed: () => _showContentDialog(context, null),
                      child: Row(
                        children: [
                          const Icon(FluentIcons.add),
                          const Gap(5),
                          Text('Νέα Άδεια'),
                        ],
                      ),
                    ),
                    if (allAdeies.isNotEmpty) const Gap(padding),
                    if (allAdeies.isNotEmpty)
                      ComboBox<Adeia>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            const Gap(5),
                            Text(_selectedAdeia?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: _selectedAdeia,
                        onChanged: (adeia) =>
                            setState(() => _selectedAdeia = adeia),
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
                    if (_selectedAdeia != null)
                      IconButton(
                        onPressed: () => setState(() => _selectedAdeia = null),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                const Gap(padding),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...Adeia.values.map((adeiaType) {
                      final totalDays = allAdeies
                          .where((a) => a.type == adeiaType)
                          .fold<int>(
                            0,
                            (sum, a) =>
                                sum +
                                a.dateEnd.difference(a.dateStart).inDays +
                                1,
                          );
                      if (totalDays == 0) {
                        return const SizedBox.shrink();
                      }
                      final dayLabel = totalDays == 1 ? 'ημέρα' : 'ημέρες';
                      final labelText = adeiaType == Adeia.kanoniki
                          ? '${adeiaType.label}: $totalDays/$daysKanoniki ημέρες'
                          : '${adeiaType.label}: $totalDays $dayLabel';
                      final isOverLimit =
                          adeiaType == Adeia.kanoniki &&
                          totalDays > daysKanoniki;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isOverLimit
                              ? Colors.orange.withAlpha(77)
                              : secColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(labelText),
                      );
                    }),
                  ],
                ),
                if (allAdeies.isNotEmpty) const Gap(padding),
                allAdeies.isEmpty
                    ? Text('Δεν υπάρχουν καταχωρημένες άδειες.')
                    : Container(
                        decoration: BoxDecoration(
                          color: secColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                          vertical: 10,
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              flex: col1Flex,
                              child: Text(
                                'Τύπος',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: col2Flex,
                              child: Text(
                                'Έναρξη',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: col3Flex,
                              child: Text(
                                'Λήξη',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: col4Flex,
                              child: Text(
                                'Σήμα',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                Expanded(
                  child: ListView.separated(
                    itemCount: displayed.length,
                    separatorBuilder: (context, _) => Divider(),
                    padding: EdgeInsets.only(bottom: padding),
                    itemBuilder: (BuildContext context, int index) {
                      final adeia = displayed[index];
                      final isLast = index == displayed.length - 1;
                      final bottomRadius = Radius.circular(isLast ? 5 : 0);
                      return HoverButton(
                        onPressed: () => _showContentDialog(context, adeia),
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
                              borderRadius: BorderRadius.only(
                                bottomLeft: bottomRadius,
                                bottomRight: bottomRadius,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
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
                                    _dateFormat.format(adeia.dateStart),
                                  ),
                                ),
                                Expanded(
                                  flex: col3Flex,
                                  child: Text(
                                    _dateFormat.format(adeia.dateEnd),
                                  ),
                                ),
                                Expanded(
                                  flex: col4Flex,
                                  child: Text(adeia.sima ?? ''),
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

  void _showContentDialog(BuildContext context, Adeies? adeia) async {
    await showDialog<String>(
      context: context,
      builder: (context) =>
          ShowAdeiesDialog(sailor: widget.sailor, adeia: adeia),
    );
  }
}
