import 'package:drift/drift.dart';

import '../../db/init_db.dart';
import '../../main.dart';
import '../../objects/metavoles.dart';

Future<void> addNewMetavoli(Metavoles metavoli) async {
  await db
      .into(db.tableMetavoles)
      .insert(
        TableMetavolesCompanion.insert(
          sailorId: metavoli.sailorId,
          date: Value(metavoli.date),
          type: metavoli.type,
          sima: metavoli.sima,
          duration: Value(metavoli.duration),
        ),
      );
}

Future<void> deleteMetavoli(String id) async {
  await (db.delete(db.tableMetavoles)..where((t) => t.id.equals(id))).go();
}
