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

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<bool> checkUpdate;
  @override
  void initState() {
    checkUpdate = checkVersion();
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
                  Text(
                    'Βάση',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
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
                        return Text(
                          'Σφάλμα εύρεσης καινούργιας έδκοσης: ${snapshot.error}',
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
                  Text('Σε αυτή την έκδοση:'),
                  const Gap(5),
                  SuperBulletList(
                    iconSize: 5,
                    separator: const Gap(0),
                    gap: 5,
                    items: [
                      Text('Νέο! Επανασχεδιασμός των στοιχείων Ν/Δ'),
                      Text('Προσθήκη ημερολογίου στην Επισκόπηση Ν/Δ'),
                      Text('Παράκαμψη τόνου στην αναζήτηση Ν/Δ'),
                      Text('Προσαρμογή μεγεθους κειμένων'),
                      Text('Βελτίωση ταχύτητας'),
                    ],
                  ),
                  Spacer(),
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
