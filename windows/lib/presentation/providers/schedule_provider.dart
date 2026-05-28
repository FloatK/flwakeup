import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/schedule.dart';
import '../../domain/repositories/schedule_repository.dart';

part 'schedule_provider.g.dart';

const _kLastScheduleIdKey = 'last_schedule_id';

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) {
  throw UnimplementedError('Must be overridden with database instance');
}

@Riverpod(keepAlive: true)
class CurrentSchedule extends _$CurrentSchedule {
  @override
  Future<Schedule> build() async {
    final repo = ref.watch(scheduleRepositoryProvider);

    // 优先加载上次使用的课表
    final prefs = await SharedPreferences.getInstance();
    final lastId = prefs.getString(_kLastScheduleIdKey);

    if (lastId != null) {
      final schedules = await repo.getAllSchedules();
      final last = schedules.where((s) => s.id == lastId).firstOrNull;
      if (last != null) return last;
    }

    // 回退到默认课表
    final defaultSched = await repo.getDefaultSchedule();
    return defaultSched!;
  }

  Future<void> switchSchedule(Schedule schedule) async {
    state = AsyncData(schedule);
    // 持久化最后使用的课表 ID
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastScheduleIdKey, schedule.id);
  }

  Future<void> refresh() async {
    final repo = ref.read(scheduleRepositoryProvider);
    final sched = await repo.getDefaultSchedule();
    if (sched != null) {
      state = AsyncData(sched);
    }
  }

  Future<void> updateSchedule(Schedule schedule) async {
    final repo = ref.read(scheduleRepositoryProvider);
    await repo.updateSchedule(schedule);
    state = AsyncData(schedule);
  }
}

@Riverpod(keepAlive: true)
Future<List<Schedule>> scheduleList(ScheduleListRef ref) async {
  final repo = ref.watch(scheduleRepositoryProvider);
  return repo.getAllSchedules();
}
