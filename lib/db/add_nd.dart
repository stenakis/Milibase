import 'package:drift/drift.dart';

import '../objects/sailor.dart';
import '../main.dart';
import 'init_db.dart';

Future<void> addSailor(Sailor sailor) async {
  await db
      .into(db.tableSailors)
      .insertOnConflictUpdate(
        TableSailorsCompanion.insert(
          id: Value(sailor.id),
          surname: sailor.surname,
          name: sailor.name,
          agm: sailor.agm,
          specialty: sailor.specialty,
          mobile: sailor.mobile,
          landline: sailor.landline,
          address: sailor.address,
          education: sailor.education,
          rank: sailor.rank,
          servingMonths: sailor.servingMonths,
          dateArrival: sailor.dateArrival,
          dateInsert: sailor.dateInsert,
          dateRemoval: sailor.dateRemoval,
          avardiotos: Value(sailor.avardiotos),
        ),
      );
}
