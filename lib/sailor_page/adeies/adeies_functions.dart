import 'package:drift/drift.dart';

import '../../db/init_db.dart';
import '../../main.dart';
import '../../objects/adeies.dart';

Future<void> addNewAdeia(Adeies adeia) async {
  await db
      .into(db.tableAdeies)
      .insertOnConflictUpdate(
        TableAdeiesCompanion.insert(
          id: Value(adeia.id),
          sailorId: adeia.sailorId,
          dateStart: Value(adeia.dateStart),
          dateEnd: Value(adeia.dateEnd),
          type: adeia.type,
          sima: adeia.sima ?? '',
        ),
      );
}

Future<void> deleteAdeia(Adeies adeia) async {
  await (db.delete(db.tableAdeies)..where((t) => t.id.equals(adeia.id))).go();
}
