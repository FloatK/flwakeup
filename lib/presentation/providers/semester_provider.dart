import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/database.dart';

part 'semester_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  throw UnimplementedError('Must be overridden with database instance');
}

@riverpod
class ActiveSemester extends _$ActiveSemester {
  @override
  Future<SemesterConfigData?> build() async {
    final db = ref.watch(databaseProvider);
    return db.getActiveSemester();
  }

  Future<void> setConfig(SemesterConfigsCompanion config) async {
    final db = ref.read(databaseProvider);
    await db.setSemesterConfig(config);
    ref.invalidateSelf();
  }
}

@riverpod
int currentWeek(CurrentWeekRef ref) {
  final semesterAsync = ref.watch(activeSemesterProvider);
  return semesterAsync.when(
    data: (semester) {
      if (semester == null) return 1;
      final startDate = DateTime.parse(semester.startDate);
      final now = DateTime.now();
      final diff = now.difference(startDate).inDays;
      if (diff < 0) return 1;
      final week = (diff / 7).ceil() + 1;
      return week.clamp(1, semester.totalWeeks);
    },
    loading: () => 1,
    error: (_, _) => 1,
  );
}
