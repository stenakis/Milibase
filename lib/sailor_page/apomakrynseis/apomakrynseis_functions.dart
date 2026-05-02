import 'package:drift/drift.dart';

import '../../db/init_db.dart';
import '../../main.dart';
import '../../objects/apomakrynseis.dart';

Future<void> addNewApomakrynsi(Apomakrynseis apomakrynsi) async {
  await db
      .into(db.tableApomakrynseis)
      .insertOnConflictUpdate(
        TableApomakrynseisCompanion.insert(
          id: Value(apomakrynsi.id),
          sailorId: apomakrynsi.sailorId,
          dateStart: Value(apomakrynsi.dateStart),
          dateEnd: Value(apomakrynsi.dateEnd),
          type: apomakrynsi.type,
          sima: apomakrynsi.sima,
          ypiresia: apomakrynsi.ypiresia,
        ),
      );
}

Future<void> deleteApomakrynsi(Apomakrynseis apomakrynsi) async {
  await (db.delete(
    db.tableApomakrynseis,
  )..where((t) => t.id.equals(apomakrynsi.id))).go();
}
