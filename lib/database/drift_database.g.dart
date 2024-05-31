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

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
      'user_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userPWMeta = const VerificationMeta('userPW');
  @override
  late final GeneratedColumn<String> userPW = GeneratedColumn<String>(
      'user_p_w', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
      'birthday', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
      'gender', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userID, userPW, name, birthday, gender, height, weight, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_i_d')) {
      context.handle(_userIDMeta,
          userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta));
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('user_p_w')) {
      context.handle(_userPWMeta,
          userPW.isAcceptableOrUnknown(data['user_p_w']!, _userPWMeta));
    } else if (isInserting) {
      context.missing(_userPWMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_i_d'])!,
      userPW: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_p_w'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birthday'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final String userID;
  final String userPW;
  final String name;
  final String birthday;
  final int gender;
  final double height;
  final double weight;
  final String role;
  const Patient(
      {required this.id,
      required this.userID,
      required this.userPW,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.height,
      required this.weight,
      required this.role});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_i_d'] = Variable<String>(userID);
    map['user_p_w'] = Variable<String>(userPW);
    map['name'] = Variable<String>(name);
    map['birthday'] = Variable<String>(birthday);
    map['gender'] = Variable<int>(gender);
    map['height'] = Variable<double>(height);
    map['weight'] = Variable<double>(weight);
    map['role'] = Variable<String>(role);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      userID: Value(userID),
      userPW: Value(userPW),
      name: Value(name),
      birthday: Value(birthday),
      gender: Value(gender),
      height: Value(height),
      weight: Value(weight),
      role: Value(role),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      userID: serializer.fromJson<String>(json['userID']),
      userPW: serializer.fromJson<String>(json['userPW']),
      name: serializer.fromJson<String>(json['name']),
      birthday: serializer.fromJson<String>(json['birthday']),
      gender: serializer.fromJson<int>(json['gender']),
      height: serializer.fromJson<double>(json['height']),
      weight: serializer.fromJson<double>(json['weight']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userID': serializer.toJson<String>(userID),
      'userPW': serializer.toJson<String>(userPW),
      'name': serializer.toJson<String>(name),
      'birthday': serializer.toJson<String>(birthday),
      'gender': serializer.toJson<int>(gender),
      'height': serializer.toJson<double>(height),
      'weight': serializer.toJson<double>(weight),
      'role': serializer.toJson<String>(role),
    };
  }

  Patient copyWith(
          {int? id,
          String? userID,
          String? userPW,
          String? name,
          String? birthday,
          int? gender,
          double? height,
          double? weight,
          String? role}) =>
      Patient(
        id: id ?? this.id,
        userID: userID ?? this.userID,
        userPW: userPW ?? this.userPW,
        name: name ?? this.name,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        role: role ?? this.role,
      );
  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('userPW: $userPW, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userID, userPW, name, birthday, gender, height, weight, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.userPW == this.userPW &&
          other.name == this.name &&
          other.birthday == this.birthday &&
          other.gender == this.gender &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.role == this.role);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> userID;
  final Value<String> userPW;
  final Value<String> name;
  final Value<String> birthday;
  final Value<int> gender;
  final Value<double> height;
  final Value<double> weight;
  final Value<String> role;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.userPW = const Value.absent(),
    this.name = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.role = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String userID,
    required String userPW,
    required String name,
    required String birthday,
    required int gender,
    required double height,
    required double weight,
    required String role,
  })  : userID = Value(userID),
        userPW = Value(userPW),
        name = Value(name),
        birthday = Value(birthday),
        gender = Value(gender),
        height = Value(height),
        weight = Value(weight),
        role = Value(role);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? userID,
    Expression<String>? userPW,
    Expression<String>? name,
    Expression<String>? birthday,
    Expression<int>? gender,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userID != null) 'user_i_d': userID,
      if (userPW != null) 'user_p_w': userPW,
      if (name != null) 'name': name,
      if (birthday != null) 'birthday': birthday,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (role != null) 'role': role,
    });
  }

  PatientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userID,
      Value<String>? userPW,
      Value<String>? name,
      Value<String>? birthday,
      Value<int>? gender,
      Value<double>? height,
      Value<double>? weight,
      Value<String>? role}) {
    return PatientsCompanion(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      userPW: userPW ?? this.userPW,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<String>(userID.value);
    }
    if (userPW.present) {
      map['user_p_w'] = Variable<String>(userPW.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('userPW: $userPW, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $DoctorsTable extends Doctors with TableInfo<$DoctorsTable, Doctor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
      'user_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userPWMeta = const VerificationMeta('userPW');
  @override
  late final GeneratedColumn<String> userPW = GeneratedColumn<String>(
      'user_p_w', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fieldMeta = const VerificationMeta('field');
  @override
  late final GeneratedColumn<String> field = GeneratedColumn<String>(
      'field', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hospitalMeta =
      const VerificationMeta('hospital');
  @override
  late final GeneratedColumn<String> hospital = GeneratedColumn<String>(
      'hospital', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _introductionMeta =
      const VerificationMeta('introduction');
  @override
  late final GeneratedColumn<String> introduction = GeneratedColumn<String>(
      'introduction', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userID, userPW, name, field, hospital, introduction];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctors';
  @override
  VerificationContext validateIntegrity(Insertable<Doctor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_i_d')) {
      context.handle(_userIDMeta,
          userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta));
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('user_p_w')) {
      context.handle(_userPWMeta,
          userPW.isAcceptableOrUnknown(data['user_p_w']!, _userPWMeta));
    } else if (isInserting) {
      context.missing(_userPWMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('field')) {
      context.handle(
          _fieldMeta, field.isAcceptableOrUnknown(data['field']!, _fieldMeta));
    } else if (isInserting) {
      context.missing(_fieldMeta);
    }
    if (data.containsKey('hospital')) {
      context.handle(_hospitalMeta,
          hospital.isAcceptableOrUnknown(data['hospital']!, _hospitalMeta));
    } else if (isInserting) {
      context.missing(_hospitalMeta);
    }
    if (data.containsKey('introduction')) {
      context.handle(
          _introductionMeta,
          introduction.isAcceptableOrUnknown(
              data['introduction']!, _introductionMeta));
    } else if (isInserting) {
      context.missing(_introductionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Doctor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Doctor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_i_d'])!,
      userPW: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_p_w'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      field: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field'])!,
      hospital: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hospital'])!,
      introduction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}introduction'])!,
    );
  }

  @override
  $DoctorsTable createAlias(String alias) {
    return $DoctorsTable(attachedDatabase, alias);
  }
}

class Doctor extends DataClass implements Insertable<Doctor> {
  final int id;
  final String userID;
  final String userPW;
  final String name;
  final String field;
  final String hospital;
  final String introduction;
  const Doctor(
      {required this.id,
      required this.userID,
      required this.userPW,
      required this.name,
      required this.field,
      required this.hospital,
      required this.introduction});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_i_d'] = Variable<String>(userID);
    map['user_p_w'] = Variable<String>(userPW);
    map['name'] = Variable<String>(name);
    map['field'] = Variable<String>(field);
    map['hospital'] = Variable<String>(hospital);
    map['introduction'] = Variable<String>(introduction);
    return map;
  }

  DoctorsCompanion toCompanion(bool nullToAbsent) {
    return DoctorsCompanion(
      id: Value(id),
      userID: Value(userID),
      userPW: Value(userPW),
      name: Value(name),
      field: Value(field),
      hospital: Value(hospital),
      introduction: Value(introduction),
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Doctor(
      id: serializer.fromJson<int>(json['id']),
      userID: serializer.fromJson<String>(json['userID']),
      userPW: serializer.fromJson<String>(json['userPW']),
      name: serializer.fromJson<String>(json['name']),
      field: serializer.fromJson<String>(json['field']),
      hospital: serializer.fromJson<String>(json['hospital']),
      introduction: serializer.fromJson<String>(json['introduction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userID': serializer.toJson<String>(userID),
      'userPW': serializer.toJson<String>(userPW),
      'name': serializer.toJson<String>(name),
      'field': serializer.toJson<String>(field),
      'hospital': serializer.toJson<String>(hospital),
      'introduction': serializer.toJson<String>(introduction),
    };
  }

  Doctor copyWith(
          {int? id,
          String? userID,
          String? userPW,
          String? name,
          String? field,
          String? hospital,
          String? introduction}) =>
      Doctor(
        id: id ?? this.id,
        userID: userID ?? this.userID,
        userPW: userPW ?? this.userPW,
        name: name ?? this.name,
        field: field ?? this.field,
        hospital: hospital ?? this.hospital,
        introduction: introduction ?? this.introduction,
      );
  @override
  String toString() {
    return (StringBuffer('Doctor(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('userPW: $userPW, ')
          ..write('name: $name, ')
          ..write('field: $field, ')
          ..write('hospital: $hospital, ')
          ..write('introduction: $introduction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userID, userPW, name, field, hospital, introduction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doctor &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.userPW == this.userPW &&
          other.name == this.name &&
          other.field == this.field &&
          other.hospital == this.hospital &&
          other.introduction == this.introduction);
}

class DoctorsCompanion extends UpdateCompanion<Doctor> {
  final Value<int> id;
  final Value<String> userID;
  final Value<String> userPW;
  final Value<String> name;
  final Value<String> field;
  final Value<String> hospital;
  final Value<String> introduction;
  const DoctorsCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.userPW = const Value.absent(),
    this.name = const Value.absent(),
    this.field = const Value.absent(),
    this.hospital = const Value.absent(),
    this.introduction = const Value.absent(),
  });
  DoctorsCompanion.insert({
    this.id = const Value.absent(),
    required String userID,
    required String userPW,
    required String name,
    required String field,
    required String hospital,
    required String introduction,
  })  : userID = Value(userID),
        userPW = Value(userPW),
        name = Value(name),
        field = Value(field),
        hospital = Value(hospital),
        introduction = Value(introduction);
  static Insertable<Doctor> custom({
    Expression<int>? id,
    Expression<String>? userID,
    Expression<String>? userPW,
    Expression<String>? name,
    Expression<String>? field,
    Expression<String>? hospital,
    Expression<String>? introduction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userID != null) 'user_i_d': userID,
      if (userPW != null) 'user_p_w': userPW,
      if (name != null) 'name': name,
      if (field != null) 'field': field,
      if (hospital != null) 'hospital': hospital,
      if (introduction != null) 'introduction': introduction,
    });
  }

  DoctorsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userID,
      Value<String>? userPW,
      Value<String>? name,
      Value<String>? field,
      Value<String>? hospital,
      Value<String>? introduction}) {
    return DoctorsCompanion(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      userPW: userPW ?? this.userPW,
      name: name ?? this.name,
      field: field ?? this.field,
      hospital: hospital ?? this.hospital,
      introduction: introduction ?? this.introduction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<String>(userID.value);
    }
    if (userPW.present) {
      map['user_p_w'] = Variable<String>(userPW.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (field.present) {
      map['field'] = Variable<String>(field.value);
    }
    if (hospital.present) {
      map['hospital'] = Variable<String>(hospital.value);
    }
    if (introduction.present) {
      map['introduction'] = Variable<String>(introduction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('userPW: $userPW, ')
          ..write('name: $name, ')
          ..write('field: $field, ')
          ..write('hospital: $hospital, ')
          ..write('introduction: $introduction')
          ..write(')'))
        .toString();
  }
}

class $HealthChecksTable extends HealthChecks
    with TableInfo<$HealthChecksTable, HealthCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resOrganizationNameMeta =
      const VerificationMeta('resOrganizationName');
  @override
  late final GeneratedColumn<String> resOrganizationName =
      GeneratedColumn<String>('res_organization_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resCheckupDateMeta =
      const VerificationMeta('resCheckupDate');
  @override
  late final GeneratedColumn<DateTime> resCheckupDate =
      GeneratedColumn<DateTime>('res_checkup_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _resHeightMeta =
      const VerificationMeta('resHeight');
  @override
  late final GeneratedColumn<double> resHeight = GeneratedColumn<double>(
      'res_height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _resWeightMeta =
      const VerificationMeta('resWeight');
  @override
  late final GeneratedColumn<double> resWeight = GeneratedColumn<double>(
      'res_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _resWaistMeta =
      const VerificationMeta('resWaist');
  @override
  late final GeneratedColumn<double> resWaist = GeneratedColumn<double>(
      'res_waist', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _resBMIMeta = const VerificationMeta('resBMI');
  @override
  late final GeneratedColumn<double> resBMI = GeneratedColumn<double>(
      'res_b_m_i', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _resSightMeta =
      const VerificationMeta('resSight');
  @override
  late final GeneratedColumn<String> resSight = GeneratedColumn<String>(
      'res_sight', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resHearingMeta =
      const VerificationMeta('resHearing');
  @override
  late final GeneratedColumn<String> resHearing = GeneratedColumn<String>(
      'res_hearing', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resBloodPressureMeta =
      const VerificationMeta('resBloodPressure');
  @override
  late final GeneratedColumn<String> resBloodPressure = GeneratedColumn<String>(
      'res_blood_pressure', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resFastingBloodSugerMeta =
      const VerificationMeta('resFastingBloodSuger');
  @override
  late final GeneratedColumn<double> resFastingBloodSuger =
      GeneratedColumn<double>('res_fasting_blood_suger', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _resTotalCholesterolMeta =
      const VerificationMeta('resTotalCholesterol');
  @override
  late final GeneratedColumn<String> resTotalCholesterol =
      GeneratedColumn<String>('res_total_cholesterol', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        resOrganizationName,
        resCheckupDate,
        resHeight,
        resWeight,
        resWaist,
        resBMI,
        resSight,
        resHearing,
        resBloodPressure,
        resFastingBloodSuger,
        resTotalCholesterol
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_checks';
  @override
  VerificationContext validateIntegrity(Insertable<HealthCheck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('res_organization_name')) {
      context.handle(
          _resOrganizationNameMeta,
          resOrganizationName.isAcceptableOrUnknown(
              data['res_organization_name']!, _resOrganizationNameMeta));
    } else if (isInserting) {
      context.missing(_resOrganizationNameMeta);
    }
    if (data.containsKey('res_checkup_date')) {
      context.handle(
          _resCheckupDateMeta,
          resCheckupDate.isAcceptableOrUnknown(
              data['res_checkup_date']!, _resCheckupDateMeta));
    } else if (isInserting) {
      context.missing(_resCheckupDateMeta);
    }
    if (data.containsKey('res_height')) {
      context.handle(_resHeightMeta,
          resHeight.isAcceptableOrUnknown(data['res_height']!, _resHeightMeta));
    } else if (isInserting) {
      context.missing(_resHeightMeta);
    }
    if (data.containsKey('res_weight')) {
      context.handle(_resWeightMeta,
          resWeight.isAcceptableOrUnknown(data['res_weight']!, _resWeightMeta));
    } else if (isInserting) {
      context.missing(_resWeightMeta);
    }
    if (data.containsKey('res_waist')) {
      context.handle(_resWaistMeta,
          resWaist.isAcceptableOrUnknown(data['res_waist']!, _resWaistMeta));
    } else if (isInserting) {
      context.missing(_resWaistMeta);
    }
    if (data.containsKey('res_b_m_i')) {
      context.handle(_resBMIMeta,
          resBMI.isAcceptableOrUnknown(data['res_b_m_i']!, _resBMIMeta));
    } else if (isInserting) {
      context.missing(_resBMIMeta);
    }
    if (data.containsKey('res_sight')) {
      context.handle(_resSightMeta,
          resSight.isAcceptableOrUnknown(data['res_sight']!, _resSightMeta));
    } else if (isInserting) {
      context.missing(_resSightMeta);
    }
    if (data.containsKey('res_hearing')) {
      context.handle(
          _resHearingMeta,
          resHearing.isAcceptableOrUnknown(
              data['res_hearing']!, _resHearingMeta));
    } else if (isInserting) {
      context.missing(_resHearingMeta);
    }
    if (data.containsKey('res_blood_pressure')) {
      context.handle(
          _resBloodPressureMeta,
          resBloodPressure.isAcceptableOrUnknown(
              data['res_blood_pressure']!, _resBloodPressureMeta));
    } else if (isInserting) {
      context.missing(_resBloodPressureMeta);
    }
    if (data.containsKey('res_fasting_blood_suger')) {
      context.handle(
          _resFastingBloodSugerMeta,
          resFastingBloodSuger.isAcceptableOrUnknown(
              data['res_fasting_blood_suger']!, _resFastingBloodSugerMeta));
    } else if (isInserting) {
      context.missing(_resFastingBloodSugerMeta);
    }
    if (data.containsKey('res_total_cholesterol')) {
      context.handle(
          _resTotalCholesterolMeta,
          resTotalCholesterol.isAcceptableOrUnknown(
              data['res_total_cholesterol']!, _resTotalCholesterolMeta));
    } else if (isInserting) {
      context.missing(_resTotalCholesterolMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthCheck(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resOrganizationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}res_organization_name'])!,
      resCheckupDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}res_checkup_date'])!,
      resHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}res_height'])!,
      resWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}res_weight'])!,
      resWaist: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}res_waist'])!,
      resBMI: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}res_b_m_i'])!,
      resSight: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}res_sight'])!,
      resHearing: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}res_hearing'])!,
      resBloodPressure: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}res_blood_pressure'])!,
      resFastingBloodSuger: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}res_fasting_blood_suger'])!,
      resTotalCholesterol: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}res_total_cholesterol'])!,
    );
  }

  @override
  $HealthChecksTable createAlias(String alias) {
    return $HealthChecksTable(attachedDatabase, alias);
  }
}

class HealthCheck extends DataClass implements Insertable<HealthCheck> {
  final int id;
  final String resOrganizationName;
  final DateTime resCheckupDate;
  final double resHeight;
  final double resWeight;
  final double resWaist;
  final double resBMI;
  final String resSight;
  final String resHearing;
  final String resBloodPressure;
  final double resFastingBloodSuger;
  final String resTotalCholesterol;
  const HealthCheck(
      {required this.id,
      required this.resOrganizationName,
      required this.resCheckupDate,
      required this.resHeight,
      required this.resWeight,
      required this.resWaist,
      required this.resBMI,
      required this.resSight,
      required this.resHearing,
      required this.resBloodPressure,
      required this.resFastingBloodSuger,
      required this.resTotalCholesterol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['res_organization_name'] = Variable<String>(resOrganizationName);
    map['res_checkup_date'] = Variable<DateTime>(resCheckupDate);
    map['res_height'] = Variable<double>(resHeight);
    map['res_weight'] = Variable<double>(resWeight);
    map['res_waist'] = Variable<double>(resWaist);
    map['res_b_m_i'] = Variable<double>(resBMI);
    map['res_sight'] = Variable<String>(resSight);
    map['res_hearing'] = Variable<String>(resHearing);
    map['res_blood_pressure'] = Variable<String>(resBloodPressure);
    map['res_fasting_blood_suger'] = Variable<double>(resFastingBloodSuger);
    map['res_total_cholesterol'] = Variable<String>(resTotalCholesterol);
    return map;
  }

  HealthChecksCompanion toCompanion(bool nullToAbsent) {
    return HealthChecksCompanion(
      id: Value(id),
      resOrganizationName: Value(resOrganizationName),
      resCheckupDate: Value(resCheckupDate),
      resHeight: Value(resHeight),
      resWeight: Value(resWeight),
      resWaist: Value(resWaist),
      resBMI: Value(resBMI),
      resSight: Value(resSight),
      resHearing: Value(resHearing),
      resBloodPressure: Value(resBloodPressure),
      resFastingBloodSuger: Value(resFastingBloodSuger),
      resTotalCholesterol: Value(resTotalCholesterol),
    );
  }

  factory HealthCheck.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthCheck(
      id: serializer.fromJson<int>(json['id']),
      resOrganizationName:
          serializer.fromJson<String>(json['resOrganizationName']),
      resCheckupDate: serializer.fromJson<DateTime>(json['resCheckupDate']),
      resHeight: serializer.fromJson<double>(json['resHeight']),
      resWeight: serializer.fromJson<double>(json['resWeight']),
      resWaist: serializer.fromJson<double>(json['resWaist']),
      resBMI: serializer.fromJson<double>(json['resBMI']),
      resSight: serializer.fromJson<String>(json['resSight']),
      resHearing: serializer.fromJson<String>(json['resHearing']),
      resBloodPressure: serializer.fromJson<String>(json['resBloodPressure']),
      resFastingBloodSuger:
          serializer.fromJson<double>(json['resFastingBloodSuger']),
      resTotalCholesterol:
          serializer.fromJson<String>(json['resTotalCholesterol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resOrganizationName': serializer.toJson<String>(resOrganizationName),
      'resCheckupDate': serializer.toJson<DateTime>(resCheckupDate),
      'resHeight': serializer.toJson<double>(resHeight),
      'resWeight': serializer.toJson<double>(resWeight),
      'resWaist': serializer.toJson<double>(resWaist),
      'resBMI': serializer.toJson<double>(resBMI),
      'resSight': serializer.toJson<String>(resSight),
      'resHearing': serializer.toJson<String>(resHearing),
      'resBloodPressure': serializer.toJson<String>(resBloodPressure),
      'resFastingBloodSuger': serializer.toJson<double>(resFastingBloodSuger),
      'resTotalCholesterol': serializer.toJson<String>(resTotalCholesterol),
    };
  }

  HealthCheck copyWith(
          {int? id,
          String? resOrganizationName,
          DateTime? resCheckupDate,
          double? resHeight,
          double? resWeight,
          double? resWaist,
          double? resBMI,
          String? resSight,
          String? resHearing,
          String? resBloodPressure,
          double? resFastingBloodSuger,
          String? resTotalCholesterol}) =>
      HealthCheck(
        id: id ?? this.id,
        resOrganizationName: resOrganizationName ?? this.resOrganizationName,
        resCheckupDate: resCheckupDate ?? this.resCheckupDate,
        resHeight: resHeight ?? this.resHeight,
        resWeight: resWeight ?? this.resWeight,
        resWaist: resWaist ?? this.resWaist,
        resBMI: resBMI ?? this.resBMI,
        resSight: resSight ?? this.resSight,
        resHearing: resHearing ?? this.resHearing,
        resBloodPressure: resBloodPressure ?? this.resBloodPressure,
        resFastingBloodSuger: resFastingBloodSuger ?? this.resFastingBloodSuger,
        resTotalCholesterol: resTotalCholesterol ?? this.resTotalCholesterol,
      );
  @override
  String toString() {
    return (StringBuffer('HealthCheck(')
          ..write('id: $id, ')
          ..write('resOrganizationName: $resOrganizationName, ')
          ..write('resCheckupDate: $resCheckupDate, ')
          ..write('resHeight: $resHeight, ')
          ..write('resWeight: $resWeight, ')
          ..write('resWaist: $resWaist, ')
          ..write('resBMI: $resBMI, ')
          ..write('resSight: $resSight, ')
          ..write('resHearing: $resHearing, ')
          ..write('resBloodPressure: $resBloodPressure, ')
          ..write('resFastingBloodSuger: $resFastingBloodSuger, ')
          ..write('resTotalCholesterol: $resTotalCholesterol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      resOrganizationName,
      resCheckupDate,
      resHeight,
      resWeight,
      resWaist,
      resBMI,
      resSight,
      resHearing,
      resBloodPressure,
      resFastingBloodSuger,
      resTotalCholesterol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthCheck &&
          other.id == this.id &&
          other.resOrganizationName == this.resOrganizationName &&
          other.resCheckupDate == this.resCheckupDate &&
          other.resHeight == this.resHeight &&
          other.resWeight == this.resWeight &&
          other.resWaist == this.resWaist &&
          other.resBMI == this.resBMI &&
          other.resSight == this.resSight &&
          other.resHearing == this.resHearing &&
          other.resBloodPressure == this.resBloodPressure &&
          other.resFastingBloodSuger == this.resFastingBloodSuger &&
          other.resTotalCholesterol == this.resTotalCholesterol);
}

class HealthChecksCompanion extends UpdateCompanion<HealthCheck> {
  final Value<int> id;
  final Value<String> resOrganizationName;
  final Value<DateTime> resCheckupDate;
  final Value<double> resHeight;
  final Value<double> resWeight;
  final Value<double> resWaist;
  final Value<double> resBMI;
  final Value<String> resSight;
  final Value<String> resHearing;
  final Value<String> resBloodPressure;
  final Value<double> resFastingBloodSuger;
  final Value<String> resTotalCholesterol;
  const HealthChecksCompanion({
    this.id = const Value.absent(),
    this.resOrganizationName = const Value.absent(),
    this.resCheckupDate = const Value.absent(),
    this.resHeight = const Value.absent(),
    this.resWeight = const Value.absent(),
    this.resWaist = const Value.absent(),
    this.resBMI = const Value.absent(),
    this.resSight = const Value.absent(),
    this.resHearing = const Value.absent(),
    this.resBloodPressure = const Value.absent(),
    this.resFastingBloodSuger = const Value.absent(),
    this.resTotalCholesterol = const Value.absent(),
  });
  HealthChecksCompanion.insert({
    this.id = const Value.absent(),
    required String resOrganizationName,
    required DateTime resCheckupDate,
    required double resHeight,
    required double resWeight,
    required double resWaist,
    required double resBMI,
    required String resSight,
    required String resHearing,
    required String resBloodPressure,
    required double resFastingBloodSuger,
    required String resTotalCholesterol,
  })  : resOrganizationName = Value(resOrganizationName),
        resCheckupDate = Value(resCheckupDate),
        resHeight = Value(resHeight),
        resWeight = Value(resWeight),
        resWaist = Value(resWaist),
        resBMI = Value(resBMI),
        resSight = Value(resSight),
        resHearing = Value(resHearing),
        resBloodPressure = Value(resBloodPressure),
        resFastingBloodSuger = Value(resFastingBloodSuger),
        resTotalCholesterol = Value(resTotalCholesterol);
  static Insertable<HealthCheck> custom({
    Expression<int>? id,
    Expression<String>? resOrganizationName,
    Expression<DateTime>? resCheckupDate,
    Expression<double>? resHeight,
    Expression<double>? resWeight,
    Expression<double>? resWaist,
    Expression<double>? resBMI,
    Expression<String>? resSight,
    Expression<String>? resHearing,
    Expression<String>? resBloodPressure,
    Expression<double>? resFastingBloodSuger,
    Expression<String>? resTotalCholesterol,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resOrganizationName != null)
        'res_organization_name': resOrganizationName,
      if (resCheckupDate != null) 'res_checkup_date': resCheckupDate,
      if (resHeight != null) 'res_height': resHeight,
      if (resWeight != null) 'res_weight': resWeight,
      if (resWaist != null) 'res_waist': resWaist,
      if (resBMI != null) 'res_b_m_i': resBMI,
      if (resSight != null) 'res_sight': resSight,
      if (resHearing != null) 'res_hearing': resHearing,
      if (resBloodPressure != null) 'res_blood_pressure': resBloodPressure,
      if (resFastingBloodSuger != null)
        'res_fasting_blood_suger': resFastingBloodSuger,
      if (resTotalCholesterol != null)
        'res_total_cholesterol': resTotalCholesterol,
    });
  }

  HealthChecksCompanion copyWith(
      {Value<int>? id,
      Value<String>? resOrganizationName,
      Value<DateTime>? resCheckupDate,
      Value<double>? resHeight,
      Value<double>? resWeight,
      Value<double>? resWaist,
      Value<double>? resBMI,
      Value<String>? resSight,
      Value<String>? resHearing,
      Value<String>? resBloodPressure,
      Value<double>? resFastingBloodSuger,
      Value<String>? resTotalCholesterol}) {
    return HealthChecksCompanion(
      id: id ?? this.id,
      resOrganizationName: resOrganizationName ?? this.resOrganizationName,
      resCheckupDate: resCheckupDate ?? this.resCheckupDate,
      resHeight: resHeight ?? this.resHeight,
      resWeight: resWeight ?? this.resWeight,
      resWaist: resWaist ?? this.resWaist,
      resBMI: resBMI ?? this.resBMI,
      resSight: resSight ?? this.resSight,
      resHearing: resHearing ?? this.resHearing,
      resBloodPressure: resBloodPressure ?? this.resBloodPressure,
      resFastingBloodSuger: resFastingBloodSuger ?? this.resFastingBloodSuger,
      resTotalCholesterol: resTotalCholesterol ?? this.resTotalCholesterol,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resOrganizationName.present) {
      map['res_organization_name'] =
          Variable<String>(resOrganizationName.value);
    }
    if (resCheckupDate.present) {
      map['res_checkup_date'] = Variable<DateTime>(resCheckupDate.value);
    }
    if (resHeight.present) {
      map['res_height'] = Variable<double>(resHeight.value);
    }
    if (resWeight.present) {
      map['res_weight'] = Variable<double>(resWeight.value);
    }
    if (resWaist.present) {
      map['res_waist'] = Variable<double>(resWaist.value);
    }
    if (resBMI.present) {
      map['res_b_m_i'] = Variable<double>(resBMI.value);
    }
    if (resSight.present) {
      map['res_sight'] = Variable<String>(resSight.value);
    }
    if (resHearing.present) {
      map['res_hearing'] = Variable<String>(resHearing.value);
    }
    if (resBloodPressure.present) {
      map['res_blood_pressure'] = Variable<String>(resBloodPressure.value);
    }
    if (resFastingBloodSuger.present) {
      map['res_fasting_blood_suger'] =
          Variable<double>(resFastingBloodSuger.value);
    }
    if (resTotalCholesterol.present) {
      map['res_total_cholesterol'] =
          Variable<String>(resTotalCholesterol.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthChecksCompanion(')
          ..write('id: $id, ')
          ..write('resOrganizationName: $resOrganizationName, ')
          ..write('resCheckupDate: $resCheckupDate, ')
          ..write('resHeight: $resHeight, ')
          ..write('resWeight: $resWeight, ')
          ..write('resWaist: $resWaist, ')
          ..write('resBMI: $resBMI, ')
          ..write('resSight: $resSight, ')
          ..write('resHearing: $resHearing, ')
          ..write('resBloodPressure: $resBloodPressure, ')
          ..write('resFastingBloodSuger: $resFastingBloodSuger, ')
          ..write('resTotalCholesterol: $resTotalCholesterol')
          ..write(')'))
        .toString();
  }
}

class $DoctorAlarmsTable extends DoctorAlarms
    with TableInfo<$DoctorAlarmsTable, DoctorAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorAlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicineMeta =
      const VerificationMeta('medicine');
  @override
  late final GeneratedColumn<String> medicine = GeneratedColumn<String>(
      'medicine', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomMeta =
      const VerificationMeta('symptom');
  @override
  late final GeneratedColumn<String> symptom = GeneratedColumn<String>(
      'symptom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userName, medicine, symptom, detail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctor_alarms';
  @override
  VerificationContext validateIntegrity(Insertable<DoctorAlarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('medicine')) {
      context.handle(_medicineMeta,
          medicine.isAcceptableOrUnknown(data['medicine']!, _medicineMeta));
    } else if (isInserting) {
      context.missing(_medicineMeta);
    }
    if (data.containsKey('symptom')) {
      context.handle(_symptomMeta,
          symptom.isAcceptableOrUnknown(data['symptom']!, _symptomMeta));
    } else if (isInserting) {
      context.missing(_symptomMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoctorAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      medicine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine'])!,
      symptom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom'])!,
      detail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail'])!,
    );
  }

  @override
  $DoctorAlarmsTable createAlias(String alias) {
    return $DoctorAlarmsTable(attachedDatabase, alias);
  }
}

class DoctorAlarm extends DataClass implements Insertable<DoctorAlarm> {
  final int id;
  final String userName;
  final String medicine;
  final String symptom;
  final String detail;
  const DoctorAlarm(
      {required this.id,
      required this.userName,
      required this.medicine,
      required this.symptom,
      required this.detail});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['medicine'] = Variable<String>(medicine);
    map['symptom'] = Variable<String>(symptom);
    map['detail'] = Variable<String>(detail);
    return map;
  }

  DoctorAlarmsCompanion toCompanion(bool nullToAbsent) {
    return DoctorAlarmsCompanion(
      id: Value(id),
      userName: Value(userName),
      medicine: Value(medicine),
      symptom: Value(symptom),
      detail: Value(detail),
    );
  }

  factory DoctorAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorAlarm(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      medicine: serializer.fromJson<String>(json['medicine']),
      symptom: serializer.fromJson<String>(json['symptom']),
      detail: serializer.fromJson<String>(json['detail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'medicine': serializer.toJson<String>(medicine),
      'symptom': serializer.toJson<String>(symptom),
      'detail': serializer.toJson<String>(detail),
    };
  }

  DoctorAlarm copyWith(
          {int? id,
          String? userName,
          String? medicine,
          String? symptom,
          String? detail}) =>
      DoctorAlarm(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        medicine: medicine ?? this.medicine,
        symptom: symptom ?? this.symptom,
        detail: detail ?? this.detail,
      );
  @override
  String toString() {
    return (StringBuffer('DoctorAlarm(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('medicine: $medicine, ')
          ..write('symptom: $symptom, ')
          ..write('detail: $detail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userName, medicine, symptom, detail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorAlarm &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.medicine == this.medicine &&
          other.symptom == this.symptom &&
          other.detail == this.detail);
}

class DoctorAlarmsCompanion extends UpdateCompanion<DoctorAlarm> {
  final Value<int> id;
  final Value<String> userName;
  final Value<String> medicine;
  final Value<String> symptom;
  final Value<String> detail;
  const DoctorAlarmsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.medicine = const Value.absent(),
    this.symptom = const Value.absent(),
    this.detail = const Value.absent(),
  });
  DoctorAlarmsCompanion.insert({
    this.id = const Value.absent(),
    required String userName,
    required String medicine,
    required String symptom,
    required String detail,
  })  : userName = Value(userName),
        medicine = Value(medicine),
        symptom = Value(symptom),
        detail = Value(detail);
  static Insertable<DoctorAlarm> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<String>? medicine,
    Expression<String>? symptom,
    Expression<String>? detail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (medicine != null) 'medicine': medicine,
      if (symptom != null) 'symptom': symptom,
      if (detail != null) 'detail': detail,
    });
  }

  DoctorAlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userName,
      Value<String>? medicine,
      Value<String>? symptom,
      Value<String>? detail}) {
    return DoctorAlarmsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      medicine: medicine ?? this.medicine,
      symptom: symptom ?? this.symptom,
      detail: detail ?? this.detail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (medicine.present) {
      map['medicine'] = Variable<String>(medicine.value);
    }
    if (symptom.present) {
      map['symptom'] = Variable<String>(symptom.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorAlarmsCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('medicine: $medicine, ')
          ..write('symptom: $symptom, ')
          ..write('detail: $detail')
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
  late final $PatientsTable patients = $PatientsTable(this);
  late final $DoctorsTable doctors = $DoctorsTable(this);
  late final $HealthChecksTable healthChecks = $HealthChecksTable(this);
  late final $DoctorAlarmsTable doctorAlarms = $DoctorAlarmsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        alarms,
        symptoms,
        personalMedicines,
        prescriptions,
        patients,
        doctors,
        healthChecks,
        doctorAlarms
      ];
}
