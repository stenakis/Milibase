import 'package:drift/drift.dart';
import '../objects/adeies.dart';
import '../objects/apomakrynseis.dart';
import '../objects/metavoles.dart';
import '../objects/specialty.dart';
import 'package:uuid/uuid.dart';

import '../objects/rank.dart';

// dart run build_runner build --delete-conflicting-outputs

class TableSailors extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get surname => text()();
  TextColumn get agm => text()();
  TextColumn get rank => textEnum<Rank>()();
  TextColumn get specialty => textEnum<Specialty>()();
  TextColumn get address => text()();
  TextColumn get mobile => text()();
  TextColumn get landline => text()();
  TextColumn get education => text()();
  IntColumn get servingMonths => integer()();
  DateTimeColumn get dateArrival => dateTime()();
  DateTimeColumn get dateInsert => dateTime()();
  DateTimeColumn get dateRemoval => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TableAdeies extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get dateStart => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dateEnd => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => textEnum<Adeia>()();
  TextColumn get sima => text()();
  TextColumn get sailorId =>
      text().references(TableSailors, #id, onDelete: KeyAction.cascade)();
}

class TableApomakrynseis extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get dateStart => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dateEnd => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => textEnum<Apomakrynsi>()();
  TextColumn get sima => text()();
  TextColumn get ypiresia => text()();
  TextColumn get sailorId =>
      text().references(TableSailors, #id, onDelete: KeyAction.cascade)();
}

class TableMetavoles extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => textEnum<Metavoli>()();
  TextColumn get sima => text()();
  TextColumn get sailorId =>
      text().references(TableSailors, #id, onDelete: KeyAction.cascade)();
  IntColumn get duration => integer().nullable()();
}
