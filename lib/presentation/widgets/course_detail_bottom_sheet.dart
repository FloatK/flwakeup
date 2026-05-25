import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/vibrate.dart';
import '../../core/utils/week_utils.dart';
import '../../data/models/course.dart';

/// 课程详情底部弹窗。
///
/// 显示课程的教师、地点、时间安排，以及编辑/删除操作。
class CourseDetailBottomSheet extends StatelessWidget {
  final Course course;
  final VoidCallback? onDelete;

  const CourseDetailBottomSheet({
    super.key,
    required this.course,
    this.onDelete,
  });

  /// 显示课程详情底部弹窗。
  static void show(BuildContext context, Course course,
      {VoidCallback? onDelete}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CourseDetailBottomSheet(
        course: course,
        onDelete: onDelete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: scrollController,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Course name
            Text(
              course.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            // Teacher & location
            _buildInfoRow(
              Icons.person_outline,
              '${AppStrings.teacherLabel}: ${course.teacher}',
            ),
            if (course.location != null && course.location!.isNotEmpty)
              _buildInfoRow(
                Icons.location_on_outlined,
                '${AppStrings.locationLabel}: ${course.location}',
              ),
            const Divider(height: 24),
            // Time schedule header
            Text(
              AppStrings.timeSchedule,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            // Time detail entries
            ...course.timeDetails.map(
              (td) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_formatTimeDetail(td)),
              ),
            ),
            const Divider(height: 24),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Vibrate.light();
                      Navigator.pop(context);
                      context.push('/edit/${course.id}');
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(AppStrings.edit),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Vibrate.light();
                      Navigator.pop(context);
                      onDelete?.call();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text(AppStrings.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  String _formatTimeDetail(TimeDetail td) {
    final dayLabel = AppStrings.dayLabel(td.dayOfWeek);
    final endPeriod = td.startPeriod + td.duration - 1;
    final periodRange =
        td.duration > 1 ? '${td.startPeriod}-$endPeriod' : '${td.startPeriod}';
    final modeStr = td.singleOrDouble == 'single'
        ? AppStrings.singleWeek
        : td.singleOrDouble == 'double'
            ? AppStrings.doubleWeek
            : '';
    final weeksStr = WeekUtils.formatWeeks(td.weeks);

    final parts = [
      '$dayLabel ${AppStrings.weekLabel}$periodRange${AppStrings.weekSuffix}',
      weeksStr,
      if (modeStr.isNotEmpty) modeStr,
    ];
    return parts.join(' | ');
  }
}
