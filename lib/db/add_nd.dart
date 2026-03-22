import '../main.dart';
import 'init_db.dart';

void addND() async {
  await db
      .into(db.tableSailors)
      .insert(
        TableSailorsCompanion.insert(
          surname: 'Στενάκης',
          name: 'Ευάγγελος',
          agm: '96422',
          specialty: .t_hn,
          mobile: '698',
          landline: '213',
          address: 'sdfaf',
          education: 'adfadsf',
          rank: .diopos,
          servingMonths: 9,
          dateArrival: DateTime.now(),
          dateInsert: DateTime.now(),
          dateRemoval: DateTime.now(),
        ),
      );
}
