import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/sailor_widget_adeies.dart';
import 'package:milibase/sailor_page/apomakrynseis/sailor_widget_apomakrynseis.dart';
import 'package:milibase/sailor_page/metavoles/sailor_widget_metavoles.dart';
import 'package:milibase/sailor_page/sailors/sailor_widget_info.dart';
import 'package:milibase/sailor_page/sailors/sailor_widget_settings.dart';
import 'package:milibase/styles/button.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

class SailorPage extends StatefulWidget {
  const SailorPage({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorPage> createState() => _SailorPageState();
}

class _SailorPageState extends State<SailorPage> {
  int _selectedIndex = 0;

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return SailorWidgetInfo(sailor: widget.sailor);
      case 1:
        return SailorWidgetAdeies(sailor: widget.sailor);
      case 2:
        return SailorWidgetApomakrynseis(sailor: widget.sailor);
      case 3:
        return SailorWidgetMetavoles(sailor: widget.sailor);
      case 5:
        return SailorWidgetSettings(sailor: widget.sailor);
      default:
        return SailorWidgetInfo(sailor: widget.sailor);
    }
  }

  void _select(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Row(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.sailor.rank.label} (${widget.sailor.specialty.label})',
                      ),
                      const Gap(5),
                      AutoSizeText(
                        '${widget.sailor.surname}\n${widget.sailor.name}',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      const Gap(padding * 2),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black.withAlpha(60)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FluentButton(
                              onPressed: () => _select(0),
                              selected: _selectedIndex == 0,
                              icon: const WindowsIcon(WindowsIcons.i_d_badge),
                              text: 'Επισκόπηση',
                            ),
                            const Divider(),
                            FluentButton(
                              onPressed: () => _select(1),
                              selected: _selectedIndex == 1,
                              icon: const WindowsIcon(WindowsIcons.page_left),
                              text: 'Άδειες',
                            ),
                            const Divider(),
                            FluentButton(
                              onPressed: () => _select(2),
                              selected: _selectedIndex == 2,
                              icon: const WindowsIcon(WindowsIcons.remove),
                              text: 'Απομακρύνσεις',
                            ),
                            const Divider(),
                            FluentButton(
                              onPressed: () => _select(3),
                              selected: _selectedIndex == 3,
                              icon: const WindowsIcon(WindowsIcons.shuffle),
                              text: 'Μεταβολές',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  right: 15,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const WindowsIcon(
                          WindowsIcons.chrome_back,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const WindowsIcon(
                          WindowsIcons.settings,
                          size: 24,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            _selectedIndex == 5 ? secColor : null,
                          ),
                        ),
                        onPressed: () => _select(5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 6, child: _buildScreen()),
        ],
      ),
    );
  }
}
