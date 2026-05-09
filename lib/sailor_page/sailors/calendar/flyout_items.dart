import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:uuid/uuid.dart';

import '../../../objects/adeies.dart';
import '../../../objects/metavoles.dart';
import '../../adeies/adeies_content_dialog.dart';
import '../../apomakrynseis/apomakrynseis_content_dialog.dart';
import '../../metavoles/metavoles_content_dialog.dart';
import 'calendar_view.dart';

class MenuFlyoutWidget extends StatelessWidget {
  const MenuFlyoutWidget({super.key, required this.dayCell});

  final DayCell dayCell;

  @override
  Widget build(BuildContext context) {
    return MenuFlyout(
      items: [
        MenuFlyoutItem(
          leading: const WindowsIcon(WindowsIcons.page_left),
          text: const Text('Νέα Άδεια'),
          onPressed: () async {
            await showDialog<String>(
              context: context,
              builder: (context) => ShowAdeiesDialog(
                sailor: dayCell.sailor,
                adeia: Adeies(
                  type: .kanoniki,
                  dateStart: dayCell.date,
                  dateEnd: dayCell.date,
                  sailorId: dayCell.sailor.id,
                  id: const Uuid().v4(),
                ),
              ),
            );
            if (context.mounted) {
              Flyout.of(context).close;
            }
          },
        ),
        MenuFlyoutItem(
          leading: const WindowsIcon(WindowsIcons.remove),
          text: const Text('Νέα Απομάκρυνση'),
          onPressed: () async {
            await showDialog<String>(
              context: context,
              builder: (context) => ShowApomakrynseisDialog(
                sailor: dayCell.sailor,
                id: Apomakrynseis(
                  id: const Uuid().v4(),
                  type: .apospasi,
                  dateStart: dayCell.date,
                  dateEnd: dayCell.date,
                  sailorId: dayCell.sailor.id,
                  ypiresia: '',
                  sima: '',
                ),
              ),
            );
            if (context.mounted) {
              Flyout.of(context).close;
            }
          },
        ),
        MenuFlyoutItem(
          leading: const WindowsIcon(WindowsIcons.shuffle),
          text: const Text('Νέα Μεταβολή'),
          onPressed: () async {
            await showDialog<String>(
              context: context,
              builder: (context) => ShowMetavolesDialog(
                sailor: dayCell.sailor,
                id: Metavoles(
                  type: .meiomeni,
                  date: dayCell.date,
                  sima: '',
                  sailorId: dayCell.sailor.id,
                  id: const Uuid().v4(),
                ),
              ),
            );
            if (context.mounted) {
              Flyout.of(context).close;
            }
          },
        ),
      ],
    );
  }
}
