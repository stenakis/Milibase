import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:milibase/db/tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../objects/adeies.dart';
import '../objects/apomakrynseis.dart';
import '../objects/metavoles.dart';
import '../objects/rank.dart';
import '../objects/specialty.dart';

part 'init_db.g.dart';

@DriftDatabase(
  tables: [TableAdeies, TableMetavoles, TableSailors, TableApomakrynseis],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'sailors_database.sqlite'));

    // THIS LINE IS YOUR BEST FRIEND:
    print('DATABASE PATH: ${file.path}');

    return NativeDatabase.createInBackground(file);
  });
}
