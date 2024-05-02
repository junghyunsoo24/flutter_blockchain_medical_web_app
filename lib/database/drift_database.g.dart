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
  @override
  List<GeneratedColumn> get $columns =>
      [id, medicationName, dosage, time, isEnabled];
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
  const Alarm(
      {required this.id,
      required this.medicationName,
      required this.dosage,
      required this.time,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['medication_name'] = Variable<String>(medicationName);
    map['dosage'] = Variable<String>(dosage);
    map['time'] = Variable<DateTime>(time);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      medicationName: Value(medicationName),
      dosage: Value(dosage),
      time: Value(time),
      isEnabled: Value(isEnabled),
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
    };
  }

  Alarm copyWith(
          {int? id,
          String? medicationName,
          String? dosage,
          DateTime? time,
          bool? isEnabled}) =>
      Alarm(
        id: id ?? this.id,
        medicationName: medicationName ?? this.medicationName,
        dosage: dosage ?? this.dosage,
        time: time ?? this.time,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, medicationName, dosage, time, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.medicationName == this.medicationName &&
          other.dosage == this.dosage &&
          other.time == this.time &&
          other.isEnabled == this.isEnabled);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<String> medicationName;
  final Value<String> dosage;
  final Value<DateTime> time;
  final Value<bool> isEnabled;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.time = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required String medicationName,
    required String dosage,
    required DateTime time,
    this.isEnabled = const Value.absent(),
  })  : medicationName = Value(medicationName),
        dosage = Value(dosage),
        time = Value(time);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<String>? medicationName,
    Expression<String>? dosage,
    Expression<DateTime>? time,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicationName != null) 'medication_name': medicationName,
      if (dosage != null) 'dosage': dosage,
      if (time != null) 'time': time,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  AlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String>? medicationName,
      Value<String>? dosage,
      Value<DateTime>? time,
      Value<bool>? isEnabled}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
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

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $PersonalMedicinesTable personalMedicines =
      $PersonalMedicinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, symptoms, personalMedicines];
}
