import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

class SailorWidgetMetavoles extends StatelessWidget {
  const SailorWidgetMetavoles({super.key, required this.sailor});
  final Sailor sailor;

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentBackgroundColor: Colors.white,
      initiallyExpanded: true,
      contentPadding: .all(padding),
      header: Padding(
        padding: .symmetric(vertical: 10),
        child: Text(
          'Μεταβολές',
          style: FluentTheme.of(context).typography.title,
        ),
      ),
      content: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Οι παρακάτω ρυθμίσεις εφαρμόζονται μόνιμα. Οι εβδομαδιαίες αλλαγές πραγματοποιούνται από το μενού “Βάρδιες”.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Gap(10),
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
      ),
    );
  }
}
