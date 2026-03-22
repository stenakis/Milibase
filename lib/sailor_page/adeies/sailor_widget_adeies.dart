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
  late Future<List<Adeies>> _future;
  final FlyoutController flyoutController = FlyoutController();
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
          return Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .all(padding),
                child: Row(
                  children: [
                    Text(
                      'Άδειες',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Gap(10),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: .horizontal,
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
                              final labelText = adeiaType == Adeia.kanoniki
                                  ? '${adeiaType.label}: $totalDays/$daysKanoniki ημέρες'
                                  : '${adeiaType.label}: $totalDays $days';

                              return Container(
                                margin: .only(right: 5),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: secColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(labelText),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
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
                      crossAxisAlignment: .start,
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
                            'Ημερομηνία Έναρξης',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Ημερομηνία Λήξης',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Σήμα',
                            style: TextStyle(fontWeight: .bold),
                          ),
                        ),
                        Gap(padding * 2),
                      ],
                    ),
              Gap(5),
              Expanded(
                child: ListView(
                  padding: .symmetric(horizontal: padding),
                  children: adeies
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
                                    'dd MMMM yyyy',
                                    'el',
                                  ).format(adeia.dateStart),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'dd MMMM yyyy',
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
