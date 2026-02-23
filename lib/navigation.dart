import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/main.dart';
import 'package:milibase/vardies.dart';
import 'package:milibase/variables.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final GlobalKey<NavigatorState> _mainInnerKey = GlobalKey<NavigatorState>();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Navigator(
        key: _mainInnerKey,
        onGenerateRoute: (settings) {
          return FluentPageRoute(builder: (context) => const MyHomePage());
        },
      ),
      header: Container(
        color: Colors.white,
        padding: .symmetric(horizontal: padding, vertical: 0),
        child: Row(
          children: [
            Text('Milibase', style: FluentTheme.of(context).typography.title),
            Spacer(),

            Button(
              onPressed: () {
                // This pushes the new page INSIDE the Pane body
                _mainInnerKey.currentState?.push(
                  FluentPageRoute(
                    builder: (context) {
                      return const VardiesPage();
                    },
                  ),
                );
              },
              child: Padding(
                padding: .symmetric(vertical: 10),
                child: Center(
                  child: Row(
                    children: [
                      const WindowsIcon(WindowsIcons.arrow_down8, size: 24),
                      Gap(10),
                      const Text('Βάρδιες', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            Gap(10),
            Button(
              onPressed: () {
                _mainInnerKey.currentState?.push(
                  FluentPageRoute(
                    builder: (context) {
                      return const MyHomePage();
                    },
                  ),
                );
              },
              child: Padding(
                padding: .symmetric(vertical: 10),
                child: Center(
                  child: Row(
                    children: [
                      const WindowsIcon(WindowsIcons.phone_book, size: 24),
                      Gap(10),
                      const Text('Κατάλογος', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            const Text('Υπηρεσία Φάρων'),
          ],
        ),
      ),
    );
  }
}
