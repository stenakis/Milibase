import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/sailor_widget_adeies.dart';
import 'package:milibase/sailor_page/apomakrynseis/sailor_widget_apomakrynseis.dart';
import 'package:milibase/sailor_page/metavoles/sailor_widget_metavoles.dart';
import 'package:milibase/sailor_page/sailor_widget_info.dart';
import 'package:milibase/sailor_page/sailor_widget_settings.dart';
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
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetInfo(sailor: widget.sailor);
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
                          ),
                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetInfo(sailor: widget.sailor);
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.info),
                                  Gap(10),
                                  Text('Στοιχεία'),
                                ],
                              ),
                            ),
                          ),
                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetAdeies(
                                sailor: widget.sailor,
                              );
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.remove),
                                  Gap(10),
                                  Text('Άδειες'),
                                ],
                              ),
                            ),
                          ),
                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetApomakrynseis(
                                sailor: widget.sailor,
                              );
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.remove),
                                  Gap(10),
                                  Text('Απομακρύνσεις'),
                                ],
                              ),
                            ),
                          ),
                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetMetavoles(
                                sailor: widget.sailor,
                              );
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.remove),
                                  Gap(10),
                                  Text('Μεταβολές'),
                                ],
                              ),
                            ),
                          ),

                          Button(
                            onPressed: () => setState(() {
                              screen = SailorWidgetSettings(
                                sailor: widget.sailor,
                              );
                            }),
                            child: Container(
                              padding: .all(10),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  WindowsIcon(WindowsIcons.settings),
                                  Gap(10),
                                  Text('Ρυθμίσεις'),
                                ],
                              ),
                            ),
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
                child: IconButton(
                  icon: WindowsIcon(WindowsIcons.chrome_back, size: 20),
                  onPressed: () => Navigator.pop(context),
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
