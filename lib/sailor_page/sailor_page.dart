import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/sailor_widget_adeies.dart';
import 'package:milibase/sailor_page/apomakrynseis/sailor_widget_apomakrynseis.dart';
import 'package:milibase/sailor_page/sailor_widget_info.dart';
import 'package:milibase/sailor_page/sailor_widget_metavoles.dart';
import 'package:milibase/sailor_page/sailor_widget_vardies.dart';
import 'package:milibase/variables.dart';

class SailorPage extends StatefulWidget {
  const SailorPage({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorPage> createState() => _SailorPageState();
}

class _SailorPageState extends State<SailorPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        toggleable: false,
        toggleButton: Container(),
        displayMode: PaneDisplayMode.expanded,
        selected: selectedIndex,
        onChanged: (index) => setState(() => selectedIndex = index),
        header: Padding(
          padding: .symmetric(vertical: padding),
          child: Row(
            children: [
              ?Navigator.canPop(context)
                  ? IconButton(
                      icon: const WindowsIcon(WindowsIcons.back),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              Gap(10),
              Expanded(
                child: Text(
                  '${widget.sailor.surname} ${widget.sailor.name}',
                  style: FluentTheme.of(context).typography.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        items: [
          PaneItem(
            title: Text('Στοιχεία'),
            icon: WindowsIcon(WindowsIcons.info),
            body: SailorWidgetInfo(sailor: widget.sailor),
          ),

          PaneItem(
            title: Text('Άδειες'),
            icon: WindowsIcon(WindowsIcons.remove),
            body: SailorWidgetAdeies(sailor: widget.sailor),
          ),
          PaneItem(
            title: Text('Απομακρύνσεις'),
            icon: WindowsIcon(WindowsIcons.remove),
            body: SailorWidgetApomakrynseis(sailor: widget.sailor),
          ),

          PaneItem(
            title: Text('Μεταβολές'),
            icon: WindowsIcon(WindowsIcons.chat_bubbles),
            body: SailorWidgetMetavoles(sailor: widget.sailor),
          ),
          PaneItem(
            title: Text('Βάρδιες'),
            icon: WindowsIcon(WindowsIcons.bookmarks),
            body: SailorWidgetVardies(sailor: widget.sailor),
          ),
        ],
      ),
    );
  }
}
