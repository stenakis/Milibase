import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/variables.dart';

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
            Text('Έκδοση 0.1'),
          ],
        ),
      ),
    );
  }
}
