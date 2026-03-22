import 'package:drift/drift.dart';
import 'package:milibase/objects/adeies.dart';

import '../../db/init_db.dart';
import '../../main.dart';

Future<void> addNewAdeia(Adeies adeia) async {
  await db
      .into(db.tableAdeies)
      .insert(
        TableAdeiesCompanion.insert(
          sailorId: adeia.sailorId,
          dateStart: Value(adeia.dateStart),
          dateEnd: Value(adeia.dateEnd),
          type: adeia.type,
          sima: adeia.sima ?? '',
        ),
      );
}

Future<void> deleteAdeia(String id) async {
  await (db.delete(db.tableAdeies)..where((t) => t.id.equals(id))).go();
}
