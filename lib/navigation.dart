import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:milibase/katalogos_nd.dart';
import 'package:milibase/main.dart';
import 'package:milibase/settings.dart';
import 'package:milibase/styles/button.dart';
import 'package:milibase/vardies.dart';
import 'package:milibase/variables.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

final GlobalKey<NavigatorState> mainInnerKey = GlobalKey<NavigatorState>();

class _NavigationState extends State<Navigation> {
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: .zero,
      content: Navigator(
        key: mainInnerKey,
        onGenerateRoute: (settings) {
          return FluentPageRoute(builder: (context) => const MyHomePage());
        },
      ),
      header: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            Gap(padding),
            SvgPicture.asset('assets/logo_large.svg', height: 25),
            Text(
              'Milibase',
              style: FluentTheme.of(
                context,
              ).typography.title?.copyWith(color: Colors.white),
            ),

            Expanded(child: WindowTitleBarBox(child: MoveWindow())),
            /*FluentButton(
              selected: selected == 0,
              text: 'Βάρδιες',
              onPressed: () {
                setState(() {
                  selected = 0;
                });
                mainInnerKey.currentState?.pushReplacement(
                  FluentPageRoute(
                    builder: (context) {
                      return const VardiesPage();
                    },
                  ),
                );
              },
            ),
            Gap(10),
            FluentButton(
              selected: selected == 1,
              text: 'Βάση',
              onPressed: () {
                setState(() {
                  selected = 1;
                });
                mainInnerKey.currentState?.pushReplacement(
                  FluentPageRoute(
                    builder: (context) {
                      return const KatalogosNd();
                    },
                  ),
                );
              },
            ),
            Expanded(child: WindowTitleBarBox(child: MoveWindow())),*/
            Image.asset('assets/faron.png', height: 25),
            Gap(5),
            Text('Υπηρεσία Φάρων'),
            Gap(padding),
            IconButton(
              onPressed: () {
                mainInnerKey.currentState?.push(
                  FluentPageRoute(
                    builder: (context) {
                      return const SettingsPage();
                    },
                  ),
                );
              },
              icon: const WindowsIcon(WindowsIcons.settings, size: 20),
            ),
            SizedBox(
              width: padding,
              child: WindowTitleBarBox(child: MoveWindow()),
            ),
            SizedBox(
              width: 138,
              height: 60,
              child: WindowTitleBarBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MinimizeWindowButton(colors: buttonColors),
                    MaximizeWindowButton(colors: buttonColors),
                    CloseWindowButton(colors: closeButtonColors),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0xFFE1E1E1),
  mouseDown: const Color(0xFFC1C1C1),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: const Color(0xFF805306),
  iconMouseOver: Colors.white,
);
