import 'dart:io';

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
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
  if(!Platform.isLinux) {
    doWhenWindowReady(() {
    appWindow.minSize = const Size(600, 450);
    appWindow.size = const Size(1280, 721);
    appWindow.show();
    Future.delayed(Duration.zero, () {
      appWindow.size = const Size(1280, 720);
    });
  });
  }
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
        typography: getTypography(Brightness.light),
        visualDensity: VisualDensity.standard,
        navigationPaneTheme: const NavigationPaneThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const Navigation(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KatalogosNd();
  }
}
