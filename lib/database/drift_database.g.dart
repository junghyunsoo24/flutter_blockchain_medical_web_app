// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _medicationNameMeta =
      const VerificationMeta('medicationName');
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
      'medication_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _takeTimeMeta =
      const VerificationMeta('takeTime');
  @override
  late final GeneratedColumn<DateTime> takeTime = GeneratedColumn<DateTime>(
      'take_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, medicationName, dosage, time, isEnabled, takeTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<Alarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('medication_name')) {
      context.handle(
          _medicationNameMeta,
          medicationName.isAcceptableOrUnknown(
              data['medication_name']!, _medicationNameMeta));
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('take_time')) {
      context.handle(_takeTimeMeta,
          takeTime.isAcceptableOrUnknown(data['take_time']!, _takeTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      medicationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}medication_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      takeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}take_time']),
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class Alarm extends DataClass implements Insertable<Alarm> {
  final int id;
  final String medicationName;
  final String dosage;
  final DateTime time;
  final bool isEnabled;
  final DateTime? takeTime;
  const Alarm(
      {required this.id,
      required this.medicationName,
      required this.dosage,
      required this.time,
      required this.isEnabled,
      this.takeTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['medication_name'] = Variable<String>(medicationName);
    map['dosage'] = Variable<String>(dosage);
    map['time'] = Variable<DateTime>(time);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || takeTime != null) {
      map['take_time'] = Variable<DateTime>(takeTime);
    }
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      medicationName: Value(medicationName),
      dosage: Value(dosage),
      time: Value(time),
      isEnabled: Value(isEnabled),
      takeTime: takeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(takeTime),
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<int>(json['id']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      time: serializer.fromJson<DateTime>(json['time']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      takeTime: serializer.fromJson<DateTime?>(json['takeTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'medicationName': serializer.toJson<String>(medicationName),
      'dosage': serializer.toJson<String>(dosage),
      'time': serializer.toJson<DateTime>(time),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'takeTime': serializer.toJson<DateTime?>(takeTime),
    };
  }

  Alarm copyWith(
          {int? id,
          String? medicationName,
          String? dosage,
          DateTime? time,
          bool? isEnabled,
          Value<DateTime?> takeTime = const Value.absent()}) =>
      Alarm(
        id: id ?? this.id,
        medicationName: medicationName ?? this.medicationName,
        dosage: dosage ?? this.dosage,
        time: time ?? this.time,
        isEnabled: isEnabled ?? this.isEnabled,
        takeTime: takeTime.present ? takeTime.value : this.takeTime,
      );
  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('takeTime: $takeTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, medicationName, dosage, time, isEnabled, takeTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.medicationName == this.medicationName &&
          other.dosage == this.dosage &&
          other.time == this.time &&
          other.isEnabled == this.isEnabled &&
          other.takeTime == this.takeTime);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<String> medicationName;
  final Value<String> dosage;
  final Value<DateTime> time;
  final Value<bool> isEnabled;
  final Value<DateTime?> takeTime;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.time = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.takeTime = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required String medicationName,
    required String dosage,
    required DateTime time,
    this.isEnabled = const Value.absent(),
    this.takeTime = const Value.absent(),
  })  : medicationName = Value(medicationName),
        dosage = Value(dosage),
        time = Value(time);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<String>? medicationName,
    Expression<String>? dosage,
    Expression<DateTime>? time,
    Expression<bool>? isEnabled,
    Expression<DateTime>? takeTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicationName != null) 'medication_name': medicationName,
      if (dosage != null) 'dosage': dosage,
      if (time != null) 'time': time,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (takeTime != null) 'take_time': takeTime,
    });
  }

  AlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String>? medicationName,
      Value<String>? dosage,
      Value<DateTime>? time,
      Value<bool>? isEnabled,
      Value<DateTime?>? takeTime}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      takeTime: takeTime ?? this.takeTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (takeTime.present) {
      map['take_time'] = Variable<DateTime>(takeTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('takeTime: $takeTime')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _symptomMeta =
      const VerificationMeta('symptom');
  @override
  late final GeneratedColumn<String> symptom = GeneratedColumn<String>(
      'symptom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTimeMeta =
      const VerificationMeta('creationTime');
  @override
  late final GeneratedColumn<DateTime> creationTime = GeneratedColumn<DateTime>(
      'creation_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, symptom, creationTime, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<Symptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symptom')) {
      context.handle(_symptomMeta,
          symptom.isAcceptableOrUnknown(data['symptom']!, _symptomMeta));
    } else if (isInserting) {
      context.missing(_symptomMeta);
    }
    if (data.containsKey('creation_time')) {
      context.handle(
          _creationTimeMeta,
          creationTime.isAcceptableOrUnknown(
              data['creation_time']!, _creationTimeMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Symptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Symptom(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      symptom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom'])!,
      creationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}creation_time'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }
}

class Symptom extends DataClass implements Insertable<Symptom> {
  final int id;
  final String symptom;
  final DateTime creationTime;
  final DateTime startDate;
  final DateTime endDate;
  const Symptom(
      {required this.id,
      required this.symptom,
      required this.creationTime,
      required this.startDate,
      required this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symptom'] = Variable<String>(symptom);
    map['creation_time'] = Variable<DateTime>(creationTime);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      id: Value(id),
      symptom: Value(symptom),
      creationTime: Value(creationTime),
      startDate: Value(startDate),
      endDate: Value(endDate),
    );
  }

  factory Symptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Symptom(
      id: serializer.fromJson<int>(json['id']),
      symptom: serializer.fromJson<String>(json['symptom']),
      creationTime: serializer.fromJson<DateTime>(json['creationTime']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symptom': serializer.toJson<String>(symptom),
      'creationTime': serializer.toJson<DateTime>(creationTime),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
    };
  }

  Symptom copyWith(
          {int? id,
          String? symptom,
          DateTime? creationTime,
          DateTime? startDate,
          DateTime? endDate}) =>
      Symptom(
        id: id ?? this.id,
        symptom: symptom ?? this.symptom,
        creationTime: creationTime ?? this.creationTime,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
  @override
  String toString() {
    return (StringBuffer('Symptom(')
          ..write('id: $id, ')
          ..write('symptom: $symptom, ')
          ..write('creationTime: $creationTime, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, symptom, creationTime, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Symptom &&
          other.id == this.id &&
          other.symptom == this.symptom &&
          other.creationTime == this.creationTime &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<int> id;
  final Value<String> symptom;
  final Value<DateTime> creationTime;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  const SymptomsCompanion({
    this.id = const Value.absent(),
    this.symptom = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  SymptomsCompanion.insert({
    this.id = const Value.absent(),
    required String symptom,
    this.creationTime = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
  })  : symptom = Value(symptom),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<Symptom> custom({
    Expression<int>? id,
    Expression<String>? symptom,
    Expression<DateTime>? creationTime,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symptom != null) 'symptom': symptom,
      if (creationTime != null) 'creation_time': creationTime,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    });
  }

  SymptomsCompanion copyWith(
      {Value<int>? id,
      Value<String>? symptom,
      Value<DateTime>? creationTime,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate}) {
    return SymptomsCompanion(
      id: id ?? this.id,
      symptom: symptom ?? this.symptom,
      creationTime: creationTime ?? this.creationTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symptom.present) {
      map['symptom'] = Variable<String>(symptom.value);
    }
    if (creationTime.present) {
      map['creation_time'] = Variable<DateTime>(creationTime.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('id: $id, ')
          ..write('symptom: $symptom, ')
          ..write('creationTime: $creationTime, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }
}

class $PersonalMedicinesTable extends PersonalMedicines
    with TableInfo<$PersonalMedicinesTable, PersonalMedicine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalMedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pillNameMeta =
      const VerificationMeta('pillName');
  @override
  late final GeneratedColumn<String> pillName = GeneratedColumn<String>(
      'pill_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTimeMeta =
      const VerificationMeta('creationTime');
  @override
  late final GeneratedColumn<DateTime> creationTime = GeneratedColumn<DateTime>(
      'creation_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, pillName, creationTime, startDate, endDate, dosage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_medicines';
  @override
  VerificationContext validateIntegrity(Insertable<PersonalMedicine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pill_name')) {
      context.handle(_pillNameMeta,
          pillName.isAcceptableOrUnknown(data['pill_name']!, _pillNameMeta));
    } else if (isInserting) {
      context.missing(_pillNameMeta);
    }
    if (data.containsKey('creation_time')) {
      context.handle(
          _creationTimeMeta,
          creationTime.isAcceptableOrUnknown(
              data['creation_time']!, _creationTimeMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalMedicine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalMedicine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pillName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pill_name'])!,
      creationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}creation_time'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
    );
  }

  @override
  $PersonalMedicinesTable createAlias(String alias) {
    return $PersonalMedicinesTable(attachedDatabase, alias);
  }
}

class PersonalMedicine extends DataClass
    implements Insertable<PersonalMedicine> {
  final int id;
  final String pillName;
  final DateTime creationTime;
  final DateTime startDate;
  final DateTime endDate;
  final String dosage;
  const PersonalMedicine(
      {required this.id,
      required this.pillName,
      required this.creationTime,
      required this.startDate,
      required this.endDate,
      required this.dosage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pill_name'] = Variable<String>(pillName);
    map['creation_time'] = Variable<DateTime>(creationTime);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['dosage'] = Variable<String>(dosage);
    return map;
  }

  PersonalMedicinesCompanion toCompanion(bool nullToAbsent) {
    return PersonalMedicinesCompanion(
      id: Value(id),
      pillName: Value(pillName),
      creationTime: Value(creationTime),
      startDate: Value(startDate),
      endDate: Value(endDate),
      dosage: Value(dosage),
    );
  }

  factory PersonalMedicine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalMedicine(
      id: serializer.fromJson<int>(json['id']),
      pillName: serializer.fromJson<String>(json['pillName']),
      creationTime: serializer.fromJson<DateTime>(json['creationTime']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      dosage: serializer.fromJson<String>(json['dosage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pillName': serializer.toJson<String>(pillName),
      'creationTime': serializer.toJson<DateTime>(creationTime),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'dosage': serializer.toJson<String>(dosage),
    };
  }

  PersonalMedicine copyWith(
          {int? id,
          String? pillName,
          DateTime? creationTime,
          DateTime? startDate,
          DateTime? endDate,
          String? dosage}) =>
      PersonalMedicine(
        id: id ?? this.id,
        pillName: pillName ?? this.pillName,
        creationTime: creationTime ?? this.creationTime,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        dosage: dosage ?? this.dosage,
      );
  @override
  String toString() {
    return (StringBuffer('PersonalMedicine(')
          ..write('id: $id, ')
          ..write('pillName: $pillName, ')
          ..write('creationTime: $creationTime, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('dosage: $dosage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pillName, creationTime, startDate, endDate, dosage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalMedicine &&
          other.id == this.id &&
          other.pillName == this.pillName &&
          other.creationTime == this.creationTime &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.dosage == this.dosage);
}

class PersonalMedicinesCompanion extends UpdateCompanion<PersonalMedicine> {
  final Value<int> id;
  final Value<String> pillName;
  final Value<DateTime> creationTime;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> dosage;
  const PersonalMedicinesCompanion({
    this.id = const Value.absent(),
    this.pillName = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.dosage = const Value.absent(),
  });
  PersonalMedicinesCompanion.insert({
    this.id = const Value.absent(),
    required String pillName,
    this.creationTime = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    required String dosage,
  })  : pillName = Value(pillName),
        startDate = Value(startDate),
        endDate = Value(endDate),
        dosage = Value(dosage);
  static Insertable<PersonalMedicine> custom({
    Expression<int>? id,
    Expression<String>? pillName,
    Expression<DateTime>? creationTime,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? dosage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pillName != null) 'pill_name': pillName,
      if (creationTime != null) 'creation_time': creationTime,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (dosage != null) 'dosage': dosage,
    });
  }

  PersonalMedicinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? pillName,
      Value<DateTime>? creationTime,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<String>? dosage}) {
    return PersonalMedicinesCompanion(
      id: id ?? this.id,
      pillName: pillName ?? this.pillName,
      creationTime: creationTime ?? this.creationTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dosage: dosage ?? this.dosage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pillName.present) {
      map['pill_name'] = Variable<String>(pillName.value);
    }
    if (creationTime.present) {
      map['creation_time'] = Variable<DateTime>(creationTime.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalMedicinesCompanion(')
          ..write('id: $id, ')
          ..write('pillName: $pillName, ')
          ..write('creationTime: $creationTime, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('dosage: $dosage')
          ..write(')'))
        .toString();
  }
}

class $PrescriptionsTable extends Prescriptions
    with TableInfo<$PrescriptionsTable, Prescription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrescriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resHospitalNameMeta =
      const VerificationMeta('resHospitalName');
  @override
  late final GeneratedColumn<String> resHospitalName = GeneratedColumn<String>(
      'res_hospital_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTimeMeta =
      const VerificationMeta('creationTime');
  @override
  late final GeneratedColumn<DateTime> creationTime = GeneratedColumn<DateTime>(
      'creation_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _resTreatDateMeta =
      const VerificationMeta('resTreatDate');
  @override
  late final GeneratedColumn<DateTime> resTreatDate = GeneratedColumn<DateTime>(
      'res_treat_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _resPrescribeDrugNameMeta =
      const VerificationMeta('resPrescribeDrugName');
  @override
  late final GeneratedColumn<String> resPrescribeDrugName =
      GeneratedColumn<String>('res_prescribe_drug_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resPrescribeDrugEffectMeta =
      const VerificationMeta('resPrescribeDrugEffect');
  @override
  late final GeneratedColumn<String> resPrescribeDrugEffect =
      GeneratedColumn<String>('res_prescribe_drug_effect', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resMedicationDirectionMeta =
      const VerificationMeta('resMedicationDirection');
  @override
  late final GeneratedColumn<String> resMedicationDirection =
      GeneratedColumn<String>('res_medication_direction', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resPrescribeDaysMeta =
      const VerificationMeta('resPrescribeDays');
  @override
  late final GeneratedColumn<String> resPrescribeDays = GeneratedColumn<String>(
      'res_prescribe_days', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _resDrugImageLinkMeta =
      const VerificationMeta('resDrugImageLink');
  @override
  late final GeneratedColumn<String> resDrugImageLink = GeneratedColumn<String>(
      'res_drug_image_link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        resHospitalName,
        creationTime,
        resTreatDate,
        resPrescribeDrugName,
        resPrescribeDrugEffect,
        resMedicationDirection,
        resPrescribeDays,
        count,
        resDrugImageLink
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prescriptions';
  @override
  VerificationContext validateIntegrity(Insertable<Prescription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('res_hospital_name')) {
      context.handle(
          _resHospitalNameMeta,
          resHospitalName.isAcceptableOrUnknown(
              data['res_hospital_name']!, _resHospitalNameMeta));
    } else if (isInserting) {
      context.missing(_resHospitalNameMeta);
    }
    if (data.containsKey('creation_time')) {
      context.handle(
          _creationTimeMeta,
          creationTime.isAcceptableOrUnknown(
              data['creation_time']!, _creationTimeMeta));
    }
    if (data.containsKey('res_treat_date')) {
      context.handle(
          _resTreatDateMeta,
          resTreatDate.isAcceptableOrUnknown(
              data['res_treat_date']!, _resTreatDateMeta));
    } else if (isInserting) {
      context.missing(_resTreatDateMeta);
    }
    if (data.containsKey('res_prescribe_drug_name')) {
      context.handle(
          _resPrescribeDrugNameMeta,
          resPrescribeDrugName.isAcceptableOrUnknown(
              data['res_prescribe_drug_name']!, _resPrescribeDrugNameMeta));
    } else if (isInserting) {
      context.missing(_resPrescribeDrugNameMeta);
    }
    if (data.containsKey('res_prescribe_drug_effect')) {
      context.handle(
          _resPrescribeDrugEffectMeta,
          resPrescribeDrugEffect.isAcceptableOrUnknown(
              data['res_prescribe_drug_effect']!, _resPrescribeDrugEffectMeta));
    } else if (isInserting) {
      context.missing(_resPrescribeDrugEffectMeta);
    }
    if (data.containsKey('res_medication_direction')) {
      context.handle(
          _resMedicationDirectionMeta,
          resMedicationDirection.isAcceptableOrUnknown(
              data['res_medication_direction']!, _resMedicationDirectionMeta));
    } else if (isInserting) {
      context.missing(_resMedicationDirectionMeta);
    }
    if (data.containsKey('res_prescribe_days')) {
      context.handle(
          _resPrescribeDaysMeta,
          resPrescribeDays.isAcceptableOrUnknown(
              data['res_prescribe_days']!, _resPrescribeDaysMeta));
    } else if (isInserting) {
      context.missing(_resPrescribeDaysMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('res_drug_image_link')) {
      context.handle(
          _resDrugImageLinkMeta,
          resDrugImageLink.isAcceptableOrUnknown(
              data['res_drug_image_link']!, _resDrugImageLinkMeta));
    } else if (isInserting) {
      context.missing(_resDrugImageLinkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prescription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prescription(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resHospitalName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}res_hospital_name'])!,
      creationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}creation_time'])!,
      resTreatDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}res_treat_date'])!,
      resPrescribeDrugName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}res_prescribe_drug_name'])!,
      resPrescribeDrugEffect: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}res_prescribe_drug_effect'])!,
      resMedicationDirection: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}res_medication_direction'])!,
      resPrescribeDays: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}res_prescribe_days'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      resDrugImageLink: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}res_drug_image_link'])!,
    );
  }

  @override
  $PrescriptionsTable createAlias(String alias) {
    return $PrescriptionsTable(attachedDatabase, alias);
  }
}

class Prescription extends DataClass implements Insertable<Prescription> {
  final int id;
  final String resHospitalName;
  final DateTime creationTime;
  final DateTime resTreatDate;
  final String resPrescribeDrugName;
  final String resPrescribeDrugEffect;
  final String resMedicationDirection;
  final String resPrescribeDays;
  final int count;
  final String resDrugImageLink;
  const Prescription(
      {required this.id,
      required this.resHospitalName,
      required this.creationTime,
      required this.resTreatDate,
      required this.resPrescribeDrugName,
      required this.resPrescribeDrugEffect,
      required this.resMedicationDirection,
      required this.resPrescribeDays,
      required this.count,
      required this.resDrugImageLink});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['res_hospital_name'] = Variable<String>(resHospitalName);
    map['creation_time'] = Variable<DateTime>(creationTime);
    map['res_treat_date'] = Variable<DateTime>(resTreatDate);
    map['res_prescribe_drug_name'] = Variable<String>(resPrescribeDrugName);
    map['res_prescribe_drug_effect'] = Variable<String>(resPrescribeDrugEffect);
    map['res_medication_direction'] = Variable<String>(resMedicationDirection);
    map['res_prescribe_days'] = Variable<String>(resPrescribeDays);
    map['count'] = Variable<int>(count);
    map['res_drug_image_link'] = Variable<String>(resDrugImageLink);
    return map;
  }

  PrescriptionsCompanion toCompanion(bool nullToAbsent) {
    return PrescriptionsCompanion(
      id: Value(id),
      resHospitalName: Value(resHospitalName),
      creationTime: Value(creationTime),
      resTreatDate: Value(resTreatDate),
      resPrescribeDrugName: Value(resPrescribeDrugName),
      resPrescribeDrugEffect: Value(resPrescribeDrugEffect),
      resMedicationDirection: Value(resMedicationDirection),
      resPrescribeDays: Value(resPrescribeDays),
      count: Value(count),
      resDrugImageLink: Value(resDrugImageLink),
    );
  }

  factory Prescription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prescription(
      id: serializer.fromJson<int>(json['id']),
      resHospitalName: serializer.fromJson<String>(json['resHospitalName']),
      creationTime: serializer.fromJson<DateTime>(json['creationTime']),
      resTreatDate: serializer.fromJson<DateTime>(json['resTreatDate']),
      resPrescribeDrugName:
          serializer.fromJson<String>(json['resPrescribeDrugName']),
      resPrescribeDrugEffect:
          serializer.fromJson<String>(json['resPrescribeDrugEffect']),
      resMedicationDirection:
          serializer.fromJson<String>(json['resMedicationDirection']),
      resPrescribeDays: serializer.fromJson<String>(json['resPrescribeDays']),
      count: serializer.fromJson<int>(json['count']),
      resDrugImageLink: serializer.fromJson<String>(json['resDrugImageLink']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resHospitalName': serializer.toJson<String>(resHospitalName),
      'creationTime': serializer.toJson<DateTime>(creationTime),
      'resTreatDate': serializer.toJson<DateTime>(resTreatDate),
      'resPrescribeDrugName': serializer.toJson<String>(resPrescribeDrugName),
      'resPrescribeDrugEffect':
          serializer.toJson<String>(resPrescribeDrugEffect),
      'resMedicationDirection':
          serializer.toJson<String>(resMedicationDirection),
      'resPrescribeDays': serializer.toJson<String>(resPrescribeDays),
      'count': serializer.toJson<int>(count),
      'resDrugImageLink': serializer.toJson<String>(resDrugImageLink),
    };
  }

  Prescription copyWith(
          {int? id,
          String? resHospitalName,
          DateTime? creationTime,
          DateTime? resTreatDate,
          String? resPrescribeDrugName,
          String? resPrescribeDrugEffect,
          String? resMedicationDirection,
          String? resPrescribeDays,
          int? count,
          String? resDrugImageLink}) =>
      Prescription(
        id: id ?? this.id,
        resHospitalName: resHospitalName ?? this.resHospitalName,
        creationTime: creationTime ?? this.creationTime,
        resTreatDate: resTreatDate ?? this.resTreatDate,
        resPrescribeDrugName: resPrescribeDrugName ?? this.resPrescribeDrugName,
        resPrescribeDrugEffect:
            resPrescribeDrugEffect ?? this.resPrescribeDrugEffect,
        resMedicationDirection:
            resMedicationDirection ?? this.resMedicationDirection,
        resPrescribeDays: resPrescribeDays ?? this.resPrescribeDays,
        count: count ?? this.count,
        resDrugImageLink: resDrugImageLink ?? this.resDrugImageLink,
      );
  @override
  String toString() {
    return (StringBuffer('Prescription(')
          ..write('id: $id, ')
          ..write('resHospitalName: $resHospitalName, ')
          ..write('creationTime: $creationTime, ')
          ..write('resTreatDate: $resTreatDate, ')
          ..write('resPrescribeDrugName: $resPrescribeDrugName, ')
          ..write('resPrescribeDrugEffect: $resPrescribeDrugEffect, ')
          ..write('resMedicationDirection: $resMedicationDirection, ')
          ..write('resPrescribeDays: $resPrescribeDays, ')
          ..write('count: $count, ')
          ..write('resDrugImageLink: $resDrugImageLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      resHospitalName,
      creationTime,
      resTreatDate,
      resPrescribeDrugName,
      resPrescribeDrugEffect,
      resMedicationDirection,
      resPrescribeDays,
      count,
      resDrugImageLink);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prescription &&
          other.id == this.id &&
          other.resHospitalName == this.resHospitalName &&
          other.creationTime == this.creationTime &&
          other.resTreatDate == this.resTreatDate &&
          other.resPrescribeDrugName == this.resPrescribeDrugName &&
          other.resPrescribeDrugEffect == this.resPrescribeDrugEffect &&
          other.resMedicationDirection == this.resMedicationDirection &&
          other.resPrescribeDays == this.resPrescribeDays &&
          other.count == this.count &&
          other.resDrugImageLink == this.resDrugImageLink);
}

class PrescriptionsCompanion extends UpdateCompanion<Prescription> {
  final Value<int> id;
  final Value<String> resHospitalName;
  final Value<DateTime> creationTime;
  final Value<DateTime> resTreatDate;
  final Value<String> resPrescribeDrugName;
  final Value<String> resPrescribeDrugEffect;
  final Value<String> resMedicationDirection;
  final Value<String> resPrescribeDays;
  final Value<int> count;
  final Value<String> resDrugImageLink;
  const PrescriptionsCompanion({
    this.id = const Value.absent(),
    this.resHospitalName = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.resTreatDate = const Value.absent(),
    this.resPrescribeDrugName = const Value.absent(),
    this.resPrescribeDrugEffect = const Value.absent(),
    this.resMedicationDirection = const Value.absent(),
    this.resPrescribeDays = const Value.absent(),
    this.count = const Value.absent(),
    this.resDrugImageLink = const Value.absent(),
  });
  PrescriptionsCompanion.insert({
    this.id = const Value.absent(),
    required String resHospitalName,
    this.creationTime = const Value.absent(),
    required DateTime resTreatDate,
    required String resPrescribeDrugName,
    required String resPrescribeDrugEffect,
    required String resMedicationDirection,
    required String resPrescribeDays,
    required int count,
    required String resDrugImageLink,
  })  : resHospitalName = Value(resHospitalName),
        resTreatDate = Value(resTreatDate),
        resPrescribeDrugName = Value(resPrescribeDrugName),
        resPrescribeDrugEffect = Value(resPrescribeDrugEffect),
        resMedicationDirection = Value(resMedicationDirection),
        resPrescribeDays = Value(resPrescribeDays),
        count = Value(count),
        resDrugImageLink = Value(resDrugImageLink);
  static Insertable<Prescription> custom({
    Expression<int>? id,
    Expression<String>? resHospitalName,
    Expression<DateTime>? creationTime,
    Expression<DateTime>? resTreatDate,
    Expression<String>? resPrescribeDrugName,
    Expression<String>? resPrescribeDrugEffect,
    Expression<String>? resMedicationDirection,
    Expression<String>? resPrescribeDays,
    Expression<int>? count,
    Expression<String>? resDrugImageLink,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resHospitalName != null) 'res_hospital_name': resHospitalName,
      if (creationTime != null) 'creation_time': creationTime,
      if (resTreatDate != null) 'res_treat_date': resTreatDate,
      if (resPrescribeDrugName != null)
        'res_prescribe_drug_name': resPrescribeDrugName,
      if (resPrescribeDrugEffect != null)
        'res_prescribe_drug_effect': resPrescribeDrugEffect,
      if (resMedicationDirection != null)
        'res_medication_direction': resMedicationDirection,
      if (resPrescribeDays != null) 'res_prescribe_days': resPrescribeDays,
      if (count != null) 'count': count,
      if (resDrugImageLink != null) 'res_drug_image_link': resDrugImageLink,
    });
  }

  PrescriptionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? resHospitalName,
      Value<DateTime>? creationTime,
      Value<DateTime>? resTreatDate,
      Value<String>? resPrescribeDrugName,
      Value<String>? resPrescribeDrugEffect,
      Value<String>? resMedicationDirection,
      Value<String>? resPrescribeDays,
      Value<int>? count,
      Value<String>? resDrugImageLink}) {
    return PrescriptionsCompanion(
      id: id ?? this.id,
      resHospitalName: resHospitalName ?? this.resHospitalName,
      creationTime: creationTime ?? this.creationTime,
      resTreatDate: resTreatDate ?? this.resTreatDate,
      resPrescribeDrugName: resPrescribeDrugName ?? this.resPrescribeDrugName,
      resPrescribeDrugEffect:
          resPrescribeDrugEffect ?? this.resPrescribeDrugEffect,
      resMedicationDirection:
          resMedicationDirection ?? this.resMedicationDirection,
      resPrescribeDays: resPrescribeDays ?? this.resPrescribeDays,
      count: count ?? this.count,
      resDrugImageLink: resDrugImageLink ?? this.resDrugImageLink,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resHospitalName.present) {
      map['res_hospital_name'] = Variable<String>(resHospitalName.value);
    }
    if (creationTime.present) {
      map['creation_time'] = Variable<DateTime>(creationTime.value);
    }
    if (resTreatDate.present) {
      map['res_treat_date'] = Variable<DateTime>(resTreatDate.value);
    }
    if (resPrescribeDrugName.present) {
      map['res_prescribe_drug_name'] =
          Variable<String>(resPrescribeDrugName.value);
    }
    if (resPrescribeDrugEffect.present) {
      map['res_prescribe_drug_effect'] =
          Variable<String>(resPrescribeDrugEffect.value);
    }
    if (resMedicationDirection.present) {
      map['res_medication_direction'] =
          Variable<String>(resMedicationDirection.value);
    }
    if (resPrescribeDays.present) {
      map['res_prescribe_days'] = Variable<String>(resPrescribeDays.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (resDrugImageLink.present) {
      map['res_drug_image_link'] = Variable<String>(resDrugImageLink.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionsCompanion(')
          ..write('id: $id, ')
          ..write('resHospitalName: $resHospitalName, ')
          ..write('creationTime: $creationTime, ')
          ..write('resTreatDate: $resTreatDate, ')
          ..write('resPrescribeDrugName: $resPrescribeDrugName, ')
          ..write('resPrescribeDrugEffect: $resPrescribeDrugEffect, ')
          ..write('resMedicationDirection: $resMedicationDirection, ')
          ..write('resPrescribeDays: $resPrescribeDays, ')
          ..write('count: $count, ')
          ..write('resDrugImageLink: $resDrugImageLink')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $PersonalMedicinesTable personalMedicines =
      $PersonalMedicinesTable(this);
  late final $PrescriptionsTable prescriptions = $PrescriptionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, symptoms, personalMedicines, prescriptions];
}
