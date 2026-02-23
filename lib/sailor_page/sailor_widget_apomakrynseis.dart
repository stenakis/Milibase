import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

class SailorWidgetApomakrynseis extends StatelessWidget {
  const SailorWidgetApomakrynseis({super.key, required this.sailor});
  final Sailor sailor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .all(padding),
          child: Row(
            children: [
              Text(
                'Απομακρύνσεις',
                style: FluentTheme.of(context).typography.title,
              ),
              Gap(10),
              Container(
                padding: .symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: secColor,
                  borderRadius: .all(.circular(5)),
                ),
                child: Text('Αποσπάσεις: 15/45 ημέρες'),
              ),
              Gap(10),
              Container(
                padding: .symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: secColor,
                  borderRadius: .all(.circular(5)),
                ),
                child: Text('Διαθέσεις: 2/15 ημέρες'),
              ),
            ],
          ),
        ),
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
    );
  }
}
