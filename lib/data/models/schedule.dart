import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required String id,
    required String name,
    @Default(false) bool isDefault,
    required DateTime createdAt,
    @Default([1, 2, 3, 4, 5]) List<int> displayedWeekdays,
    @Default(12) int maxCoursesPerDay,
    // 新增：每个课表独立的开学日期和总周数
    String? startDate,
    @Default(20) int totalWeeks,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
