import 'package:drift/drift.dart' hide Column;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/db/init_db.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../objects/sailor.dart';

class SailorWidgetVardies extends StatefulWidget {
  const SailorWidgetVardies({super.key, required this.sailor});
  final Sailor sailor;
  @override
  State<SailorWidgetVardies> createState() => _SailorWidgetVardiesState();
}

class _SailorWidgetVardiesState extends State<SailorWidgetVardies> {
  late bool avardiotos;

  @override
  void initState() {
    avardiotos = widget.sailor.avardiotos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: .zero,
      content: Padding(
        padding: .symmetric(horizontal: padding, vertical: padding),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Βάρδιες', style: FluentTheme.of(context).typography.title),
            const Gap(padding),
            Row(
              children: [
                Text('Απαλλαγή βαρδιών'),
                const Gap(10),
                Checkbox(
                  checked: avardiotos,
                  onChanged: (avar) async {
                    await (db.update(db.tableSailors)
                          ..where((s) => s.id.equals(widget.sailor.id)))
                        .write(TableSailorsCompanion(avardiotos: Value(avar!)));
                    setState(() {
                      avardiotos = avar;
                    });

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
