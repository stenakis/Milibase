import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/sailor_widget_adeies.dart';
import 'package:milibase/sailor_page/apomakrynseis/sailor_widget_apomakrynseis.dart';
import 'package:milibase/sailor_page/metavoles/sailor_widget_metavoles.dart';
import 'package:milibase/sailor_page/sailor_widget_info.dart';
import 'package:milibase/sailor_page/sailor_widget_settings.dart';
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
  int selectedIndex = 0;
  late Widget screen;
  @override
  void initState() {
    screen = SailorWidgetInfo(sailor: widget.sailor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: .symmetric(horizontal: 70),
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.sailor.rank.label} (${widget.sailor.specialty.label})',
                      ),
                      Gap(5),
                      Text(
                        '${widget.sailor.surname}\n${widget.sailor.name}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: .bold,
                          color: primary,
                        ),
                      ),
                      Gap(padding),
                      Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        spacing: 7,
                        children: [
                          /*Button(
                            onPressed: () => setState(() {
                              screen = SailorPagePreview();
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.smartcard),
                                  Gap(10),
                                  Text('Προεπισκόπηση'),
                                ],
                              ),
                            ),
                          ),*/
                          FluentButton(
                            onPressed: () => setState(() {
                              selectedIndex = 0;
                              screen = SailorWidgetInfo(sailor: widget.sailor);
                            }),
                            selected: selectedIndex == 0,
                            icon: WindowsIcon(WindowsIcons.info),
                            text: 'Στοιχεία',
                          ),
                          FluentButton(
                            onPressed: () => setState(() {
                              selectedIndex = 1;
                              screen = SailorWidgetAdeies(
                                sailor: widget.sailor,
                              );
                            }),
                            selected: selectedIndex == 1,
                            icon: WindowsIcon(WindowsIcons.remove),
                            text: 'Άδειες',
                          ),
                          FluentButton(
                            onPressed: () => setState(() {
                              selectedIndex = 2;
                              screen = SailorWidgetApomakrynseis(
                                sailor: widget.sailor,
                              );
                            }),
                            selected: selectedIndex == 2,
                            icon: WindowsIcon(WindowsIcons.remove),
                            text: 'Απομακρύνσεις',
                          ),
                          FluentButton(
                            onPressed: () => setState(() {
                              selectedIndex = 3;
                              screen = SailorWidgetMetavoles(
                                sailor: widget.sailor,
                              );
                            }),
                            selected: selectedIndex == 3,
                            icon: WindowsIcon(WindowsIcons.update_restore),
                            text: 'Μεταβολές',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: WindowsIcon(WindowsIcons.chrome_back, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Spacer(),
                    IconButton(
                      icon: WindowsIcon(WindowsIcons.settings, size: 24),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          selectedIndex == 4 ? secColor : Colors.white,
                        ),
                      ),
                      onPressed: () => setState(() {
                        selectedIndex = 4;
                        screen = SailorWidgetSettings(sailor: widget.sailor);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 5, child: screen),
      ],
    );
  }
}
