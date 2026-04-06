import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

class SailorWidgetVardies extends StatelessWidget {
  const SailorWidgetVardies({super.key, required this.sailor});
  final Sailor sailor;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: .all(padding),
      children: [
        Text('Βάρδιες', style: FluentTheme.of(context).typography.title),
        Text(
          'Οι παρακάτω ρυθμίσεις εφαρμόζονται μόνιμα. Οι εβδομαδιαίες αλλαγές πραγματοποιούνται από το μενού “Βάρδιες”.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        Gap(padding),
        Row(
          children: [
            Expanded(
              child: InfoLabel(
                label: 'Επώνυμο',
                child: TextBox(placeholder: sailor.surname),
              ),
            ),
            Gap(10),
            Expanded(
              child: InfoLabel(
                label: 'Όνομα',
                child: TextBox(placeholder: sailor.name),
              ),
            ),
            Gap(10),
            Expanded(
              child: InfoLabel(
                label: 'ΑΓΜ',
                child: TextBox(placeholder: sailor.agm),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
