import 'dart:convert';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/main.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportBackup(BuildContext context) async {
  try {
    final sailors = await db
        .customSelect('SELECT * FROM "table_sailors"')
        .get();
    final adeies = await db.customSelect('SELECT * FROM "table_adeies"').get();
    final metavoles = await db
        .customSelect('SELECT * FROM "table_metavoles"')
        .get();
    final apomakrynseis = await db
        .customSelect('SELECT * FROM "table_apomakrynseis"')
        .get();
    final vars = await db.customSelect('SELECT * FROM "vars"').get();

    final backup = {
      'table_sailors': sailors.map((r) => r.data).toList(),
      'table_adeies': adeies.map((r) => r.data).toList(),
      'table_metavoles': metavoles.map((r) => r.data).toList(),
      'table_apomakrynseis': apomakrynseis.map((r) => r.data).toList(),
      'vars': vars.map((r) => r.data).toList(),
    };

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/backup.json');
    await file.writeAsString(jsonEncode(backup));
    await showCustomInfoBar(
      context: context,
      title: 'Επιτυχές:',
      text: 'Δημιουργία backup: ${file.path}',
      severity: .success,
    );
  } catch (e) {
    await showCustomInfoBar(context: context, text: e.toString());
  }
}

Future<void> importBackup(BuildContext context) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/backup.json');
    final backup =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    await db.transaction(() async {
      await db.customStatement('PRAGMA foreign_keys = OFF');
      for (final table in [
        'table_sailors',
        'table_adeies',
        'table_metavoles',
        'table_apomakrynseis',
        'vars',
      ]) {
        final rows = backup[table] as List<dynamic>;
        for (final row in rows) {
          final data = row as Map<String, dynamic>;
          final cols = data.keys.map((k) => '"$k"').join(', ');
          final placeholders = data.keys.map((_) => '?').join(', ');
          await db.customStatement(
            'INSERT OR REPLACE INTO "$table" ($cols) VALUES ($placeholders)',
            data.values.toList(),
          );
        }
      }

      await db.customStatement('PRAGMA foreign_keys = ON');
    });
    await showCustomInfoBar(
      context: context,
      title: 'Επιτυχές:',
      text: 'Επιτυχής εισαγωγή',
      severity: .success,
    );
  } catch (e) {
    await showCustomInfoBar(context: context, text: e.toString());
  }
}
