import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'database.dart';

Future<void> insertSampleData(AppDatabase db) async {
  const uuid = Uuid();

  final semesterStart = DateTime(2026, 2, 17);
  await db.setSemesterConfig(
    SemesterConfigsCompanion(
      name: const Value<String>('2025-2026 第二学期'),
      startDate: Value<String>(semesterStart.toIso8601String()),
      totalWeeks: const Value<int>(20),
      isActive: const Value<int>(1),
    ),
  );

  await db.insertCourseWithDetails(
    uuid.v4(),
    '高等数学',
    '张教授',
    '教一 301',
    0xFF2196F3,
    [
      TimeDetailsCompanion(
        dayOfWeek: const Value(1),
        startPeriod: const Value(1),
        duration: const Value(2),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16'),
        singleOrDouble: const Value('all'),
      ),
      TimeDetailsCompanion(
        dayOfWeek: const Value(3),
        startPeriod: const Value(3),
        duration: const Value(2),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16'),
        singleOrDouble: const Value('all'),
      ),
    ],
  );

  await db.insertCourseWithDetails(
    uuid.v4(),
    '大学英语',
    '李老师',
    '教二 205',
    0xFF4CAF50,
    [
      TimeDetailsCompanion(
        dayOfWeek: const Value(2),
        startPeriod: const Value(1),
        duration: const Value(2),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16'),
        singleOrDouble: const Value('all'),
      ),
      TimeDetailsCompanion(
        dayOfWeek: const Value(4),
        startPeriod: const Value(1),
        duration: const Value(2),
        weeks: Value('1,3,5,7,9,11,13,15'),
        singleOrDouble: const Value('single'),
      ),
    ],
  );

  await db.insertCourseWithDetails(
    uuid.v4(),
    '数据结构',
    '王教授',
    '教三 102',
    0xFFFF9800,
    [
      TimeDetailsCompanion(
        dayOfWeek: const Value(1),
        startPeriod: const Value(5),
        duration: const Value(2),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12'),
        singleOrDouble: const Value('all'),
      ),
      TimeDetailsCompanion(
        dayOfWeek: const Value(5),
        startPeriod: const Value(3),
        duration: const Value(3),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12'),
        singleOrDouble: const Value('all'),
      ),
    ],
  );

  await db.insertCourseWithDetails(
    uuid.v4(),
    '体育',
    '赵教练',
    '体育馆',
    0xFFE91E63,
    [
      TimeDetailsCompanion(
        dayOfWeek: const Value(3),
        startPeriod: const Value(7),
        duration: const Value(2),
        weeks: const Value('2,4,6,8,10,12,14,16'),
        singleOrDouble: const Value('double'),
      ),
    ],
  );

  await db.insertCourseWithDetails(
    uuid.v4(),
    '马克思主义原理',
    '陈教授',
    '教一 201',
    0xFF9C27B0,
    [
      TimeDetailsCompanion(
        dayOfWeek: const Value(2),
        startPeriod: const Value(5),
        duration: const Value(2),
        weeks: const Value('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16'),
        singleOrDouble: const Value('all'),
      ),
    ],
  );
}
