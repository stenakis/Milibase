import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/init_db.dart';
import 'package:milibase/variables.dart';
import 'package:open_folder/open_folder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: ScaffoldPage.withPadding(
        content: Column(
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
            Text('Έκδοση 0.1 BETA'),
            Gap(padding * 2),
            Text('Τοποθεσία Βάσης:'),
            Gap(5),
            Text('$dbLocation/sailors_database.sqlite'),
            Gap(5),
            Button(
              child: Text('Άνοιγμα τοποθεσίας'),
              onPressed: () => OpenFolder.openFolder(dbLocation),
            ),
            Gap(padding * 2),
            Text('Σχεδιασμός & Υλοποίηση'),
            Gap(10),
            SvgPicture.asset('assets/evans_logo.svg', height: 30),
          ],
        ),
      ),
    );
  }
}
