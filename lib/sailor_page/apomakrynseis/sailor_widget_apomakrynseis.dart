import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_content_dialog.dart';
import 'package:milibase/sailor_page/apomakrynseis/apomakrynseis_functions.dart';
import 'package:milibase/styles/colors.dart';
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
  late Future<List<Apomakrynseis>> _future;
  final FlyoutController flyoutController = FlyoutController();
  bool isLoading = false;
  void setFuture() {
    _future =
        (db.select(
          db.tableApomakrynseis,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).get().then(
          (rows) =>
              rows.map((row) => Apomakrynseis.fromJson(row.toJson())).toList(),
        );
  }

  int daysApospasi = 45;
  int daysDiathesi = 15;

  @override
  void initState() {
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
          final List<Apomakrynseis> apomakrynseis = snapshot.data!;
          return Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .all(padding),
                child: Row(
                  children: [
                    Text(
                      'Απομακρύνσεις',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Gap(10),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: .horizontal,
                          children: [
                            ...Apomakrynsi.values.map((apomakrynsiType) {
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
                              final labelText =
                                  apomakrynsiType == Apomakrynsi.diathesi
                                  ? '${apomakrynsiType.label}: $totalDays/$daysDiathesi ημέρες'
                                  : '${apomakrynsiType.label}: $totalDays/$daysApospasi ημέρες';

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
                    apomakrynseis.isEmpty
                        ? SizedBox.shrink()
                        : FilledButton(
                            child: Row(
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Απομάκρυνση'),
                              ],
                            ),
                            onPressed: () => showContentDialog(context),
                          ),
                  ],
                ),
              ),
              apomakrynseis.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            'Δεν υπάρχουν καταχωρημένες απομακρύνσεις',
                            textAlign: .center,
                          ),
                          Gap(10),
                          FilledButton(
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Απομάκρυνση'),
                              ],
                            ),
                            onPressed: () => showContentDialog(context),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: .end,

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
                            'Υπηρεσία',
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
                  children: apomakrynseis
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
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(apomakrynsi.type.label),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                    'el',
                                  ).format(apomakrynsi.dateStart),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                    'el',
                                  ).format(apomakrynsi.dateEnd),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(apomakrynsi.ypiresia),
                              ),
                              Expanded(flex: 1, child: Text(apomakrynsi.sima)),
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
                                                'Διαγραφή απομάκρυνσης;',
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
                                                    await deleteApomakrynsi(
                                                      apomakrynsi.id!,
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
      builder: (context) => ShowApomakrynseisDialog(sailor: widget.sailor),
    );
    if (result == 'success') setState(() => setFuture());
  }
}
