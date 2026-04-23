import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/navigation.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';

class SailorWidgetSettings extends StatefulWidget {
  const SailorWidgetSettings({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetSettings> createState() => _SailorWidgetSettingsState();
}

class _SailorWidgetSettingsState extends State<SailorWidgetSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .all(padding),
          child: Text(
            'Ρυθμίσεις',
            style: FluentTheme.of(context).typography.title,
          ),
        ),
        Padding(
          padding: .symmetric(horizontal: padding),
          child: Row(
            children: [
              Text('Διαγραφή Ν/Δ'),
              Spacer(),
              Button(
                child: Row(
                  children: [
                    WindowsIcon(WindowsIcons.delete),
                    const Gap(5),
                    Text('Διαγραφή'),
                  ],
                ),
                onPressed: () async {
                  try {
                    await (db.delete(
                      db.tableSailors,
                    )..where((t) => t.id.equals(widget.sailor.id))).go();
                    mainInnerKey.currentState?.popUntil(
                      (route) => route.isFirst,
                    );
                  } catch (e) {
                    if (mounted && context.mounted) {
                      await showCustomInfoBar(
                        context: context,
                        text: e.toString(),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
