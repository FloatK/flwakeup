// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _teacherMeta = const VerificationMeta(
    'teacher',
  );
  @override
  late final GeneratedColumn<String> teacher = GeneratedColumn<String>(
    'teacher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, teacher, location, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Course> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('teacher')) {
      context.handle(
        _teacherMeta,
        teacher.isAcceptableOrUnknown(data['teacher']!, _teacherMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      teacher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final String id;
  final String name;
  final String teacher;
  final String? location;
  final int color;
  const Course({
    required this.id,
    required this.name,
    required this.teacher,
    this.location,
    required this.color,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['teacher'] = Variable<String>(teacher);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['color'] = Variable<int>(color);
    return map;
  }

  factory Course.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      teacher: serializer.fromJson<String>(json['teacher']),
      location: serializer.fromJson<String?>(json['location']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'teacher': serializer.toJson<String>(teacher),
      'location': serializer.toJson<String?>(location),
      'color': serializer.toJson<int>(color),
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? teacher,
    Value<String?> location = const Value.absent(),
    int? color,
  }) => Course(
    id: id ?? this.id,
    name: name ?? this.name,
    teacher: teacher ?? this.teacher,
    location: location.present ? location.value : this.location,
    color: color ?? this.color,
  );
  Course copyWithCompanion(CoursesCompanion data) {
    return Course(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      teacher: data.teacher.present ? data.teacher.value : this.teacher,
      location: data.location.present ? data.location.value : this.location,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('teacher: $teacher, ')
          ..write('location: $location, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, teacher, location, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.name == this.name &&
          other.teacher == this.teacher &&
          other.location == this.location &&
          other.color == this.color);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> teacher;
  final Value<String?> location;
  final Value<int> color;
  final Value<int> rowid;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.teacher = const Value.absent(),
    this.location = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    required String id,
    required String name,
    required String teacher,
    this.location = const Value.absent(),
    required int color,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       teacher = Value(teacher),
       color = Value(color);
  static Insertable<Course> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? teacher,
    Expression<String>? location,
    Expression<int>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (teacher != null) 'teacher': teacher,
      if (location != null) 'location': location,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? teacher,
    Value<String?>? location,
    Value<int>? color,
    Value<int>? rowid,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      location: location ?? this.location,
      color: color ?? this.color,
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
    if (teacher.present) {
      map['teacher'] = Variable<String>(teacher.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('teacher: $teacher, ')
          ..write('location: $location, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeDetailsTable extends TimeDetails
    with TableInfo<$TimeDetailsTable, TimeDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startPeriodMeta = const VerificationMeta(
    'startPeriod',
  );
  @override
  late final GeneratedColumn<int> startPeriod = GeneratedColumn<int>(
    'start_period',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<String> weeks = GeneratedColumn<String>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _singleOrDoubleMeta = const VerificationMeta(
    'singleOrDouble',
  );
  @override
  late final GeneratedColumn<String> singleOrDouble = GeneratedColumn<String>(
    'single_or_double',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    courseId,
    dayOfWeek,
    startPeriod,
    duration,
    weeks,
    singleOrDouble,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('start_period')) {
      context.handle(
        _startPeriodMeta,
        startPeriod.isAcceptableOrUnknown(
          data['start_period']!,
          _startPeriodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startPeriodMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    } else if (isInserting) {
      context.missing(_weeksMeta);
    }
    if (data.containsKey('single_or_double')) {
      context.handle(
        _singleOrDoubleMeta,
        singleOrDouble.isAcceptableOrUnknown(
          data['single_or_double']!,
          _singleOrDoubleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_singleOrDoubleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeDetail(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      startPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_period'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weeks'],
      )!,
      singleOrDouble: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}single_or_double'],
      )!,
    );
  }

  @override
  $TimeDetailsTable createAlias(String alias) {
    return $TimeDetailsTable(attachedDatabase, alias);
  }
}

class TimeDetail extends DataClass implements Insertable<TimeDetail> {
  final int id;
  final String courseId;
  final int dayOfWeek;
  final int startPeriod;
  final int duration;
  final String weeks;
  final String singleOrDouble;
  const TimeDetail({
    required this.id,
    required this.courseId,
    required this.dayOfWeek,
    required this.startPeriod,
    required this.duration,
    required this.weeks,
    required this.singleOrDouble,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_id'] = Variable<String>(courseId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['start_period'] = Variable<int>(startPeriod);
    map['duration'] = Variable<int>(duration);
    map['weeks'] = Variable<String>(weeks);
    map['single_or_double'] = Variable<String>(singleOrDouble);
    return map;
  }

  factory TimeDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeDetail(
      id: serializer.fromJson<int>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      startPeriod: serializer.fromJson<int>(json['startPeriod']),
      duration: serializer.fromJson<int>(json['duration']),
      weeks: serializer.fromJson<String>(json['weeks']),
      singleOrDouble: serializer.fromJson<String>(json['singleOrDouble']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseId': serializer.toJson<String>(courseId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'startPeriod': serializer.toJson<int>(startPeriod),
      'duration': serializer.toJson<int>(duration),
      'weeks': serializer.toJson<String>(weeks),
      'singleOrDouble': serializer.toJson<String>(singleOrDouble),
    };
  }

  TimeDetail copyWith({
    int? id,
    String? courseId,
    int? dayOfWeek,
    int? startPeriod,
    int? duration,
    String? weeks,
    String? singleOrDouble,
  }) => TimeDetail(
    id: id ?? this.id,
    courseId: courseId ?? this.courseId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startPeriod: startPeriod ?? this.startPeriod,
    duration: duration ?? this.duration,
    weeks: weeks ?? this.weeks,
    singleOrDouble: singleOrDouble ?? this.singleOrDouble,
  );
  TimeDetail copyWithCompanion(TimeDetailsCompanion data) {
    return TimeDetail(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      startPeriod: data.startPeriod.present
          ? data.startPeriod.value
          : this.startPeriod,
      duration: data.duration.present ? data.duration.value : this.duration,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
      singleOrDouble: data.singleOrDouble.present
          ? data.singleOrDouble.value
          : this.singleOrDouble,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeDetail(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startPeriod: $startPeriod, ')
          ..write('duration: $duration, ')
          ..write('weeks: $weeks, ')
          ..write('singleOrDouble: $singleOrDouble')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    courseId,
    dayOfWeek,
    startPeriod,
    duration,
    weeks,
    singleOrDouble,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeDetail &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.startPeriod == this.startPeriod &&
          other.duration == this.duration &&
          other.weeks == this.weeks &&
          other.singleOrDouble == this.singleOrDouble);
}

class TimeDetailsCompanion extends UpdateCompanion<TimeDetail> {
  final Value<int> id;
  final Value<String> courseId;
  final Value<int> dayOfWeek;
  final Value<int> startPeriod;
  final Value<int> duration;
  final Value<String> weeks;
  final Value<String> singleOrDouble;
  const TimeDetailsCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.startPeriod = const Value.absent(),
    this.duration = const Value.absent(),
    this.weeks = const Value.absent(),
    this.singleOrDouble = const Value.absent(),
  });
  TimeDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String courseId,
    required int dayOfWeek,
    required int startPeriod,
    required int duration,
    required String weeks,
    required String singleOrDouble,
  }) : courseId = Value(courseId),
       dayOfWeek = Value(dayOfWeek),
       startPeriod = Value(startPeriod),
       duration = Value(duration),
       weeks = Value(weeks),
       singleOrDouble = Value(singleOrDouble);
  static Insertable<TimeDetail> custom({
    Expression<int>? id,
    Expression<String>? courseId,
    Expression<int>? dayOfWeek,
    Expression<int>? startPeriod,
    Expression<int>? duration,
    Expression<String>? weeks,
    Expression<String>? singleOrDouble,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (startPeriod != null) 'start_period': startPeriod,
      if (duration != null) 'duration': duration,
      if (weeks != null) 'weeks': weeks,
      if (singleOrDouble != null) 'single_or_double': singleOrDouble,
    });
  }

  TimeDetailsCompanion copyWith({
    Value<int>? id,
    Value<String>? courseId,
    Value<int>? dayOfWeek,
    Value<int>? startPeriod,
    Value<int>? duration,
    Value<String>? weeks,
    Value<String>? singleOrDouble,
  }) {
    return TimeDetailsCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startPeriod: startPeriod ?? this.startPeriod,
      duration: duration ?? this.duration,
      weeks: weeks ?? this.weeks,
      singleOrDouble: singleOrDouble ?? this.singleOrDouble,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (startPeriod.present) {
      map['start_period'] = Variable<int>(startPeriod.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (weeks.present) {
      map['weeks'] = Variable<String>(weeks.value);
    }
    if (singleOrDouble.present) {
      map['single_or_double'] = Variable<String>(singleOrDouble.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeDetailsCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startPeriod: $startPeriod, ')
          ..write('duration: $duration, ')
          ..write('weeks: $weeks, ')
          ..write('singleOrDouble: $singleOrDouble')
          ..write(')'))
        .toString();
  }
}

class $SemesterConfigsTable extends SemesterConfigs
    with TableInfo<$SemesterConfigsTable, SemesterConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemesterConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalWeeksMeta = const VerificationMeta(
    'totalWeeks',
  );
  @override
  late final GeneratedColumn<int> totalWeeks = GeneratedColumn<int>(
    'total_weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    startDate,
    totalWeeks,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semester_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SemesterConfig> instance, {
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
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('total_weeks')) {
      context.handle(
        _totalWeeksMeta,
        totalWeeks.isAcceptableOrUnknown(data['total_weeks']!, _totalWeeksMeta),
      );
    } else if (isInserting) {
      context.missing(_totalWeeksMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SemesterConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemesterConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      totalWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_weeks'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SemesterConfigsTable createAlias(String alias) {
    return $SemesterConfigsTable(attachedDatabase, alias);
  }
}

class SemesterConfig extends DataClass implements Insertable<SemesterConfig> {
  final int id;
  final String name;
  final String startDate;
  final int totalWeeks;
  final int isActive;
  const SemesterConfig({
    required this.id,
    required this.name,
    required this.startDate,
    required this.totalWeeks,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<String>(startDate);
    map['total_weeks'] = Variable<int>(totalWeeks);
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  factory SemesterConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemesterConfig(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<String>(json['startDate']),
      totalWeeks: serializer.fromJson<int>(json['totalWeeks']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<String>(startDate),
      'totalWeeks': serializer.toJson<int>(totalWeeks),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  SemesterConfig copyWith({
    int? id,
    String? name,
    String? startDate,
    int? totalWeeks,
    int? isActive,
  }) => SemesterConfig(
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    totalWeeks: totalWeeks ?? this.totalWeeks,
    isActive: isActive ?? this.isActive,
  );
  SemesterConfig copyWithCompanion(SemesterConfigsCompanion data) {
    return SemesterConfig(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      totalWeeks: data.totalWeeks.present
          ? data.totalWeeks.value
          : this.totalWeeks,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemesterConfig(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('totalWeeks: $totalWeeks, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startDate, totalWeeks, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemesterConfig &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.totalWeeks == this.totalWeeks &&
          other.isActive == this.isActive);
}

class SemesterConfigsCompanion extends UpdateCompanion<SemesterConfig> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> startDate;
  final Value<int> totalWeeks;
  final Value<int> isActive;
  const SemesterConfigsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.totalWeeks = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SemesterConfigsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String startDate,
    required int totalWeeks,
    required int isActive,
  }) : name = Value(name),
       startDate = Value(startDate),
       totalWeeks = Value(totalWeeks),
       isActive = Value(isActive);
  static Insertable<SemesterConfig> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? startDate,
    Expression<int>? totalWeeks,
    Expression<int>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (totalWeeks != null) 'total_weeks': totalWeeks,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SemesterConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? startDate,
    Value<int>? totalWeeks,
    Value<int>? isActive,
  }) {
    return SemesterConfigsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      totalWeeks: totalWeeks ?? this.totalWeeks,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (totalWeeks.present) {
      map['total_weeks'] = Variable<int>(totalWeeks.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterConfigsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('totalWeeks: $totalWeeks, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $TimeDetailsTable timeDetails = $TimeDetailsTable(this);
  late final $SemesterConfigsTable semesterConfigs = $SemesterConfigsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    courses,
    timeDetails,
    semesterConfigs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('time_details', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CoursesTableCreateCompanionBuilder =
    CoursesCompanion Function({
      required String id,
      required String name,
      required String teacher,
      Value<String?> location,
      required int color,
      Value<int> rowid,
    });
typedef $$CoursesTableUpdateCompanionBuilder =
    CoursesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> teacher,
      Value<String?> location,
      Value<int> color,
      Value<int> rowid,
    });

final class $$CoursesTableReferences
    extends BaseReferences<_$AppDatabase, $CoursesTable, Course> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TimeDetailsTable, List<TimeDetail>>
  _timeDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeDetails,
    aliasName: $_aliasNameGenerator(db.courses.id, db.timeDetails.courseId),
  );

  $$TimeDetailsTableProcessedTableManager get timeDetailsRefs {
    final manager = $$TimeDetailsTableTableManager(
      $_db,
      $_db.timeDetails,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
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

  ColumnFilters<String> get teacher => $composableBuilder(
    column: $table.teacher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> timeDetailsRefs(
    Expression<bool> Function($$TimeDetailsTableFilterComposer f) f,
  ) {
    final $$TimeDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeDetails,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeDetailsTableFilterComposer(
            $db: $db,
            $table: $db.timeDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
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

  ColumnOrderings<String> get teacher => $composableBuilder(
    column: $table.teacher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
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

  GeneratedColumn<String> get teacher =>
      $composableBuilder(column: $table.teacher, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> timeDetailsRefs<T extends Object>(
    Expression<T> Function($$TimeDetailsTableAnnotationComposer a) f,
  ) {
    final $$TimeDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeDetails,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.timeDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursesTable,
          Course,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (Course, $$CoursesTableReferences),
          Course,
          PrefetchHooks Function({bool timeDetailsRefs})
        > {
  $$CoursesTableTableManager(_$AppDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> teacher = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                name: name,
                teacher: teacher,
                location: location,
                color: color,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String teacher,
                Value<String?> location = const Value.absent(),
                required int color,
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                name: name,
                teacher: teacher,
                location: location,
                color: color,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoursesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({timeDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (timeDetailsRefs) db.timeDetails],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (timeDetailsRefs)
                    await $_getPrefetchedData<
                      Course,
                      $CoursesTable,
                      TimeDetail
                    >(
                      currentTable: table,
                      referencedTable: $$CoursesTableReferences
                          ._timeDetailsRefsTable(db),
                      managerFromTypedResult: (p0) => $$CoursesTableReferences(
                        db,
                        table,
                        p0,
                      ).timeDetailsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.courseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursesTable,
      Course,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (Course, $$CoursesTableReferences),
      Course,
      PrefetchHooks Function({bool timeDetailsRefs})
    >;
typedef $$TimeDetailsTableCreateCompanionBuilder =
    TimeDetailsCompanion Function({
      Value<int> id,
      required String courseId,
      required int dayOfWeek,
      required int startPeriod,
      required int duration,
      required String weeks,
      required String singleOrDouble,
    });
typedef $$TimeDetailsTableUpdateCompanionBuilder =
    TimeDetailsCompanion Function({
      Value<int> id,
      Value<String> courseId,
      Value<int> dayOfWeek,
      Value<int> startPeriod,
      Value<int> duration,
      Value<String> weeks,
      Value<String> singleOrDouble,
    });

final class $$TimeDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $TimeDetailsTable, TimeDetail> {
  $$TimeDetailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _courseIdTable(_$AppDatabase db) =>
      db.courses.createAlias(
        $_aliasNameGenerator(db.timeDetails.courseId, db.courses.id),
      );

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimeDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $TimeDetailsTable> {
  $$TimeDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startPeriod => $composableBuilder(
    column: $table.startPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get singleOrDouble => $composableBuilder(
    column: $table.singleOrDouble,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeDetailsTable> {
  $$TimeDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startPeriod => $composableBuilder(
    column: $table.startPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get singleOrDouble => $composableBuilder(
    column: $table.singleOrDouble,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeDetailsTable> {
  $$TimeDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get startPeriod => $composableBuilder(
    column: $table.startPeriod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  GeneratedColumn<String> get singleOrDouble => $composableBuilder(
    column: $table.singleOrDouble,
    builder: (column) => column,
  );

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeDetailsTable,
          TimeDetail,
          $$TimeDetailsTableFilterComposer,
          $$TimeDetailsTableOrderingComposer,
          $$TimeDetailsTableAnnotationComposer,
          $$TimeDetailsTableCreateCompanionBuilder,
          $$TimeDetailsTableUpdateCompanionBuilder,
          (TimeDetail, $$TimeDetailsTableReferences),
          TimeDetail,
          PrefetchHooks Function({bool courseId})
        > {
  $$TimeDetailsTableTableManager(_$AppDatabase db, $TimeDetailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<int> startPeriod = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<String> weeks = const Value.absent(),
                Value<String> singleOrDouble = const Value.absent(),
              }) => TimeDetailsCompanion(
                id: id,
                courseId: courseId,
                dayOfWeek: dayOfWeek,
                startPeriod: startPeriod,
                duration: duration,
                weeks: weeks,
                singleOrDouble: singleOrDouble,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String courseId,
                required int dayOfWeek,
                required int startPeriod,
                required int duration,
                required String weeks,
                required String singleOrDouble,
              }) => TimeDetailsCompanion.insert(
                id: id,
                courseId: courseId,
                dayOfWeek: dayOfWeek,
                startPeriod: startPeriod,
                duration: duration,
                weeks: weeks,
                singleOrDouble: singleOrDouble,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false}) {
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
                    if (courseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.courseId,
                                referencedTable: $$TimeDetailsTableReferences
                                    ._courseIdTable(db),
                                referencedColumn: $$TimeDetailsTableReferences
                                    ._courseIdTable(db)
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

typedef $$TimeDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeDetailsTable,
      TimeDetail,
      $$TimeDetailsTableFilterComposer,
      $$TimeDetailsTableOrderingComposer,
      $$TimeDetailsTableAnnotationComposer,
      $$TimeDetailsTableCreateCompanionBuilder,
      $$TimeDetailsTableUpdateCompanionBuilder,
      (TimeDetail, $$TimeDetailsTableReferences),
      TimeDetail,
      PrefetchHooks Function({bool courseId})
    >;
typedef $$SemesterConfigsTableCreateCompanionBuilder =
    SemesterConfigsCompanion Function({
      Value<int> id,
      required String name,
      required String startDate,
      required int totalWeeks,
      required int isActive,
    });
typedef $$SemesterConfigsTableUpdateCompanionBuilder =
    SemesterConfigsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> startDate,
      Value<int> totalWeeks,
      Value<int> isActive,
    });

class $$SemesterConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $SemesterConfigsTable> {
  $$SemesterConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalWeeks => $composableBuilder(
    column: $table.totalWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SemesterConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $SemesterConfigsTable> {
  $$SemesterConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalWeeks => $composableBuilder(
    column: $table.totalWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SemesterConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemesterConfigsTable> {
  $$SemesterConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get totalWeeks => $composableBuilder(
    column: $table.totalWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$SemesterConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemesterConfigsTable,
          SemesterConfig,
          $$SemesterConfigsTableFilterComposer,
          $$SemesterConfigsTableOrderingComposer,
          $$SemesterConfigsTableAnnotationComposer,
          $$SemesterConfigsTableCreateCompanionBuilder,
          $$SemesterConfigsTableUpdateCompanionBuilder,
          (
            SemesterConfig,
            BaseReferences<
              _$AppDatabase,
              $SemesterConfigsTable,
              SemesterConfig
            >,
          ),
          SemesterConfig,
          PrefetchHooks Function()
        > {
  $$SemesterConfigsTableTableManager(
    _$AppDatabase db,
    $SemesterConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemesterConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemesterConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemesterConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<int> totalWeeks = const Value.absent(),
                Value<int> isActive = const Value.absent(),
              }) => SemesterConfigsCompanion(
                id: id,
                name: name,
                startDate: startDate,
                totalWeeks: totalWeeks,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String startDate,
                required int totalWeeks,
                required int isActive,
              }) => SemesterConfigsCompanion.insert(
                id: id,
                name: name,
                startDate: startDate,
                totalWeeks: totalWeeks,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SemesterConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemesterConfigsTable,
      SemesterConfig,
      $$SemesterConfigsTableFilterComposer,
      $$SemesterConfigsTableOrderingComposer,
      $$SemesterConfigsTableAnnotationComposer,
      $$SemesterConfigsTableCreateCompanionBuilder,
      $$SemesterConfigsTableUpdateCompanionBuilder,
      (
        SemesterConfig,
        BaseReferences<_$AppDatabase, $SemesterConfigsTable, SemesterConfig>,
      ),
      SemesterConfig,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$TimeDetailsTableTableManager get timeDetails =>
      $$TimeDetailsTableTableManager(_db, _db.timeDetails);
  $$SemesterConfigsTableTableManager get semesterConfigs =>
      $$SemesterConfigsTableTableManager(_db, _db.semesterConfigs);
}
