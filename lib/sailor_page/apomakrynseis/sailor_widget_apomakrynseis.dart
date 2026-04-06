import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_content_dialog.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_functions.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/templates/delete_button.dart';
import 'package:milibase/variables.dart';
import '../../main.dart';

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
  late Stream<List<Apomakrynseis>> _stream;
  Apomakrynsi? selectedApomakrynsi;
  bool isLoading = false;
  int daysApospasi = 45;
  int daysDiathesi = 15;

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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Apomakrynseis> apomakrynseis = snapshot.data!;
          final List<Apomakrynseis> selectedList = selectedApomakrynsi == null
              ? apomakrynseis
              : apomakrynseis
                    .where((adeia) => adeia.type == selectedApomakrynsi)
                    .toList();
          final sortedApomakrynseis = selectedList.toList()
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
                      'Απομακρύνσεις',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        children: [
                          Icon(FluentIcons.add),
                          Gap(5),
                          Text('Νέα Απομάκρυνση'),
                        ],
                      ),
                      onPressed: () => showContentDialog(context, null),
                    ),
                    Gap(padding),
                    if (apomakrynseis.isNotEmpty)
                      ComboBox<Apomakrynsi>(
                        placeholder: Row(
                          children: [
                            WindowsIcon(WindowsIcons.filter),
                            Gap(5),
                            Text(selectedApomakrynsi?.label ?? 'Όλες'),
                          ],
                        ),
                        isExpanded: false,
                        value: selectedApomakrynsi,
                        key: apomakrynsiKey,
                        onChanged: (Apomakrynsi? apomakrynsi) {
                          setState(() {
                            selectedApomakrynsi = apomakrynsi!;
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
                        }),
                        icon: WindowsIcon(WindowsIcons.clear),
                      ),
                  ],
                ),
                Gap(10),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...Apomakrynsi.values.map((apomakrynsiType) {
                      if (apomakrynsiType != .metathesi) {
                        final totalDays = apomakrynseis
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
                            ? '${apomakrynsiType.label}: $totalDays/$daysDiathesi ημέρες'
                            : '${apomakrynsiType.label}: $totalDays/$daysApospasi ημέρες';

                        return Container(
                          margin: .only(right: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                apomakrynsiType == .apospasi &&
                                        totalDays > daysApospasi ||
                                    apomakrynsiType == .diathesi &&
                                        totalDays > daysDiathesi
                                ? Colors.orange.withOpacity(0.3)
                                : secColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(labelText),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                  ],
                ),
                if (apomakrynseis.isNotEmpty) Gap(padding * 1.5),
                apomakrynseis.isEmpty
                    ? Text('Δεν υπάρχουν καταχωρημένες απομακρύνσεις.')
                    : Padding(
                        padding: .symmetric(horizontal: padding),
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
                            Expanded(flex: col6Flex, child: Text('')),
                          ],
                        ),
                      ),
                Gap(5),
                Expanded(
                  child: ListView(
                    padding: .only(bottom: padding),
                    children: sortedApomakrynseis
                        .map(
                          (apomakrynsi) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .circular(5),
                            ),
                            margin: .symmetric(vertical: 5),
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
                                Expanded(
                                  flex: col6Flex,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const WindowsIcon(
                                          WindowsIcons.edit,
                                        ),
                                        onPressed: () => showContentDialog(
                                          context,
                                          apomakrynsi,
                                        ),
                                      ),
                                      DeleteFlyout(
                                        title: 'Διαγραφή απομάκρυνσης;',
                                        onPressed: () async {
                                          await deleteApomakrynsi(
                                            apomakrynsi.id!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Άγωνστο σφάλμα'));
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
