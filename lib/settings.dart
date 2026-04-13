import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/export_db.dart';
import 'package:milibase/db/init_db.dart';
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
  /*Future<String> initializeTable() async {
    var row = await db.select(db.vars).getSingleOrNull();
    if (row == null) {
      await db
          .into(db.vars)
          .insertOnConflictUpdate(VarsCompanion.insert(prothemaShmatos: 'WAF'));
      row = await db.select(db.vars).getSingle();
    }
    return row.prothemaShmatos;
  }*/

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
                  Gap(10),
                  Text('Έκδοση 0.5'),
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
                    ],
                  ),
                  Spacer(),
                  Text('Σχεδιασμός & Υλοποίηση'),
                  Gap(padding),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      SvgPicture.asset('assets/evans_logo.svg', height: 30),
                      IconButton(
                        icon: WindowsIcon(WindowsIcons.open_in_new_window),
                        onPressed: () async {
                          final Uri url = Uri.parse(
                            'https://stenakis.github.io',
                          );
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
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
