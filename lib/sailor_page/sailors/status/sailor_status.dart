import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';
import '../../../objects/adeies.dart';

final today = DateTime.now();

extension DateRangeCheck on DateTime {
  bool isWithin(DateTime start, DateTime end) {
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);
    final t = DateTime(year, month, day);
    return !t.isBefore(s) && !t.isAfter(e);
  }
}

Stream<(bool, bool)> checkStatus(Sailor sailor) {
  Stream<List<Adeies>> adeies =
      (db.select(
        db.tableAdeies,
      )..where((t) => t.sailorId.equals(sailor.id))).watch().map(
        (rows) => rows.map((row) => Adeies.fromJson(row.toJson())).toList(),
      );

  Stream<List<Apomakrynseis>> apomakrynseis =
      (db.select(
        db.tableApomakrynseis,
      )..where((t) => t.sailorId.equals(sailor.id))).watch().map(
        (rows) =>
            rows.map((row) => Apomakrynseis.fromJson(row.toJson())).toList(),
      );

  Stream<(bool, bool)> hasActiveRecords = Rx.combineLatest2(
    adeies,
    apomakrynseis,

    (List<Adeies> adeies, List<Apomakrynseis> apomakrynseis) => (
      adeies.any((a) => today.isWithin(a.dateStart, a.dateEnd)),
      apomakrynseis.any((a) => today.isWithin(a.dateStart, a.dateEnd)),
    ),
  );
  return hasActiveRecords;
}
