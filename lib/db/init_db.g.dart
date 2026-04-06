// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_db.dart';

// ignore_for_file: type=lint
class $TableSailorsTable extends TableSailors
    with TableInfo<$TableSailorsTable, TableSailor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableSailorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surnameMeta = const VerificationMeta(
    'surname',
  );
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
    'surname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agmMeta = const VerificationMeta('agm');
  @override
  late final GeneratedColumn<String> agm = GeneratedColumn<String>(
    'agm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Rank, String> rank =
      GeneratedColumn<String>(
        'rank',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Rank>($TableSailorsTable.$converterrank);
  @override
  late final GeneratedColumnWithTypeConverter<Specialty, String> specialty =
      GeneratedColumn<String>(
        'specialty',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Specialty>($TableSailorsTable.$converterspecialty);
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _landlineMeta = const VerificationMeta(
    'landline',
  );
  @override
  late final GeneratedColumn<String> landline = GeneratedColumn<String>(
    'landline',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _educationMeta = const VerificationMeta(
    'education',
  );
  @override
  late final GeneratedColumn<String> education = GeneratedColumn<String>(
    'education',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingMonthsMeta = const VerificationMeta(
    'servingMonths',
  );
  @override
  late final GeneratedColumn<int> servingMonths = GeneratedColumn<int>(
    'serving_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateArrivalMeta = const VerificationMeta(
    'dateArrival',
  );
  @override
  late final GeneratedColumn<DateTime> dateArrival = GeneratedColumn<DateTime>(
    'date_arrival',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateInsertMeta = const VerificationMeta(
    'dateInsert',
  );
  @override
  late final GeneratedColumn<DateTime> dateInsert = GeneratedColumn<DateTime>(
    'date_insert',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateRemovalMeta = const VerificationMeta(
    'dateRemoval',
  );
  @override
  late final GeneratedColumn<DateTime> dateRemoval = GeneratedColumn<DateTime>(
    'date_removal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    surname,
    agm,
    rank,
    specialty,
    address,
    mobile,
    landline,
    education,
    servingMonths,
    dateArrival,
    dateInsert,
    dateRemoval,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_sailors';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableSailor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('surname')) {
      context.handle(
        _surnameMeta,
        surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta),
      );
    } else if (isInserting) {
      context.missing(_surnameMeta);
    }
    if (data.containsKey('agm')) {
      context.handle(
        _agmMeta,
        agm.isAcceptableOrUnknown(data['agm']!, _agmMeta),
      );
    } else if (isInserting) {
      context.missing(_agmMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('landline')) {
      context.handle(
        _landlineMeta,
        landline.isAcceptableOrUnknown(data['landline']!, _landlineMeta),
      );
    } else if (isInserting) {
      context.missing(_landlineMeta);
    }
    if (data.containsKey('education')) {
      context.handle(
        _educationMeta,
        education.isAcceptableOrUnknown(data['education']!, _educationMeta),
      );
    } else if (isInserting) {
      context.missing(_educationMeta);
    }
    if (data.containsKey('serving_months')) {
      context.handle(
        _servingMonthsMeta,
        servingMonths.isAcceptableOrUnknown(
          data['serving_months']!,
          _servingMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_servingMonthsMeta);
    }
    if (data.containsKey('date_arrival')) {
      context.handle(
        _dateArrivalMeta,
        dateArrival.isAcceptableOrUnknown(
          data['date_arrival']!,
          _dateArrivalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateArrivalMeta);
    }
    if (data.containsKey('date_insert')) {
      context.handle(
        _dateInsertMeta,
        dateInsert.isAcceptableOrUnknown(data['date_insert']!, _dateInsertMeta),
      );
    } else if (isInserting) {
      context.missing(_dateInsertMeta);
    }
    if (data.containsKey('date_removal')) {
      context.handle(
        _dateRemovalMeta,
        dateRemoval.isAcceptableOrUnknown(
          data['date_removal']!,
          _dateRemovalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateRemovalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableSailor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableSailor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      surname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surname'],
      )!,
      agm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agm'],
      )!,
      rank: $TableSailorsTable.$converterrank.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rank'],
        )!,
      ),
      specialty: $TableSailorsTable.$converterspecialty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}specialty'],
        )!,
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      )!,
      landline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}landline'],
      )!,
      education: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}education'],
      )!,
      servingMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}serving_months'],
      )!,
      dateArrival: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_arrival'],
      )!,
      dateInsert: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_insert'],
      )!,
      dateRemoval: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_removal'],
      )!,
    );
  }

  @override
  $TableSailorsTable createAlias(String alias) {
    return $TableSailorsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Rank, String, String> $converterrank =
      const EnumNameConverter<Rank>(Rank.values);
  static JsonTypeConverter2<Specialty, String, String> $converterspecialty =
      const EnumNameConverter<Specialty>(Specialty.values);
}

class TableSailor extends DataClass implements Insertable<TableSailor> {
  final String id;
  final String name;
  final String surname;
  final String agm;
  final Rank rank;
  final Specialty specialty;
  final String address;
  final String mobile;
  final String landline;
  final String education;
  final int servingMonths;
  final DateTime dateArrival;
  final DateTime dateInsert;
  final DateTime dateRemoval;
  const TableSailor({
    required this.id,
    required this.name,
    required this.surname,
    required this.agm,
    required this.rank,
    required this.specialty,
    required this.address,
    required this.mobile,
    required this.landline,
    required this.education,
    required this.servingMonths,
    required this.dateArrival,
    required this.dateInsert,
    required this.dateRemoval,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['surname'] = Variable<String>(surname);
    map['agm'] = Variable<String>(agm);
    {
      map['rank'] = Variable<String>(
        $TableSailorsTable.$converterrank.toSql(rank),
      );
    }
    {
      map['specialty'] = Variable<String>(
        $TableSailorsTable.$converterspecialty.toSql(specialty),
      );
    }
    map['address'] = Variable<String>(address);
    map['mobile'] = Variable<String>(mobile);
    map['landline'] = Variable<String>(landline);
    map['education'] = Variable<String>(education);
    map['serving_months'] = Variable<int>(servingMonths);
    map['date_arrival'] = Variable<DateTime>(dateArrival);
    map['date_insert'] = Variable<DateTime>(dateInsert);
    map['date_removal'] = Variable<DateTime>(dateRemoval);
    return map;
  }

  TableSailorsCompanion toCompanion(bool nullToAbsent) {
    return TableSailorsCompanion(
      id: Value(id),
      name: Value(name),
      surname: Value(surname),
      agm: Value(agm),
      rank: Value(rank),
      specialty: Value(specialty),
      address: Value(address),
      mobile: Value(mobile),
      landline: Value(landline),
      education: Value(education),
      servingMonths: Value(servingMonths),
      dateArrival: Value(dateArrival),
      dateInsert: Value(dateInsert),
      dateRemoval: Value(dateRemoval),
    );
  }

  factory TableSailor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableSailor(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      surname: serializer.fromJson<String>(json['surname']),
      agm: serializer.fromJson<String>(json['agm']),
      rank: $TableSailorsTable.$converterrank.fromJson(
        serializer.fromJson<String>(json['rank']),
      ),
      specialty: $TableSailorsTable.$converterspecialty.fromJson(
        serializer.fromJson<String>(json['specialty']),
      ),
      address: serializer.fromJson<String>(json['address']),
      mobile: serializer.fromJson<String>(json['mobile']),
      landline: serializer.fromJson<String>(json['landline']),
      education: serializer.fromJson<String>(json['education']),
      servingMonths: serializer.fromJson<int>(json['servingMonths']),
      dateArrival: serializer.fromJson<DateTime>(json['dateArrival']),
      dateInsert: serializer.fromJson<DateTime>(json['dateInsert']),
      dateRemoval: serializer.fromJson<DateTime>(json['dateRemoval']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'surname': serializer.toJson<String>(surname),
      'agm': serializer.toJson<String>(agm),
      'rank': serializer.toJson<String>(
        $TableSailorsTable.$converterrank.toJson(rank),
      ),
      'specialty': serializer.toJson<String>(
        $TableSailorsTable.$converterspecialty.toJson(specialty),
      ),
      'address': serializer.toJson<String>(address),
      'mobile': serializer.toJson<String>(mobile),
      'landline': serializer.toJson<String>(landline),
      'education': serializer.toJson<String>(education),
      'servingMonths': serializer.toJson<int>(servingMonths),
      'dateArrival': serializer.toJson<DateTime>(dateArrival),
      'dateInsert': serializer.toJson<DateTime>(dateInsert),
      'dateRemoval': serializer.toJson<DateTime>(dateRemoval),
    };
  }

  TableSailor copyWith({
    String? id,
    String? name,
    String? surname,
    String? agm,
    Rank? rank,
    Specialty? specialty,
    String? address,
    String? mobile,
    String? landline,
    String? education,
    int? servingMonths,
    DateTime? dateArrival,
    DateTime? dateInsert,
    DateTime? dateRemoval,
  }) => TableSailor(
    id: id ?? this.id,
    name: name ?? this.name,
    surname: surname ?? this.surname,
    agm: agm ?? this.agm,
    rank: rank ?? this.rank,
    specialty: specialty ?? this.specialty,
    address: address ?? this.address,
    mobile: mobile ?? this.mobile,
    landline: landline ?? this.landline,
    education: education ?? this.education,
    servingMonths: servingMonths ?? this.servingMonths,
    dateArrival: dateArrival ?? this.dateArrival,
    dateInsert: dateInsert ?? this.dateInsert,
    dateRemoval: dateRemoval ?? this.dateRemoval,
  );
  TableSailor copyWithCompanion(TableSailorsCompanion data) {
    return TableSailor(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      surname: data.surname.present ? data.surname.value : this.surname,
      agm: data.agm.present ? data.agm.value : this.agm,
      rank: data.rank.present ? data.rank.value : this.rank,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      address: data.address.present ? data.address.value : this.address,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      landline: data.landline.present ? data.landline.value : this.landline,
      education: data.education.present ? data.education.value : this.education,
      servingMonths: data.servingMonths.present
          ? data.servingMonths.value
          : this.servingMonths,
      dateArrival: data.dateArrival.present
          ? data.dateArrival.value
          : this.dateArrival,
      dateInsert: data.dateInsert.present
          ? data.dateInsert.value
          : this.dateInsert,
      dateRemoval: data.dateRemoval.present
          ? data.dateRemoval.value
          : this.dateRemoval,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableSailor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('agm: $agm, ')
          ..write('rank: $rank, ')
          ..write('specialty: $specialty, ')
          ..write('address: $address, ')
          ..write('mobile: $mobile, ')
          ..write('landline: $landline, ')
          ..write('education: $education, ')
          ..write('servingMonths: $servingMonths, ')
          ..write('dateArrival: $dateArrival, ')
          ..write('dateInsert: $dateInsert, ')
          ..write('dateRemoval: $dateRemoval')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    surname,
    agm,
    rank,
    specialty,
    address,
    mobile,
    landline,
    education,
    servingMonths,
    dateArrival,
    dateInsert,
    dateRemoval,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableSailor &&
          other.id == this.id &&
          other.name == this.name &&
          other.surname == this.surname &&
          other.agm == this.agm &&
          other.rank == this.rank &&
          other.specialty == this.specialty &&
          other.address == this.address &&
          other.mobile == this.mobile &&
          other.landline == this.landline &&
          other.education == this.education &&
          other.servingMonths == this.servingMonths &&
          other.dateArrival == this.dateArrival &&
          other.dateInsert == this.dateInsert &&
          other.dateRemoval == this.dateRemoval);
}

class TableSailorsCompanion extends UpdateCompanion<TableSailor> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> surname;
  final Value<String> agm;
  final Value<Rank> rank;
  final Value<Specialty> specialty;
  final Value<String> address;
  final Value<String> mobile;
  final Value<String> landline;
  final Value<String> education;
  final Value<int> servingMonths;
  final Value<DateTime> dateArrival;
  final Value<DateTime> dateInsert;
  final Value<DateTime> dateRemoval;
  final Value<int> rowid;
  const TableSailorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.surname = const Value.absent(),
    this.agm = const Value.absent(),
    this.rank = const Value.absent(),
    this.specialty = const Value.absent(),
    this.address = const Value.absent(),
    this.mobile = const Value.absent(),
    this.landline = const Value.absent(),
    this.education = const Value.absent(),
    this.servingMonths = const Value.absent(),
    this.dateArrival = const Value.absent(),
    this.dateInsert = const Value.absent(),
    this.dateRemoval = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TableSailorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String surname,
    required String agm,
    required Rank rank,
    required Specialty specialty,
    required String address,
    required String mobile,
    required String landline,
    required String education,
    required int servingMonths,
    required DateTime dateArrival,
    required DateTime dateInsert,
    required DateTime dateRemoval,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       surname = Value(surname),
       agm = Value(agm),
       rank = Value(rank),
       specialty = Value(specialty),
       address = Value(address),
       mobile = Value(mobile),
       landline = Value(landline),
       education = Value(education),
       servingMonths = Value(servingMonths),
       dateArrival = Value(dateArrival),
       dateInsert = Value(dateInsert),
       dateRemoval = Value(dateRemoval);
  static Insertable<TableSailor> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? surname,
    Expression<String>? agm,
    Expression<String>? rank,
    Expression<String>? specialty,
    Expression<String>? address,
    Expression<String>? mobile,
    Expression<String>? landline,
    Expression<String>? education,
    Expression<int>? servingMonths,
    Expression<DateTime>? dateArrival,
    Expression<DateTime>? dateInsert,
    Expression<DateTime>? dateRemoval,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (agm != null) 'agm': agm,
      if (rank != null) 'rank': rank,
      if (specialty != null) 'specialty': specialty,
      if (address != null) 'address': address,
      if (mobile != null) 'mobile': mobile,
      if (landline != null) 'landline': landline,
      if (education != null) 'education': education,
      if (servingMonths != null) 'serving_months': servingMonths,
      if (dateArrival != null) 'date_arrival': dateArrival,
      if (dateInsert != null) 'date_insert': dateInsert,
      if (dateRemoval != null) 'date_removal': dateRemoval,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TableSailorsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? surname,
    Value<String>? agm,
    Value<Rank>? rank,
    Value<Specialty>? specialty,
    Value<String>? address,
    Value<String>? mobile,
    Value<String>? landline,
    Value<String>? education,
    Value<int>? servingMonths,
    Value<DateTime>? dateArrival,
    Value<DateTime>? dateInsert,
    Value<DateTime>? dateRemoval,
    Value<int>? rowid,
  }) {
    return TableSailorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      agm: agm ?? this.agm,
      rank: rank ?? this.rank,
      specialty: specialty ?? this.specialty,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      landline: landline ?? this.landline,
      education: education ?? this.education,
      servingMonths: servingMonths ?? this.servingMonths,
      dateArrival: dateArrival ?? this.dateArrival,
      dateInsert: dateInsert ?? this.dateInsert,
      dateRemoval: dateRemoval ?? this.dateRemoval,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (agm.present) {
      map['agm'] = Variable<String>(agm.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(
        $TableSailorsTable.$converterrank.toSql(rank.value),
      );
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(
        $TableSailorsTable.$converterspecialty.toSql(specialty.value),
      );
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (landline.present) {
      map['landline'] = Variable<String>(landline.value);
    }
    if (education.present) {
      map['education'] = Variable<String>(education.value);
    }
    if (servingMonths.present) {
      map['serving_months'] = Variable<int>(servingMonths.value);
    }
    if (dateArrival.present) {
      map['date_arrival'] = Variable<DateTime>(dateArrival.value);
    }
    if (dateInsert.present) {
      map['date_insert'] = Variable<DateTime>(dateInsert.value);
    }
    if (dateRemoval.present) {
      map['date_removal'] = Variable<DateTime>(dateRemoval.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableSailorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('agm: $agm, ')
          ..write('rank: $rank, ')
          ..write('specialty: $specialty, ')
          ..write('address: $address, ')
          ..write('mobile: $mobile, ')
          ..write('landline: $landline, ')
          ..write('education: $education, ')
          ..write('servingMonths: $servingMonths, ')
          ..write('dateArrival: $dateArrival, ')
          ..write('dateInsert: $dateInsert, ')
          ..write('dateRemoval: $dateRemoval, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TableAdeiesTable extends TableAdeies
    with TableInfo<$TableAdeiesTable, TableAdey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableAdeiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _dateStartMeta = const VerificationMeta(
    'dateStart',
  );
  @override
  late final GeneratedColumn<DateTime> dateStart = GeneratedColumn<DateTime>(
    'date_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateEndMeta = const VerificationMeta(
    'dateEnd',
  );
  @override
  late final GeneratedColumn<DateTime> dateEnd = GeneratedColumn<DateTime>(
    'date_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Adeia, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Adeia>($TableAdeiesTable.$convertertype);
  static const VerificationMeta _simaMeta = const VerificationMeta('sima');
  @override
  late final GeneratedColumn<String> sima = GeneratedColumn<String>(
    'sima',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sailorIdMeta = const VerificationMeta(
    'sailorId',
  );
  @override
  late final GeneratedColumn<String> sailorId = GeneratedColumn<String>(
    'sailor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES table_sailors (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dateStart,
    dateEnd,
    type,
    sima,
    sailorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_adeies';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableAdey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_start')) {
      context.handle(
        _dateStartMeta,
        dateStart.isAcceptableOrUnknown(data['date_start']!, _dateStartMeta),
      );
    }
    if (data.containsKey('date_end')) {
      context.handle(
        _dateEndMeta,
        dateEnd.isAcceptableOrUnknown(data['date_end']!, _dateEndMeta),
      );
    }
    if (data.containsKey('sima')) {
      context.handle(
        _simaMeta,
        sima.isAcceptableOrUnknown(data['sima']!, _simaMeta),
      );
    } else if (isInserting) {
      context.missing(_simaMeta);
    }
    if (data.containsKey('sailor_id')) {
      context.handle(
        _sailorIdMeta,
        sailorId.isAcceptableOrUnknown(data['sailor_id']!, _sailorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sailorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableAdey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableAdey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dateStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_start'],
      )!,
      dateEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_end'],
      )!,
      type: $TableAdeiesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      sima: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sima'],
      )!,
      sailorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sailor_id'],
      )!,
    );
  }

  @override
  $TableAdeiesTable createAlias(String alias) {
    return $TableAdeiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Adeia, String, String> $convertertype =
      const EnumNameConverter<Adeia>(Adeia.values);
}

class TableAdey extends DataClass implements Insertable<TableAdey> {
  final String id;
  final DateTime dateStart;
  final DateTime dateEnd;
  final Adeia type;
  final String sima;
  final String sailorId;
  const TableAdey({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.type,
    required this.sima,
    required this.sailorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date_start'] = Variable<DateTime>(dateStart);
    map['date_end'] = Variable<DateTime>(dateEnd);
    {
      map['type'] = Variable<String>(
        $TableAdeiesTable.$convertertype.toSql(type),
      );
    }
    map['sima'] = Variable<String>(sima);
    map['sailor_id'] = Variable<String>(sailorId);
    return map;
  }

  TableAdeiesCompanion toCompanion(bool nullToAbsent) {
    return TableAdeiesCompanion(
      id: Value(id),
      dateStart: Value(dateStart),
      dateEnd: Value(dateEnd),
      type: Value(type),
      sima: Value(sima),
      sailorId: Value(sailorId),
    );
  }

  factory TableAdey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableAdey(
      id: serializer.fromJson<String>(json['id']),
      dateStart: serializer.fromJson<DateTime>(json['dateStart']),
      dateEnd: serializer.fromJson<DateTime>(json['dateEnd']),
      type: $TableAdeiesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      sima: serializer.fromJson<String>(json['sima']),
      sailorId: serializer.fromJson<String>(json['sailorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dateStart': serializer.toJson<DateTime>(dateStart),
      'dateEnd': serializer.toJson<DateTime>(dateEnd),
      'type': serializer.toJson<String>(
        $TableAdeiesTable.$convertertype.toJson(type),
      ),
      'sima': serializer.toJson<String>(sima),
      'sailorId': serializer.toJson<String>(sailorId),
    };
  }

  TableAdey copyWith({
    String? id,
    DateTime? dateStart,
    DateTime? dateEnd,
    Adeia? type,
    String? sima,
    String? sailorId,
  }) => TableAdey(
    id: id ?? this.id,
    dateStart: dateStart ?? this.dateStart,
    dateEnd: dateEnd ?? this.dateEnd,
    type: type ?? this.type,
    sima: sima ?? this.sima,
    sailorId: sailorId ?? this.sailorId,
  );
  TableAdey copyWithCompanion(TableAdeiesCompanion data) {
    return TableAdey(
      id: data.id.present ? data.id.value : this.id,
      dateStart: data.dateStart.present ? data.dateStart.value : this.dateStart,
      dateEnd: data.dateEnd.present ? data.dateEnd.value : this.dateEnd,
      type: data.type.present ? data.type.value : this.type,
      sima: data.sima.present ? data.sima.value : this.sima,
      sailorId: data.sailorId.present ? data.sailorId.value : this.sailorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableAdey(')
          ..write('id: $id, ')
          ..write('dateStart: $dateStart, ')
          ..write('dateEnd: $dateEnd, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('sailorId: $sailorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dateStart, dateEnd, type, sima, sailorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableAdey &&
          other.id == this.id &&
          other.dateStart == this.dateStart &&
          other.dateEnd == this.dateEnd &&
          other.type == this.type &&
          other.sima == this.sima &&
          other.sailorId == this.sailorId);
}

class TableAdeiesCompanion extends UpdateCompanion<TableAdey> {
  final Value<String> id;
  final Value<DateTime> dateStart;
  final Value<DateTime> dateEnd;
  final Value<Adeia> type;
  final Value<String> sima;
  final Value<String> sailorId;
  final Value<int> rowid;
  const TableAdeiesCompanion({
    this.id = const Value.absent(),
    this.dateStart = const Value.absent(),
    this.dateEnd = const Value.absent(),
    this.type = const Value.absent(),
    this.sima = const Value.absent(),
    this.sailorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TableAdeiesCompanion.insert({
    this.id = const Value.absent(),
    this.dateStart = const Value.absent(),
    this.dateEnd = const Value.absent(),
    required Adeia type,
    required String sima,
    required String sailorId,
    this.rowid = const Value.absent(),
  }) : type = Value(type),
       sima = Value(sima),
       sailorId = Value(sailorId);
  static Insertable<TableAdey> custom({
    Expression<String>? id,
    Expression<DateTime>? dateStart,
    Expression<DateTime>? dateEnd,
    Expression<String>? type,
    Expression<String>? sima,
    Expression<String>? sailorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateStart != null) 'date_start': dateStart,
      if (dateEnd != null) 'date_end': dateEnd,
      if (type != null) 'type': type,
      if (sima != null) 'sima': sima,
      if (sailorId != null) 'sailor_id': sailorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TableAdeiesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? dateStart,
    Value<DateTime>? dateEnd,
    Value<Adeia>? type,
    Value<String>? sima,
    Value<String>? sailorId,
    Value<int>? rowid,
  }) {
    return TableAdeiesCompanion(
      id: id ?? this.id,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      type: type ?? this.type,
      sima: sima ?? this.sima,
      sailorId: sailorId ?? this.sailorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dateStart.present) {
      map['date_start'] = Variable<DateTime>(dateStart.value);
    }
    if (dateEnd.present) {
      map['date_end'] = Variable<DateTime>(dateEnd.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TableAdeiesTable.$convertertype.toSql(type.value),
      );
    }
    if (sima.present) {
      map['sima'] = Variable<String>(sima.value);
    }
    if (sailorId.present) {
      map['sailor_id'] = Variable<String>(sailorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableAdeiesCompanion(')
          ..write('id: $id, ')
          ..write('dateStart: $dateStart, ')
          ..write('dateEnd: $dateEnd, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('sailorId: $sailorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TableMetavolesTable extends TableMetavoles
    with TableInfo<$TableMetavolesTable, TableMetavole> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableMetavolesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Metavoli, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Metavoli>($TableMetavolesTable.$convertertype);
  static const VerificationMeta _simaMeta = const VerificationMeta('sima');
  @override
  late final GeneratedColumn<String> sima = GeneratedColumn<String>(
    'sima',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sailorIdMeta = const VerificationMeta(
    'sailorId',
  );
  @override
  late final GeneratedColumn<String> sailorId = GeneratedColumn<String>(
    'sailor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES table_sailors (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    type,
    sima,
    sailorId,
    duration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_metavoles';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableMetavole> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('sima')) {
      context.handle(
        _simaMeta,
        sima.isAcceptableOrUnknown(data['sima']!, _simaMeta),
      );
    } else if (isInserting) {
      context.missing(_simaMeta);
    }
    if (data.containsKey('sailor_id')) {
      context.handle(
        _sailorIdMeta,
        sailorId.isAcceptableOrUnknown(data['sailor_id']!, _sailorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sailorIdMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableMetavole map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableMetavole(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: $TableMetavolesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      sima: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sima'],
      )!,
      sailorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sailor_id'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
    );
  }

  @override
  $TableMetavolesTable createAlias(String alias) {
    return $TableMetavolesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Metavoli, String, String> $convertertype =
      const EnumNameConverter<Metavoli>(Metavoli.values);
}

class TableMetavole extends DataClass implements Insertable<TableMetavole> {
  final String id;
  final DateTime date;
  final Metavoli type;
  final String sima;
  final String sailorId;
  final int? duration;
  const TableMetavole({
    required this.id,
    required this.date,
    required this.type,
    required this.sima,
    required this.sailorId,
    this.duration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['type'] = Variable<String>(
        $TableMetavolesTable.$convertertype.toSql(type),
      );
    }
    map['sima'] = Variable<String>(sima);
    map['sailor_id'] = Variable<String>(sailorId);
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    return map;
  }

  TableMetavolesCompanion toCompanion(bool nullToAbsent) {
    return TableMetavolesCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      sima: Value(sima),
      sailorId: Value(sailorId),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
    );
  }

  factory TableMetavole.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableMetavole(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: $TableMetavolesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      sima: serializer.fromJson<String>(json['sima']),
      sailorId: serializer.fromJson<String>(json['sailorId']),
      duration: serializer.fromJson<int?>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<String>(
        $TableMetavolesTable.$convertertype.toJson(type),
      ),
      'sima': serializer.toJson<String>(sima),
      'sailorId': serializer.toJson<String>(sailorId),
      'duration': serializer.toJson<int?>(duration),
    };
  }

  TableMetavole copyWith({
    String? id,
    DateTime? date,
    Metavoli? type,
    String? sima,
    String? sailorId,
    Value<int?> duration = const Value.absent(),
  }) => TableMetavole(
    id: id ?? this.id,
    date: date ?? this.date,
    type: type ?? this.type,
    sima: sima ?? this.sima,
    sailorId: sailorId ?? this.sailorId,
    duration: duration.present ? duration.value : this.duration,
  );
  TableMetavole copyWithCompanion(TableMetavolesCompanion data) {
    return TableMetavole(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      sima: data.sima.present ? data.sima.value : this.sima,
      sailorId: data.sailorId.present ? data.sailorId.value : this.sailorId,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableMetavole(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('sailorId: $sailorId, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, type, sima, sailorId, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableMetavole &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.sima == this.sima &&
          other.sailorId == this.sailorId &&
          other.duration == this.duration);
}

class TableMetavolesCompanion extends UpdateCompanion<TableMetavole> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<Metavoli> type;
  final Value<String> sima;
  final Value<String> sailorId;
  final Value<int?> duration;
  final Value<int> rowid;
  const TableMetavolesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.sima = const Value.absent(),
    this.sailorId = const Value.absent(),
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TableMetavolesCompanion.insert({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    required Metavoli type,
    required String sima,
    required String sailorId,
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : type = Value(type),
       sima = Value(sima),
       sailorId = Value(sailorId);
  static Insertable<TableMetavole> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<String>? sima,
    Expression<String>? sailorId,
    Expression<int>? duration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (sima != null) 'sima': sima,
      if (sailorId != null) 'sailor_id': sailorId,
      if (duration != null) 'duration': duration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TableMetavolesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<Metavoli>? type,
    Value<String>? sima,
    Value<String>? sailorId,
    Value<int?>? duration,
    Value<int>? rowid,
  }) {
    return TableMetavolesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      sima: sima ?? this.sima,
      sailorId: sailorId ?? this.sailorId,
      duration: duration ?? this.duration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TableMetavolesTable.$convertertype.toSql(type.value),
      );
    }
    if (sima.present) {
      map['sima'] = Variable<String>(sima.value);
    }
    if (sailorId.present) {
      map['sailor_id'] = Variable<String>(sailorId.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableMetavolesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('sailorId: $sailorId, ')
          ..write('duration: $duration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TableApomakrynseisTable extends TableApomakrynseis
    with TableInfo<$TableApomakrynseisTable, TableApomakrynsei> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableApomakrynseisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _dateStartMeta = const VerificationMeta(
    'dateStart',
  );
  @override
  late final GeneratedColumn<DateTime> dateStart = GeneratedColumn<DateTime>(
    'date_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateEndMeta = const VerificationMeta(
    'dateEnd',
  );
  @override
  late final GeneratedColumn<DateTime> dateEnd = GeneratedColumn<DateTime>(
    'date_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Apomakrynsi, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Apomakrynsi>($TableApomakrynseisTable.$convertertype);
  static const VerificationMeta _simaMeta = const VerificationMeta('sima');
  @override
  late final GeneratedColumn<String> sima = GeneratedColumn<String>(
    'sima',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ypiresiaMeta = const VerificationMeta(
    'ypiresia',
  );
  @override
  late final GeneratedColumn<String> ypiresia = GeneratedColumn<String>(
    'ypiresia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sailorIdMeta = const VerificationMeta(
    'sailorId',
  );
  @override
  late final GeneratedColumn<String> sailorId = GeneratedColumn<String>(
    'sailor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES table_sailors (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dateStart,
    dateEnd,
    type,
    sima,
    ypiresia,
    sailorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_apomakrynseis';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableApomakrynsei> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_start')) {
      context.handle(
        _dateStartMeta,
        dateStart.isAcceptableOrUnknown(data['date_start']!, _dateStartMeta),
      );
    }
    if (data.containsKey('date_end')) {
      context.handle(
        _dateEndMeta,
        dateEnd.isAcceptableOrUnknown(data['date_end']!, _dateEndMeta),
      );
    }
    if (data.containsKey('sima')) {
      context.handle(
        _simaMeta,
        sima.isAcceptableOrUnknown(data['sima']!, _simaMeta),
      );
    } else if (isInserting) {
      context.missing(_simaMeta);
    }
    if (data.containsKey('ypiresia')) {
      context.handle(
        _ypiresiaMeta,
        ypiresia.isAcceptableOrUnknown(data['ypiresia']!, _ypiresiaMeta),
      );
    } else if (isInserting) {
      context.missing(_ypiresiaMeta);
    }
    if (data.containsKey('sailor_id')) {
      context.handle(
        _sailorIdMeta,
        sailorId.isAcceptableOrUnknown(data['sailor_id']!, _sailorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sailorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableApomakrynsei map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableApomakrynsei(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dateStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_start'],
      )!,
      dateEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_end'],
      )!,
      type: $TableApomakrynseisTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      sima: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sima'],
      )!,
      ypiresia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ypiresia'],
      )!,
      sailorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sailor_id'],
      )!,
    );
  }

  @override
  $TableApomakrynseisTable createAlias(String alias) {
    return $TableApomakrynseisTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Apomakrynsi, String, String> $convertertype =
      const EnumNameConverter<Apomakrynsi>(Apomakrynsi.values);
}

class TableApomakrynsei extends DataClass
    implements Insertable<TableApomakrynsei> {
  final String id;
  final DateTime dateStart;
  final DateTime dateEnd;
  final Apomakrynsi type;
  final String sima;
  final String ypiresia;
  final String sailorId;
  const TableApomakrynsei({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.type,
    required this.sima,
    required this.ypiresia,
    required this.sailorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date_start'] = Variable<DateTime>(dateStart);
    map['date_end'] = Variable<DateTime>(dateEnd);
    {
      map['type'] = Variable<String>(
        $TableApomakrynseisTable.$convertertype.toSql(type),
      );
    }
    map['sima'] = Variable<String>(sima);
    map['ypiresia'] = Variable<String>(ypiresia);
    map['sailor_id'] = Variable<String>(sailorId);
    return map;
  }

  TableApomakrynseisCompanion toCompanion(bool nullToAbsent) {
    return TableApomakrynseisCompanion(
      id: Value(id),
      dateStart: Value(dateStart),
      dateEnd: Value(dateEnd),
      type: Value(type),
      sima: Value(sima),
      ypiresia: Value(ypiresia),
      sailorId: Value(sailorId),
    );
  }

  factory TableApomakrynsei.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableApomakrynsei(
      id: serializer.fromJson<String>(json['id']),
      dateStart: serializer.fromJson<DateTime>(json['dateStart']),
      dateEnd: serializer.fromJson<DateTime>(json['dateEnd']),
      type: $TableApomakrynseisTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      sima: serializer.fromJson<String>(json['sima']),
      ypiresia: serializer.fromJson<String>(json['ypiresia']),
      sailorId: serializer.fromJson<String>(json['sailorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dateStart': serializer.toJson<DateTime>(dateStart),
      'dateEnd': serializer.toJson<DateTime>(dateEnd),
      'type': serializer.toJson<String>(
        $TableApomakrynseisTable.$convertertype.toJson(type),
      ),
      'sima': serializer.toJson<String>(sima),
      'ypiresia': serializer.toJson<String>(ypiresia),
      'sailorId': serializer.toJson<String>(sailorId),
    };
  }

  TableApomakrynsei copyWith({
    String? id,
    DateTime? dateStart,
    DateTime? dateEnd,
    Apomakrynsi? type,
    String? sima,
    String? ypiresia,
    String? sailorId,
  }) => TableApomakrynsei(
    id: id ?? this.id,
    dateStart: dateStart ?? this.dateStart,
    dateEnd: dateEnd ?? this.dateEnd,
    type: type ?? this.type,
    sima: sima ?? this.sima,
    ypiresia: ypiresia ?? this.ypiresia,
    sailorId: sailorId ?? this.sailorId,
  );
  TableApomakrynsei copyWithCompanion(TableApomakrynseisCompanion data) {
    return TableApomakrynsei(
      id: data.id.present ? data.id.value : this.id,
      dateStart: data.dateStart.present ? data.dateStart.value : this.dateStart,
      dateEnd: data.dateEnd.present ? data.dateEnd.value : this.dateEnd,
      type: data.type.present ? data.type.value : this.type,
      sima: data.sima.present ? data.sima.value : this.sima,
      ypiresia: data.ypiresia.present ? data.ypiresia.value : this.ypiresia,
      sailorId: data.sailorId.present ? data.sailorId.value : this.sailorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableApomakrynsei(')
          ..write('id: $id, ')
          ..write('dateStart: $dateStart, ')
          ..write('dateEnd: $dateEnd, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('ypiresia: $ypiresia, ')
          ..write('sailorId: $sailorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dateStart, dateEnd, type, sima, ypiresia, sailorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableApomakrynsei &&
          other.id == this.id &&
          other.dateStart == this.dateStart &&
          other.dateEnd == this.dateEnd &&
          other.type == this.type &&
          other.sima == this.sima &&
          other.ypiresia == this.ypiresia &&
          other.sailorId == this.sailorId);
}

class TableApomakrynseisCompanion extends UpdateCompanion<TableApomakrynsei> {
  final Value<String> id;
  final Value<DateTime> dateStart;
  final Value<DateTime> dateEnd;
  final Value<Apomakrynsi> type;
  final Value<String> sima;
  final Value<String> ypiresia;
  final Value<String> sailorId;
  final Value<int> rowid;
  const TableApomakrynseisCompanion({
    this.id = const Value.absent(),
    this.dateStart = const Value.absent(),
    this.dateEnd = const Value.absent(),
    this.type = const Value.absent(),
    this.sima = const Value.absent(),
    this.ypiresia = const Value.absent(),
    this.sailorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TableApomakrynseisCompanion.insert({
    this.id = const Value.absent(),
    this.dateStart = const Value.absent(),
    this.dateEnd = const Value.absent(),
    required Apomakrynsi type,
    required String sima,
    required String ypiresia,
    required String sailorId,
    this.rowid = const Value.absent(),
  }) : type = Value(type),
       sima = Value(sima),
       ypiresia = Value(ypiresia),
       sailorId = Value(sailorId);
  static Insertable<TableApomakrynsei> custom({
    Expression<String>? id,
    Expression<DateTime>? dateStart,
    Expression<DateTime>? dateEnd,
    Expression<String>? type,
    Expression<String>? sima,
    Expression<String>? ypiresia,
    Expression<String>? sailorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateStart != null) 'date_start': dateStart,
      if (dateEnd != null) 'date_end': dateEnd,
      if (type != null) 'type': type,
      if (sima != null) 'sima': sima,
      if (ypiresia != null) 'ypiresia': ypiresia,
      if (sailorId != null) 'sailor_id': sailorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TableApomakrynseisCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? dateStart,
    Value<DateTime>? dateEnd,
    Value<Apomakrynsi>? type,
    Value<String>? sima,
    Value<String>? ypiresia,
    Value<String>? sailorId,
    Value<int>? rowid,
  }) {
    return TableApomakrynseisCompanion(
      id: id ?? this.id,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      type: type ?? this.type,
      sima: sima ?? this.sima,
      ypiresia: ypiresia ?? this.ypiresia,
      sailorId: sailorId ?? this.sailorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dateStart.present) {
      map['date_start'] = Variable<DateTime>(dateStart.value);
    }
    if (dateEnd.present) {
      map['date_end'] = Variable<DateTime>(dateEnd.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TableApomakrynseisTable.$convertertype.toSql(type.value),
      );
    }
    if (sima.present) {
      map['sima'] = Variable<String>(sima.value);
    }
    if (ypiresia.present) {
      map['ypiresia'] = Variable<String>(ypiresia.value);
    }
    if (sailorId.present) {
      map['sailor_id'] = Variable<String>(sailorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableApomakrynseisCompanion(')
          ..write('id: $id, ')
          ..write('dateStart: $dateStart, ')
          ..write('dateEnd: $dateEnd, ')
          ..write('type: $type, ')
          ..write('sima: $sima, ')
          ..write('ypiresia: $ypiresia, ')
          ..write('sailorId: $sailorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VarsTable extends Vars with TableInfo<$VarsTable, Var> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prothemaShmatosMeta = const VerificationMeta(
    'prothemaShmatos',
  );
  @override
  late final GeneratedColumn<String> prothemaShmatos = GeneratedColumn<String>(
    'prothema_shmatos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [prothemaShmatos];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vars';
  @override
  VerificationContext validateIntegrity(
    Insertable<Var> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prothema_shmatos')) {
      context.handle(
        _prothemaShmatosMeta,
        prothemaShmatos.isAcceptableOrUnknown(
          data['prothema_shmatos']!,
          _prothemaShmatosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prothemaShmatosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prothemaShmatos};
  @override
  Var map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Var(
      prothemaShmatos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prothema_shmatos'],
      )!,
    );
  }

  @override
  $VarsTable createAlias(String alias) {
    return $VarsTable(attachedDatabase, alias);
  }
}

class Var extends DataClass implements Insertable<Var> {
  final String prothemaShmatos;
  const Var({required this.prothemaShmatos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prothema_shmatos'] = Variable<String>(prothemaShmatos);
    return map;
  }

  VarsCompanion toCompanion(bool nullToAbsent) {
    return VarsCompanion(prothemaShmatos: Value(prothemaShmatos));
  }

  factory Var.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Var(
      prothemaShmatos: serializer.fromJson<String>(json['prothemaShmatos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prothemaShmatos': serializer.toJson<String>(prothemaShmatos),
    };
  }

  Var copyWith({String? prothemaShmatos}) =>
      Var(prothemaShmatos: prothemaShmatos ?? this.prothemaShmatos);
  Var copyWithCompanion(VarsCompanion data) {
    return Var(
      prothemaShmatos: data.prothemaShmatos.present
          ? data.prothemaShmatos.value
          : this.prothemaShmatos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Var(')
          ..write('prothemaShmatos: $prothemaShmatos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => prothemaShmatos.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Var && other.prothemaShmatos == this.prothemaShmatos);
}

class VarsCompanion extends UpdateCompanion<Var> {
  final Value<String> prothemaShmatos;
  final Value<int> rowid;
  const VarsCompanion({
    this.prothemaShmatos = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VarsCompanion.insert({
    required String prothemaShmatos,
    this.rowid = const Value.absent(),
  }) : prothemaShmatos = Value(prothemaShmatos);
  static Insertable<Var> custom({
    Expression<String>? prothemaShmatos,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (prothemaShmatos != null) 'prothema_shmatos': prothemaShmatos,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VarsCompanion copyWith({Value<String>? prothemaShmatos, Value<int>? rowid}) {
    return VarsCompanion(
      prothemaShmatos: prothemaShmatos ?? this.prothemaShmatos,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prothemaShmatos.present) {
      map['prothema_shmatos'] = Variable<String>(prothemaShmatos.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VarsCompanion(')
          ..write('prothemaShmatos: $prothemaShmatos, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TableSailorsTable tableSailors = $TableSailorsTable(this);
  late final $TableAdeiesTable tableAdeies = $TableAdeiesTable(this);
  late final $TableMetavolesTable tableMetavoles = $TableMetavolesTable(this);
  late final $TableApomakrynseisTable tableApomakrynseis =
      $TableApomakrynseisTable(this);
  late final $VarsTable vars = $VarsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tableSailors,
    tableAdeies,
    tableMetavoles,
    tableApomakrynseis,
    vars,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'table_sailors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('table_adeies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'table_sailors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('table_metavoles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'table_sailors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('table_apomakrynseis', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TableSailorsTableCreateCompanionBuilder =
    TableSailorsCompanion Function({
      Value<String> id,
      required String name,
      required String surname,
      required String agm,
      required Rank rank,
      required Specialty specialty,
      required String address,
      required String mobile,
      required String landline,
      required String education,
      required int servingMonths,
      required DateTime dateArrival,
      required DateTime dateInsert,
      required DateTime dateRemoval,
      Value<int> rowid,
    });
typedef $$TableSailorsTableUpdateCompanionBuilder =
    TableSailorsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> surname,
      Value<String> agm,
      Value<Rank> rank,
      Value<Specialty> specialty,
      Value<String> address,
      Value<String> mobile,
      Value<String> landline,
      Value<String> education,
      Value<int> servingMonths,
      Value<DateTime> dateArrival,
      Value<DateTime> dateInsert,
      Value<DateTime> dateRemoval,
      Value<int> rowid,
    });

final class $$TableSailorsTableReferences
    extends BaseReferences<_$AppDatabase, $TableSailorsTable, TableSailor> {
  $$TableSailorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TableAdeiesTable, List<TableAdey>>
  _tableAdeiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tableAdeies,
    aliasName: $_aliasNameGenerator(
      db.tableSailors.id,
      db.tableAdeies.sailorId,
    ),
  );

  $$TableAdeiesTableProcessedTableManager get tableAdeiesRefs {
    final manager = $$TableAdeiesTableTableManager(
      $_db,
      $_db.tableAdeies,
    ).filter((f) => f.sailorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tableAdeiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TableMetavolesTable, List<TableMetavole>>
  _tableMetavolesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tableMetavoles,
    aliasName: $_aliasNameGenerator(
      db.tableSailors.id,
      db.tableMetavoles.sailorId,
    ),
  );

  $$TableMetavolesTableProcessedTableManager get tableMetavolesRefs {
    final manager = $$TableMetavolesTableTableManager(
      $_db,
      $_db.tableMetavoles,
    ).filter((f) => f.sailorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tableMetavolesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TableApomakrynseisTable, List<TableApomakrynsei>>
  _tableApomakrynseisRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.tableApomakrynseis,
        aliasName: $_aliasNameGenerator(
          db.tableSailors.id,
          db.tableApomakrynseis.sailorId,
        ),
      );

  $$TableApomakrynseisTableProcessedTableManager get tableApomakrynseisRefs {
    final manager = $$TableApomakrynseisTableTableManager(
      $_db,
      $_db.tableApomakrynseis,
    ).filter((f) => f.sailorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _tableApomakrynseisRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TableSailorsTableFilterComposer
    extends Composer<_$AppDatabase, $TableSailorsTable> {
  $$TableSailorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agm => $composableBuilder(
    column: $table.agm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Rank, Rank, String> get rank =>
      $composableBuilder(
        column: $table.rank,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Specialty, Specialty, String> get specialty =>
      $composableBuilder(
        column: $table.specialty,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get landline => $composableBuilder(
    column: $table.landline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get education => $composableBuilder(
    column: $table.education,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servingMonths => $composableBuilder(
    column: $table.servingMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateArrival => $composableBuilder(
    column: $table.dateArrival,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateInsert => $composableBuilder(
    column: $table.dateInsert,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateRemoval => $composableBuilder(
    column: $table.dateRemoval,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tableAdeiesRefs(
    Expression<bool> Function($$TableAdeiesTableFilterComposer f) f,
  ) {
    final $$TableAdeiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tableAdeies,
      getReferencedColumn: (t) => t.sailorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableAdeiesTableFilterComposer(
            $db: $db,
            $table: $db.tableAdeies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tableMetavolesRefs(
    Expression<bool> Function($$TableMetavolesTableFilterComposer f) f,
  ) {
    final $$TableMetavolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tableMetavoles,
      getReferencedColumn: (t) => t.sailorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableMetavolesTableFilterComposer(
            $db: $db,
            $table: $db.tableMetavoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tableApomakrynseisRefs(
    Expression<bool> Function($$TableApomakrynseisTableFilterComposer f) f,
  ) {
    final $$TableApomakrynseisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tableApomakrynseis,
      getReferencedColumn: (t) => t.sailorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableApomakrynseisTableFilterComposer(
            $db: $db,
            $table: $db.tableApomakrynseis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TableSailorsTableOrderingComposer
    extends Composer<_$AppDatabase, $TableSailorsTable> {
  $$TableSailorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agm => $composableBuilder(
    column: $table.agm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get landline => $composableBuilder(
    column: $table.landline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get education => $composableBuilder(
    column: $table.education,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servingMonths => $composableBuilder(
    column: $table.servingMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateArrival => $composableBuilder(
    column: $table.dateArrival,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateInsert => $composableBuilder(
    column: $table.dateInsert,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateRemoval => $composableBuilder(
    column: $table.dateRemoval,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TableSailorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TableSailorsTable> {
  $$TableSailorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get surname =>
      $composableBuilder(column: $table.surname, builder: (column) => column);

  GeneratedColumn<String> get agm =>
      $composableBuilder(column: $table.agm, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Rank, String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Specialty, String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get landline =>
      $composableBuilder(column: $table.landline, builder: (column) => column);

  GeneratedColumn<String> get education =>
      $composableBuilder(column: $table.education, builder: (column) => column);

  GeneratedColumn<int> get servingMonths => $composableBuilder(
    column: $table.servingMonths,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateArrival => $composableBuilder(
    column: $table.dateArrival,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateInsert => $composableBuilder(
    column: $table.dateInsert,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateRemoval => $composableBuilder(
    column: $table.dateRemoval,
    builder: (column) => column,
  );

  Expression<T> tableAdeiesRefs<T extends Object>(
    Expression<T> Function($$TableAdeiesTableAnnotationComposer a) f,
  ) {
    final $$TableAdeiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tableAdeies,
      getReferencedColumn: (t) => t.sailorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableAdeiesTableAnnotationComposer(
            $db: $db,
            $table: $db.tableAdeies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tableMetavolesRefs<T extends Object>(
    Expression<T> Function($$TableMetavolesTableAnnotationComposer a) f,
  ) {
    final $$TableMetavolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tableMetavoles,
      getReferencedColumn: (t) => t.sailorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableMetavolesTableAnnotationComposer(
            $db: $db,
            $table: $db.tableMetavoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tableApomakrynseisRefs<T extends Object>(
    Expression<T> Function($$TableApomakrynseisTableAnnotationComposer a) f,
  ) {
    final $$TableApomakrynseisTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tableApomakrynseis,
          getReferencedColumn: (t) => t.sailorId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TableApomakrynseisTableAnnotationComposer(
                $db: $db,
                $table: $db.tableApomakrynseis,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TableSailorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TableSailorsTable,
          TableSailor,
          $$TableSailorsTableFilterComposer,
          $$TableSailorsTableOrderingComposer,
          $$TableSailorsTableAnnotationComposer,
          $$TableSailorsTableCreateCompanionBuilder,
          $$TableSailorsTableUpdateCompanionBuilder,
          (TableSailor, $$TableSailorsTableReferences),
          TableSailor,
          PrefetchHooks Function({
            bool tableAdeiesRefs,
            bool tableMetavolesRefs,
            bool tableApomakrynseisRefs,
          })
        > {
  $$TableSailorsTableTableManager(_$AppDatabase db, $TableSailorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TableSailorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TableSailorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TableSailorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> surname = const Value.absent(),
                Value<String> agm = const Value.absent(),
                Value<Rank> rank = const Value.absent(),
                Value<Specialty> specialty = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> mobile = const Value.absent(),
                Value<String> landline = const Value.absent(),
                Value<String> education = const Value.absent(),
                Value<int> servingMonths = const Value.absent(),
                Value<DateTime> dateArrival = const Value.absent(),
                Value<DateTime> dateInsert = const Value.absent(),
                Value<DateTime> dateRemoval = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TableSailorsCompanion(
                id: id,
                name: name,
                surname: surname,
                agm: agm,
                rank: rank,
                specialty: specialty,
                address: address,
                mobile: mobile,
                landline: landline,
                education: education,
                servingMonths: servingMonths,
                dateArrival: dateArrival,
                dateInsert: dateInsert,
                dateRemoval: dateRemoval,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String surname,
                required String agm,
                required Rank rank,
                required Specialty specialty,
                required String address,
                required String mobile,
                required String landline,
                required String education,
                required int servingMonths,
                required DateTime dateArrival,
                required DateTime dateInsert,
                required DateTime dateRemoval,
                Value<int> rowid = const Value.absent(),
              }) => TableSailorsCompanion.insert(
                id: id,
                name: name,
                surname: surname,
                agm: agm,
                rank: rank,
                specialty: specialty,
                address: address,
                mobile: mobile,
                landline: landline,
                education: education,
                servingMonths: servingMonths,
                dateArrival: dateArrival,
                dateInsert: dateInsert,
                dateRemoval: dateRemoval,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TableSailorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tableAdeiesRefs = false,
                tableMetavolesRefs = false,
                tableApomakrynseisRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tableAdeiesRefs) db.tableAdeies,
                    if (tableMetavolesRefs) db.tableMetavoles,
                    if (tableApomakrynseisRefs) db.tableApomakrynseis,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tableAdeiesRefs)
                        await $_getPrefetchedData<
                          TableSailor,
                          $TableSailorsTable,
                          TableAdey
                        >(
                          currentTable: table,
                          referencedTable: $$TableSailorsTableReferences
                              ._tableAdeiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TableSailorsTableReferences(
                                db,
                                table,
                                p0,
                              ).tableAdeiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sailorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tableMetavolesRefs)
                        await $_getPrefetchedData<
                          TableSailor,
                          $TableSailorsTable,
                          TableMetavole
                        >(
                          currentTable: table,
                          referencedTable: $$TableSailorsTableReferences
                              ._tableMetavolesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TableSailorsTableReferences(
                                db,
                                table,
                                p0,
                              ).tableMetavolesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sailorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tableApomakrynseisRefs)
                        await $_getPrefetchedData<
                          TableSailor,
                          $TableSailorsTable,
                          TableApomakrynsei
                        >(
                          currentTable: table,
                          referencedTable: $$TableSailorsTableReferences
                              ._tableApomakrynseisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TableSailorsTableReferences(
                                db,
                                table,
                                p0,
                              ).tableApomakrynseisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sailorId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TableSailorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TableSailorsTable,
      TableSailor,
      $$TableSailorsTableFilterComposer,
      $$TableSailorsTableOrderingComposer,
      $$TableSailorsTableAnnotationComposer,
      $$TableSailorsTableCreateCompanionBuilder,
      $$TableSailorsTableUpdateCompanionBuilder,
      (TableSailor, $$TableSailorsTableReferences),
      TableSailor,
      PrefetchHooks Function({
        bool tableAdeiesRefs,
        bool tableMetavolesRefs,
        bool tableApomakrynseisRefs,
      })
    >;
typedef $$TableAdeiesTableCreateCompanionBuilder =
    TableAdeiesCompanion Function({
      Value<String> id,
      Value<DateTime> dateStart,
      Value<DateTime> dateEnd,
      required Adeia type,
      required String sima,
      required String sailorId,
      Value<int> rowid,
    });
typedef $$TableAdeiesTableUpdateCompanionBuilder =
    TableAdeiesCompanion Function({
      Value<String> id,
      Value<DateTime> dateStart,
      Value<DateTime> dateEnd,
      Value<Adeia> type,
      Value<String> sima,
      Value<String> sailorId,
      Value<int> rowid,
    });

final class $$TableAdeiesTableReferences
    extends BaseReferences<_$AppDatabase, $TableAdeiesTable, TableAdey> {
  $$TableAdeiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TableSailorsTable _sailorIdTable(_$AppDatabase db) =>
      db.tableSailors.createAlias(
        $_aliasNameGenerator(db.tableAdeies.sailorId, db.tableSailors.id),
      );

  $$TableSailorsTableProcessedTableManager get sailorId {
    final $_column = $_itemColumn<String>('sailor_id')!;

    final manager = $$TableSailorsTableTableManager(
      $_db,
      $_db.tableSailors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sailorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TableAdeiesTableFilterComposer
    extends Composer<_$AppDatabase, $TableAdeiesTable> {
  $$TableAdeiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateStart => $composableBuilder(
    column: $table.dateStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEnd => $composableBuilder(
    column: $table.dateEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Adeia, Adeia, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnFilters(column),
  );

  $$TableSailorsTableFilterComposer get sailorId {
    final $$TableSailorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableFilterComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableAdeiesTableOrderingComposer
    extends Composer<_$AppDatabase, $TableAdeiesTable> {
  $$TableAdeiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateStart => $composableBuilder(
    column: $table.dateStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEnd => $composableBuilder(
    column: $table.dateEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnOrderings(column),
  );

  $$TableSailorsTableOrderingComposer get sailorId {
    final $$TableSailorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableOrderingComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableAdeiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TableAdeiesTable> {
  $$TableAdeiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateStart =>
      $composableBuilder(column: $table.dateStart, builder: (column) => column);

  GeneratedColumn<DateTime> get dateEnd =>
      $composableBuilder(column: $table.dateEnd, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Adeia, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get sima =>
      $composableBuilder(column: $table.sima, builder: (column) => column);

  $$TableSailorsTableAnnotationComposer get sailorId {
    final $$TableSailorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableAnnotationComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableAdeiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TableAdeiesTable,
          TableAdey,
          $$TableAdeiesTableFilterComposer,
          $$TableAdeiesTableOrderingComposer,
          $$TableAdeiesTableAnnotationComposer,
          $$TableAdeiesTableCreateCompanionBuilder,
          $$TableAdeiesTableUpdateCompanionBuilder,
          (TableAdey, $$TableAdeiesTableReferences),
          TableAdey,
          PrefetchHooks Function({bool sailorId})
        > {
  $$TableAdeiesTableTableManager(_$AppDatabase db, $TableAdeiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TableAdeiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TableAdeiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TableAdeiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> dateStart = const Value.absent(),
                Value<DateTime> dateEnd = const Value.absent(),
                Value<Adeia> type = const Value.absent(),
                Value<String> sima = const Value.absent(),
                Value<String> sailorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TableAdeiesCompanion(
                id: id,
                dateStart: dateStart,
                dateEnd: dateEnd,
                type: type,
                sima: sima,
                sailorId: sailorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> dateStart = const Value.absent(),
                Value<DateTime> dateEnd = const Value.absent(),
                required Adeia type,
                required String sima,
                required String sailorId,
                Value<int> rowid = const Value.absent(),
              }) => TableAdeiesCompanion.insert(
                id: id,
                dateStart: dateStart,
                dateEnd: dateEnd,
                type: type,
                sima: sima,
                sailorId: sailorId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TableAdeiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sailorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sailorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sailorId,
                                referencedTable: $$TableAdeiesTableReferences
                                    ._sailorIdTable(db),
                                referencedColumn: $$TableAdeiesTableReferences
                                    ._sailorIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TableAdeiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TableAdeiesTable,
      TableAdey,
      $$TableAdeiesTableFilterComposer,
      $$TableAdeiesTableOrderingComposer,
      $$TableAdeiesTableAnnotationComposer,
      $$TableAdeiesTableCreateCompanionBuilder,
      $$TableAdeiesTableUpdateCompanionBuilder,
      (TableAdey, $$TableAdeiesTableReferences),
      TableAdey,
      PrefetchHooks Function({bool sailorId})
    >;
typedef $$TableMetavolesTableCreateCompanionBuilder =
    TableMetavolesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      required Metavoli type,
      required String sima,
      required String sailorId,
      Value<int?> duration,
      Value<int> rowid,
    });
typedef $$TableMetavolesTableUpdateCompanionBuilder =
    TableMetavolesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<Metavoli> type,
      Value<String> sima,
      Value<String> sailorId,
      Value<int?> duration,
      Value<int> rowid,
    });

final class $$TableMetavolesTableReferences
    extends BaseReferences<_$AppDatabase, $TableMetavolesTable, TableMetavole> {
  $$TableMetavolesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TableSailorsTable _sailorIdTable(_$AppDatabase db) =>
      db.tableSailors.createAlias(
        $_aliasNameGenerator(db.tableMetavoles.sailorId, db.tableSailors.id),
      );

  $$TableSailorsTableProcessedTableManager get sailorId {
    final $_column = $_itemColumn<String>('sailor_id')!;

    final manager = $$TableSailorsTableTableManager(
      $_db,
      $_db.tableSailors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sailorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TableMetavolesTableFilterComposer
    extends Composer<_$AppDatabase, $TableMetavolesTable> {
  $$TableMetavolesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Metavoli, Metavoli, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  $$TableSailorsTableFilterComposer get sailorId {
    final $$TableSailorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableFilterComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableMetavolesTableOrderingComposer
    extends Composer<_$AppDatabase, $TableMetavolesTable> {
  $$TableMetavolesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  $$TableSailorsTableOrderingComposer get sailorId {
    final $$TableSailorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableOrderingComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableMetavolesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TableMetavolesTable> {
  $$TableMetavolesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Metavoli, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get sima =>
      $composableBuilder(column: $table.sima, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  $$TableSailorsTableAnnotationComposer get sailorId {
    final $$TableSailorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableAnnotationComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableMetavolesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TableMetavolesTable,
          TableMetavole,
          $$TableMetavolesTableFilterComposer,
          $$TableMetavolesTableOrderingComposer,
          $$TableMetavolesTableAnnotationComposer,
          $$TableMetavolesTableCreateCompanionBuilder,
          $$TableMetavolesTableUpdateCompanionBuilder,
          (TableMetavole, $$TableMetavolesTableReferences),
          TableMetavole,
          PrefetchHooks Function({bool sailorId})
        > {
  $$TableMetavolesTableTableManager(
    _$AppDatabase db,
    $TableMetavolesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TableMetavolesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TableMetavolesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TableMetavolesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<Metavoli> type = const Value.absent(),
                Value<String> sima = const Value.absent(),
                Value<String> sailorId = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TableMetavolesCompanion(
                id: id,
                date: date,
                type: type,
                sima: sima,
                sailorId: sailorId,
                duration: duration,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                required Metavoli type,
                required String sima,
                required String sailorId,
                Value<int?> duration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TableMetavolesCompanion.insert(
                id: id,
                date: date,
                type: type,
                sima: sima,
                sailorId: sailorId,
                duration: duration,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TableMetavolesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sailorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sailorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sailorId,
                                referencedTable: $$TableMetavolesTableReferences
                                    ._sailorIdTable(db),
                                referencedColumn:
                                    $$TableMetavolesTableReferences
                                        ._sailorIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TableMetavolesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TableMetavolesTable,
      TableMetavole,
      $$TableMetavolesTableFilterComposer,
      $$TableMetavolesTableOrderingComposer,
      $$TableMetavolesTableAnnotationComposer,
      $$TableMetavolesTableCreateCompanionBuilder,
      $$TableMetavolesTableUpdateCompanionBuilder,
      (TableMetavole, $$TableMetavolesTableReferences),
      TableMetavole,
      PrefetchHooks Function({bool sailorId})
    >;
typedef $$TableApomakrynseisTableCreateCompanionBuilder =
    TableApomakrynseisCompanion Function({
      Value<String> id,
      Value<DateTime> dateStart,
      Value<DateTime> dateEnd,
      required Apomakrynsi type,
      required String sima,
      required String ypiresia,
      required String sailorId,
      Value<int> rowid,
    });
typedef $$TableApomakrynseisTableUpdateCompanionBuilder =
    TableApomakrynseisCompanion Function({
      Value<String> id,
      Value<DateTime> dateStart,
      Value<DateTime> dateEnd,
      Value<Apomakrynsi> type,
      Value<String> sima,
      Value<String> ypiresia,
      Value<String> sailorId,
      Value<int> rowid,
    });

final class $$TableApomakrynseisTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TableApomakrynseisTable,
          TableApomakrynsei
        > {
  $$TableApomakrynseisTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TableSailorsTable _sailorIdTable(_$AppDatabase db) =>
      db.tableSailors.createAlias(
        $_aliasNameGenerator(
          db.tableApomakrynseis.sailorId,
          db.tableSailors.id,
        ),
      );

  $$TableSailorsTableProcessedTableManager get sailorId {
    final $_column = $_itemColumn<String>('sailor_id')!;

    final manager = $$TableSailorsTableTableManager(
      $_db,
      $_db.tableSailors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sailorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TableApomakrynseisTableFilterComposer
    extends Composer<_$AppDatabase, $TableApomakrynseisTable> {
  $$TableApomakrynseisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateStart => $composableBuilder(
    column: $table.dateStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEnd => $composableBuilder(
    column: $table.dateEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Apomakrynsi, Apomakrynsi, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ypiresia => $composableBuilder(
    column: $table.ypiresia,
    builder: (column) => ColumnFilters(column),
  );

  $$TableSailorsTableFilterComposer get sailorId {
    final $$TableSailorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableFilterComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableApomakrynseisTableOrderingComposer
    extends Composer<_$AppDatabase, $TableApomakrynseisTable> {
  $$TableApomakrynseisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateStart => $composableBuilder(
    column: $table.dateStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEnd => $composableBuilder(
    column: $table.dateEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sima => $composableBuilder(
    column: $table.sima,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ypiresia => $composableBuilder(
    column: $table.ypiresia,
    builder: (column) => ColumnOrderings(column),
  );

  $$TableSailorsTableOrderingComposer get sailorId {
    final $$TableSailorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableOrderingComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableApomakrynseisTableAnnotationComposer
    extends Composer<_$AppDatabase, $TableApomakrynseisTable> {
  $$TableApomakrynseisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateStart =>
      $composableBuilder(column: $table.dateStart, builder: (column) => column);

  GeneratedColumn<DateTime> get dateEnd =>
      $composableBuilder(column: $table.dateEnd, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Apomakrynsi, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get sima =>
      $composableBuilder(column: $table.sima, builder: (column) => column);

  GeneratedColumn<String> get ypiresia =>
      $composableBuilder(column: $table.ypiresia, builder: (column) => column);

  $$TableSailorsTableAnnotationComposer get sailorId {
    final $$TableSailorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sailorId,
      referencedTable: $db.tableSailors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TableSailorsTableAnnotationComposer(
            $db: $db,
            $table: $db.tableSailors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TableApomakrynseisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TableApomakrynseisTable,
          TableApomakrynsei,
          $$TableApomakrynseisTableFilterComposer,
          $$TableApomakrynseisTableOrderingComposer,
          $$TableApomakrynseisTableAnnotationComposer,
          $$TableApomakrynseisTableCreateCompanionBuilder,
          $$TableApomakrynseisTableUpdateCompanionBuilder,
          (TableApomakrynsei, $$TableApomakrynseisTableReferences),
          TableApomakrynsei,
          PrefetchHooks Function({bool sailorId})
        > {
  $$TableApomakrynseisTableTableManager(
    _$AppDatabase db,
    $TableApomakrynseisTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TableApomakrynseisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TableApomakrynseisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TableApomakrynseisTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> dateStart = const Value.absent(),
                Value<DateTime> dateEnd = const Value.absent(),
                Value<Apomakrynsi> type = const Value.absent(),
                Value<String> sima = const Value.absent(),
                Value<String> ypiresia = const Value.absent(),
                Value<String> sailorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TableApomakrynseisCompanion(
                id: id,
                dateStart: dateStart,
                dateEnd: dateEnd,
                type: type,
                sima: sima,
                ypiresia: ypiresia,
                sailorId: sailorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> dateStart = const Value.absent(),
                Value<DateTime> dateEnd = const Value.absent(),
                required Apomakrynsi type,
                required String sima,
                required String ypiresia,
                required String sailorId,
                Value<int> rowid = const Value.absent(),
              }) => TableApomakrynseisCompanion.insert(
                id: id,
                dateStart: dateStart,
                dateEnd: dateEnd,
                type: type,
                sima: sima,
                ypiresia: ypiresia,
                sailorId: sailorId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TableApomakrynseisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sailorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sailorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sailorId,
                                referencedTable:
                                    $$TableApomakrynseisTableReferences
                                        ._sailorIdTable(db),
                                referencedColumn:
                                    $$TableApomakrynseisTableReferences
                                        ._sailorIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TableApomakrynseisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TableApomakrynseisTable,
      TableApomakrynsei,
      $$TableApomakrynseisTableFilterComposer,
      $$TableApomakrynseisTableOrderingComposer,
      $$TableApomakrynseisTableAnnotationComposer,
      $$TableApomakrynseisTableCreateCompanionBuilder,
      $$TableApomakrynseisTableUpdateCompanionBuilder,
      (TableApomakrynsei, $$TableApomakrynseisTableReferences),
      TableApomakrynsei,
      PrefetchHooks Function({bool sailorId})
    >;
typedef $$VarsTableCreateCompanionBuilder =
    VarsCompanion Function({required String prothemaShmatos, Value<int> rowid});
typedef $$VarsTableUpdateCompanionBuilder =
    VarsCompanion Function({Value<String> prothemaShmatos, Value<int> rowid});

class $$VarsTableFilterComposer extends Composer<_$AppDatabase, $VarsTable> {
  $$VarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get prothemaShmatos => $composableBuilder(
    column: $table.prothemaShmatos,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VarsTableOrderingComposer extends Composer<_$AppDatabase, $VarsTable> {
  $$VarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get prothemaShmatos => $composableBuilder(
    column: $table.prothemaShmatos,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VarsTable> {
  $$VarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get prothemaShmatos => $composableBuilder(
    column: $table.prothemaShmatos,
    builder: (column) => column,
  );
}

class $$VarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VarsTable,
          Var,
          $$VarsTableFilterComposer,
          $$VarsTableOrderingComposer,
          $$VarsTableAnnotationComposer,
          $$VarsTableCreateCompanionBuilder,
          $$VarsTableUpdateCompanionBuilder,
          (Var, BaseReferences<_$AppDatabase, $VarsTable, Var>),
          Var,
          PrefetchHooks Function()
        > {
  $$VarsTableTableManager(_$AppDatabase db, $VarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> prothemaShmatos = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  VarsCompanion(prothemaShmatos: prothemaShmatos, rowid: rowid),
          createCompanionCallback:
              ({
                required String prothemaShmatos,
                Value<int> rowid = const Value.absent(),
              }) => VarsCompanion.insert(
                prothemaShmatos: prothemaShmatos,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VarsTable,
      Var,
      $$VarsTableFilterComposer,
      $$VarsTableOrderingComposer,
      $$VarsTableAnnotationComposer,
      $$VarsTableCreateCompanionBuilder,
      $$VarsTableUpdateCompanionBuilder,
      (Var, BaseReferences<_$AppDatabase, $VarsTable, Var>),
      Var,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TableSailorsTableTableManager get tableSailors =>
      $$TableSailorsTableTableManager(_db, _db.tableSailors);
  $$TableAdeiesTableTableManager get tableAdeies =>
      $$TableAdeiesTableTableManager(_db, _db.tableAdeies);
  $$TableMetavolesTableTableManager get tableMetavoles =>
      $$TableMetavolesTableTableManager(_db, _db.tableMetavoles);
  $$TableApomakrynseisTableTableManager get tableApomakrynseis =>
      $$TableApomakrynseisTableTableManager(_db, _db.tableApomakrynseis);
  $$VarsTableTableManager get vars => $$VarsTableTableManager(_db, _db.vars);
}
