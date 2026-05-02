import 'package:drift/drift.dart' hide Column;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/export_db.dart';
import 'package:milibase/db/init_db.dart';
import 'package:milibase/settings/install.dart';
import 'package:milibase/settings/update_func.dart';
import 'package:milibase/variables.dart';
import 'package:open_folder/open_folder.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<bool> checkUpdate;
  late Stream<bool> _meiomeniThiteia;

  @override
  void initState() {
    checkUpdate = checkVersion();
    _meiomeniThiteia = (db.select(
      db.vars,
    )).watchSingle().map((row) => row.enableMeiomeniThiteia);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: .zero,
      content: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: .all(padding),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: WindowsIcon(WindowsIcons.chrome_back, size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Gap(10),
                      Text(
                        'Ρυθμίσεις',
                        style: FluentTheme.of(context).typography.title,
                      ),
                    ],
                  ),
                  const Gap(padding),
                  Row(
                    children: [
                      Text(
                        'Επιπλέον επιλογές μειωμένης θητείας (5 & 8 μήνες)',
                        style: TextStyle(fontSize: 18, fontWeight: .bold),
                      ),
                      Spacer(),
                      StreamBuilder<bool>(
                        stream: _meiomeniThiteia,
                        builder:
                            (
                              BuildContext context,
                              AsyncSnapshot<bool> snapshot,
                            ) {
                              if (snapshot.connectionState == .waiting) {
                                return ProgressRing();
                              } else if (!snapshot.hasData) {
                                return Text('Σφάλμα');
                              } else if (snapshot.hasData) {
                                bool checked = snapshot.data!;
                                return ToggleSwitch(
                                  checked: checked,
                                  onChanged: (v) async {
                                    await (db.update(db.vars)).write(
                                      VarsCompanion(
                                        enableMeiomeniThiteia: Value(v),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Text('Σφάλμα');
                              }
                            },
                      ),
                    ],
                  ),
                  const Gap(padding),
                  Text(
                    'Βάση',
                    style: TextStyle(fontSize: 18, fontWeight: .bold),
                  ),
                  const Gap(5),
                  Text('$dbLocation\\sailors_database.sqlite'),
                  const Gap(10),
                  Row(
                    spacing: 5,
                    children: [
                      Button(
                        child: Row(
                          children: [
                            WindowsIcon(WindowsIcons.file_explorer),
                            const Gap(5),
                            Text('Άνοιγμα θέσης αρχείου'),
                          ],
                        ),
                        onPressed: () => OpenFolder.openFolder(dbLocation),
                      ),
                      Button(
                        onPressed: () async {
                          await exportBackup(context);
                        },
                        child: Row(
                          children: [
                            WindowsIcon(WindowsIcons.export),
                            const Gap(5),
                            Text('Εξαγωγή σε .json'),
                          ],
                        ),
                      ),

                      Button(
                        onPressed: () async {
                          await importBackup(context);
                        },
                        child: Row(
                          children: [
                            WindowsIcon(WindowsIcons.import),
                            const Gap(5),
                            Text('Εισαγωγή από .json'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: .all(padding),
              padding: .all(padding * 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: SvgPicture.asset('assets/logo_large.svg'),
                  ),
                  const Gap(padding),
                  Text(
                    'Έκδοση $appVersion',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  const Gap(10),
                  FutureBuilder<bool>(
                    future: checkUpdate,
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == .waiting) {
                        return Row(
                          children: [
                            ProgressRing(),
                            const Gap(10),
                            Text('Γίνεται έλεγχος για ενημερώσεις'),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Σφάλμα επικοινωνίας με τον σέρβερ.'),
                            const Gap(10),
                            FilledButton(
                              child: Text('Έλεγχος για ενημερώσεις'),
                              onPressed: () async {
                                setState(() {
                                  checkUpdate = checkVersion();
                                });
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data == false) {
                          return Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text('Δεν υπάρχει διαθέσιμη ενημέρωση'),
                              const Gap(10),
                              FilledButton(
                                child: Text('Έλεγχος για ενημερώσεις'),
                                onPressed: () async {
                                  setState(() {
                                    checkUpdate = checkVersion();
                                  });
                                },
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text('Υπάρχει διαθέσιμη ενημέρωση!'),
                              const Gap(10),
                              FilledButton(
                                child: Text('Εγκατάσταση'),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ContentDialog(
                                      title: Text('Προετοιμασία για ενημέρωση'),
                                      content: Text(
                                        'Όταν ολοκληρωθεί η λήψη του αρχείου εγκατάστασης, η εφαρμογή θα κλείσει και μετά την εγκατάσταση θα γίνει αυτόματη εκκίνηση.',
                                      ),
                                      actions: [ProgressBar()],
                                    ),
                                  );

                                  Future.delayed(Duration(seconds: 2));
                                  await downloadAndInstallUpdate();
                                },
                              ),
                            ],
                          );
                        }
                      } else {
                        return Text('Σφάλμα εύρεσης καινούργιας έδκοσης');
                      }
                    },
                  ),
                  const Gap(padding),
                  Expanded(
                    child: ListView(
                      children: [
                        Text('Σε αυτή την έκδοση:'),
                        const Gap(5),
                        SuperBulletList(
                          iconSize: 5,
                          separator: const Gap(0),
                          gap: 5,
                          items: [
                            Text(
                              'Η αποθήκευση μεταβολών γίνεται πλέον και με το πλήκτρο Enter',
                            ),
                            Text(
                              'Προσαρμογή λειτουργιών επεξεργασίας και διαγραφής μεταβολών σε ένα ενιαίο περιβάλλον',
                            ),
                            Text(
                              'Προσθήκη προεραιτικής επιπλέον επιλογής μειωμένης θητείας',
                            ),
                            Text(
                              'Διόρθωση σφάλματος όπου οι μήνες στο ημερολόγιο Ν/Δ ήταν σε γενική πτώση',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Gap(10),
                  Text('Σχεδιασμός & Υλοποίηση'),
                  const Gap(padding),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      SvgPicture.asset('assets/evans_logo.svg', height: 30),
                      Spacer(),
                      const Gap(10),
                      IconButton(
                        onPressed: () async {
                          Uri url = Uri.parse('https://github.com/stenakis');
                          await launchUrl(url);
                        },
                        icon: SvgPicture.asset('assets/github.svg', height: 20),
                      ),
                      const Gap(5),
                      IconButton(
                        icon: SvgPicture.asset('assets/web.svg', height: 20),
                        onPressed: () async {
                          Uri url = Uri.parse('https://stenakis.github.io');
                          await launchUrl(url);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
