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
                      Gap(10),
                      Text(
                        'Ρυθμίσεις',
                        style: FluentTheme.of(context).typography.title,
                      ),
                    ],
                  ),
                  Gap(padding),
                  Text(
                    'Βάση',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  Gap(5),
                  Text('$dbLocation\\sailors_database.sqlite'),
                  Gap(5),
                  Button(
                    child: Text('Άνοιγμα στην εξερεύνηση'),
                    onPressed: () => OpenFolder.openFolder(dbLocation),
                  ),

                  Gap(padding * 2),
                  Text(
                    'Επαναφορά Βάσης',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  Gap(10),
                  Row(
                    spacing: 5,
                    children: [
                      Button(
                        onPressed: () async {
                          await exportBackup(context);
                        },
                        child: Text('Export'),
                      ),

                      Button(
                        onPressed: () async {
                          await importBackup(context);
                        },
                        child: Text('Import'),
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
                  Gap(padding),
                  Text(
                    'Έκδοση $appVersion',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),

                  Gap(10),
                  FutureBuilder<bool>(
                    future: checkUpdate,
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == .waiting) {
                        return Row(
                          children: [
                            ProgressRing(),
                            Gap(10),
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
                              Gap(10),
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
                              Gap(10),
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
                  Gap(padding),
                  Text('Σε αυτή την έκδοση:'),
                  Gap(5),
                  SuperBulletList(
                    iconSize: 5,
                    separator: Gap(0),
                    gap: 5,
                    items: [
                      Text('Εμφάνιση κατάστασης Ν/Δ στην αρχική οθόνη'),
                      Text(
                        'Συμπυκνωμένη εμφάνιση για καλύτερη προοβολή σε μικρές οθόνες',
                      ),
                      Text(
                        'Προαιρετική εισαγωγή ημερομηνίας λήξης απομάκρνυνσης',
                      ),
                      Text('Προσθήκη ονόματος και ΑΓΜ στην αναζήτηση Ν/Δ'),
                      Text('Προσαρμογή μεγέθους ονομ/νύμου ΝΔ σε μία γραμμή'),
                      Text(
                        'Διόρθωση σφάλματος όπου η επεξεργασία μεταβολών επανέφερε τις ημερομηνίες στη σημερινή',
                      ),
                      Text('Διόρθωση σφάλματος αναζήτησης Ν/Δ'),
                    ],
                  ),
                  Spacer(),
                  Text('Σχεδιασμός & Υλοποίηση'),
                  Gap(padding),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      SvgPicture.asset('assets/evans_logo.svg', height: 30),
                      Spacer(),
                      Gap(10),
                      IconButton(
                        onPressed: () async {
                          Uri url = Uri.parse('https://github.com/stenakis');
                          await launchUrl(url);
                        },
                        icon: SvgPicture.asset('assets/github.svg', height: 20),
                      ),
                      Gap(5),
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
