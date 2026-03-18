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
            Text(
              'Ρυθμίσεις',
              style: FluentTheme.of(context).typography.titleLarge,
            ),
            Gap(padding),
            Text('Έκδοση 0.1'),
          ],
        ),
      ),
    );
  }
}
