import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/katalogos_nd.dart';
import 'package:milibase/navigation.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/styles/typography.dart';
import 'package:milibase/variables.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db/init_db.dart';

final db = AppDatabase();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactoryFfi;
  runApp(const MyApp());
  doWhenWindowReady(() {
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      locale: const Locale('el'),
      title: 'Milibase',
      theme: FluentThemeData(
        accentColor: primary.toAccentColor(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        typography: getInterTypography(Brightness.light),
        visualDensity: VisualDensity.standard,
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const Navigation(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(content: KatalogosNd());
  }
}
