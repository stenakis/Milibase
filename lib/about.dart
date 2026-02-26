import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/variables.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: ScaffoldPage.withPadding(
        content: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Σχετικά',
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
