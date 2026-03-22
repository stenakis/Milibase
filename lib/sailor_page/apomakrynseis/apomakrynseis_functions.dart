import 'package:drift/src/runtime/data_class.dart';
import 'package:milibase/objects/apomakrynseis.dart';

import '../../db/init_db.dart';
import '../../main.dart';

Future<void> addNewApomakrynsi(Apomakrynseis apomakrynsi) async {
  await db
      .into(db.tableApomakrynseis)
      .insert(
        TableApomakrynseisCompanion.insert(
          sailorId: apomakrynsi.sailorId,
          dateStart: Value(apomakrynsi.dateStart),
          dateEnd: Value(apomakrynsi.dateEnd),
          type: apomakrynsi.type,
          sima: apomakrynsi.sima,
          ypiresia: apomakrynsi.ypiresia,
        ),
      );
}

Future<void> deleteApomakrynsi(String id) async {
  await (db.delete(db.tableApomakrynseis)..where((t) => t.id.equals(id))).go();
}
