import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/init_db.dart';
import 'package:milibase/variables.dart';
import 'package:open_folder/open_folder.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                        style: FluentTheme.of(context).typography.titleLarge,
                      ),
                    ],
                  ),
                  Gap(padding),

                  Text('Τοποθεσία Βάσης:'),
                  Gap(5),
                  Text('$dbLocation/sailors_database.sqlite'),
                  Gap(5),
                  Button(
                    child: Text('Άνοιγμα στην εξερεύνηση'),
                    onPressed: () => OpenFolder.openFolder(dbLocation),
                  ),
                  Gap(padding * 2),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: .all(padding * 2),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: SvgPicture.asset('assets/logo_large.svg'),
                  ),
                  Gap(10),
                  Text('Έκδοση 0.2'),
                  Gap(padding),
                  Text('Σε αυτή την έκδοση:'),
                  Gap(5),
                  SuperBulletList(
                    iconSize: 5,
                    separator: Gap(0),
                    gap: 5,
                    items: [
                      Text('Νέες ειδικότητες'),
                      Text('Αναζήτηση ναυτών'),
                      Text('Φίλτρα μεταβολών'),
                      Text('Ταξινόμηση λιστών'),
                      Text(
                        'Εναλλαγή ονόματος-επωνύμου στην επεξεργασία ναυτών',
                      ),
                      Text(
                        'Διόρθωση σφάλματος όπου οι ημερομηνίες κατάταξης, εισασωγής και διαγραφής ισούνταν με την ημέρα εισαγωγής του στη βάση',
                      ),
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
