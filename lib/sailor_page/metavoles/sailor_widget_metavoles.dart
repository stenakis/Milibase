import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../objects/metavoles.dart';
import 'metavoles_content_dialog.dart';
import 'metavoles_functions.dart';

class SailorWidgetMetavoles extends StatefulWidget {
  const SailorWidgetMetavoles({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetMetavoles> createState() => _SailorWidgetMetavolesState();
}

class _SailorWidgetMetavolesState extends State<SailorWidgetMetavoles> {
  late Future<List<Metavoles>> _future;
  final FlyoutController flyoutController = FlyoutController();
  bool isLoading = false;
  void setFuture() {
    _future =
        (db.select(
          db.tableMetavoles,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).get().then(
          (rows) =>
              rows.map((row) => Metavoles.fromJson(row.toJson())).toList(),
        );
  }

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
          final List<Metavoles> metavoles = snapshot.data!;
          return Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .all(padding),
                child: Row(
                  children: [
                    Text(
                      'Μεταβολές',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    metavoles.isEmpty
                        ? SizedBox.shrink()
                        : FilledButton(
                            child: Row(
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Μεταβολή'),
                              ],
                            ),
                            onPressed: () => showContentDialog(context),
                          ),
                  ],
                ),
              ),
              metavoles.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            'Δεν υπάρχουν καταχωρημένες μεταβολές',
                            textAlign: .center,
                          ),
                          Gap(10),
                          FilledButton(
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(FluentIcons.add),
                                Gap(5),
                                Text('Νέα Μεταβολή'),
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
                            'Ημερομηνία',
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
                  children: metavoles
                      .map(
                        (metavoli) => Container(
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
                                child: Text(
                                  metavoli.type == .meiomeni
                                      ? 'Μεταφέρθηκε στους υπόχρεους ${metavoli.duration}μηνης θητείας'
                                      : 'Υπέχει στρατολογική εκκρεμότητα',
                                ),
                              ),

                              Gap(10),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                    'el',
                                  ).format(metavoli.date),
                                ),
                              ),
                              Expanded(flex: 1, child: Text(metavoli.sima)),
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
                                                    await deleteMetavoli(
                                                      metavoli.id!,
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
      builder: (context) => ShowMetavolesDialog(sailor: widget.sailor),
    );
    if (result == 'success') setState(() => setFuture());
  }
}
