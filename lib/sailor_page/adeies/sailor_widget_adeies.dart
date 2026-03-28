import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_content_dialog.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';

class SailorWidgetAdeies extends StatefulWidget {
  const SailorWidgetAdeies({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetAdeies> createState() => _SailorWidgetAdeiesState();
}

class _SailorWidgetAdeiesState extends State<SailorWidgetAdeies> {
  final _adeiaKey = GlobalKey<ComboBoxState>(debugLabel: 'Adeia Key');
  late Future<List<Adeies>> _future;
  final FlyoutController flyoutController = FlyoutController();
  Adeia? selectedAdeia;
  bool isLoading = false;
  void setFuture() {
    _future =
        (db.select(
          db.tableAdeies,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).get().then(
          (rows) => rows.map((row) => Adeies.fromJson(row.toJson())).toList(),
        );
  }

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
          final List<Adeies> adeies = snapshot.data!;
          final List<Adeies> selectedList = selectedAdeia == null
              ? adeies
              : adeies.where((adeia) => adeia.type == selectedAdeia).toList();
          final sortedAdeies = selectedList.toList()
            ..sort((a, b) => a.dateStart.compareTo(b.dateStart));
          return Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .all(padding),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Άδειες',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Gap(padding),
                    Expanded(
                      child: Wrap(
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
                                      item.dateEnd
                                          .difference(item.dateStart)
                                          .inDays +
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
                                    adeiaType == .kanoniki &&
                                        totalDays > daysKanoniki
                                    ? Colors.orange.withOpacity(0.3)
                                    : secColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(labelText),
                            );
                          }),
                        ],
                      ),
                    ),
                    Gap(padding),
                    adeies.isEmpty
                        ? SizedBox.shrink()
                        : FilledButton(
                            child: Row(
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Άδεια'),
                              ],
                            ),
                            onPressed: () => showContentDialog(context),
                          ),
                  ],
                ),
              ),

              adeies.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            'Δεν υπάρχουν καταχωρημένες άδειες',
                            textAlign: .center,
                          ),
                          Gap(10),
                          FilledButton(
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Άδεια'),
                              ],
                            ),
                            onPressed: () => showContentDialog(context),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Gap(padding * 2),
                        Expanded(
                          child: Text(
                            'Τύπος',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Έναρξη',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Λήξη',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        if (selectedAdeia == .oikos_nosileias ||
                            selectedAdeia == .anarrotiki ||
                            selectedAdeia == null)
                          Expanded(
                            child: Text(
                              'Σήμα',
                              style: TextStyle(fontWeight: .bold),
                            ),
                          ),
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
                              (Adeia.values.toList()..sort(
                                    (a, b) => a.label.compareTo(b.label),
                                  ))
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

                        Gap(padding),
                      ],
                    ),
              Gap(5),
              Expanded(
                child: ListView(
                  padding: .symmetric(horizontal: padding),
                  children: sortedAdeies
                      .map(
                        (adeia) => Container(
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
                            children: [
                              Expanded(flex: 1, child: Text(adeia.type.label)),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'EEE dd MMM yy',
                                    'el',
                                  ).format(adeia.dateStart),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'EEE dd MMM yy',
                                    'el',
                                  ).format(adeia.dateEnd),
                                ),
                              ),
                              Expanded(flex: 1, child: Text(adeia.sima ?? '')),
                              FlyoutTarget(
                                controller: flyoutController,
                                child: IconButton(
                                  icon: const WindowsIcon(WindowsIcons.delete),
                                  onPressed: () {
                                    flyoutController.showFlyout<void>(
                                      autoModeConfiguration:
                                          FlyoutAutoConfiguration(
                                            preferredMode:
                                                FlyoutPlacementMode.topCenter,
                                          ),
                                      barrierDismissible: true,
                                      dismissOnPointerMoveAway: false,
                                      dismissWithEsc: true,
                                      builder: (context) {
                                        return FlyoutContent(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Διαγραφή άδειας;',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 12.0),
                                              Button(
                                                onPressed: () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  try {
                                                    await deleteAdeia(
                                                      adeia.id!,
                                                    );
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(
                                                      context,
                                                      'success',
                                                    );
                                                    setState(() => setFuture());
                                                  } catch (error) {
                                                    await displayInfoBar(
                                                      context,
                                                      duration: Duration(
                                                        seconds: 5,
                                                      ),
                                                      builder: (context, close) {
                                                        return InfoBar(
                                                          title: const Text(
                                                            'An error occurred:',
                                                          ),
                                                          content: Text(
                                                            error.toString(),
                                                          ),
                                                          action: IconButton(
                                                            icon:
                                                                const WindowsIcon(
                                                                  WindowsIcons
                                                                      .error,
                                                                ),
                                                            onPressed: close,
                                                          ),
                                                          severity:
                                                              InfoBarSeverity
                                                                  .error,
                                                        );
                                                      },
                                                    );
                                                  }
                                                },

                                                child: const Text(
                                                  'Επιβεβαίωση',
                                                ),
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
                        ),
                      )
                      .toList(),
                ),
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
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ShowAdeiesDialog(sailor: widget.sailor),
    );
    if (result == 'success') setState(() => setFuture());
  }
}
