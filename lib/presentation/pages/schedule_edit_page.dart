import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/ui_utils.dart';
import '../../core/utils/vibrate.dart';
import '../../data/models/schedule.dart';
import '../providers/schedule_provider.dart';

class ScheduleEditPage extends ConsumerStatefulWidget {
  final Schedule schedule;

  const ScheduleEditPage({super.key, required this.schedule});

  @override
  ConsumerState<ScheduleEditPage> createState() => _ScheduleEditPageState();
}

class _ScheduleEditPageState extends ConsumerState<ScheduleEditPage> {
  late TextEditingController _nameController;
  late int _maxCoursesPerDay;
  late Set<int> _selectedWeekdays;
  late TextEditingController _startDateController;
  late TextEditingController _totalWeeksController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.schedule.name);
    _maxCoursesPerDay = widget.schedule.maxCoursesPerDay;
    _selectedWeekdays = widget.schedule.displayedWeekdays.toSet();
    
    // 从课表自身的字段初始化
    _startDateController = TextEditingController(
      text: widget.schedule.startDate ?? '',
    );
    _totalWeeksController = TextEditingController(
      text: (widget.schedule.totalWeeks ?? 20).toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _totalWeeksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editSchedule),
        actions: [
          TextButton(
            onPressed: () { Vibrate.light(); _save(); },
            child: const Text(AppStrings.save),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // -- Schedule section --
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: AppStrings.scheduleName,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.maxCoursesLabel(_maxCoursesPerDay),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Slider(
            value: _maxCoursesPerDay.toDouble(),
            min: 1,
            max: 20,
            divisions: 19,
            label: '$_maxCoursesPerDay',
            onChanged: (v) => setState(() => _maxCoursesPerDay = v.round()),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.displayedWeekdays,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: List.generate(7, (i) {
              final day = i + 1;
              final selected = _selectedWeekdays.contains(day);
              return FilterChip(
                label: Text(AppStrings.dayLabels[i]),
                selected: selected,
                onSelected: (v) {
                  setState(() {
                    if (v) {
                      _selectedWeekdays.add(day);
                    } else {
                      _selectedWeekdays.remove(day);
                    }
                    if (_selectedWeekdays.isEmpty) {
                      _selectedWeekdays.add(day);
                    }
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            AppStrings.semesterSettingsLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          // -- Semester section (保存到课表自身) --
          TextField(
            controller: _startDateController,
            decoration: const InputDecoration(
              labelText: AppStrings.startDate,
              hintText: 'YYYY-MM-DD',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              final initialDate = _startDateController.text.isNotEmpty
                  ? DateTime.tryParse(_startDateController.text) ?? DateTime.now()
                  : DateTime.now();
              final date = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (date != null) {
                _startDateController.text =
                    date.toIso8601String().substring(0, 10);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _totalWeeksController,
            decoration: const InputDecoration(
              labelText: AppStrings.totalWeeks,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _save() async {
    // Validate schedule fields
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showAppSnackBar(context, AppStrings.enterScheduleName, isError: true);
      return;
    }

    final totalWeeksStr = _totalWeeksController.text.trim();
    if (totalWeeksStr.isEmpty) {
      showAppSnackBar(context, AppStrings.enterTotalWeeks, isError: true);
      return;
    }
    final totalWeeks = int.tryParse(totalWeeksStr);
    if (totalWeeks == null || totalWeeks < 1 || totalWeeks > 30) {
      showAppSnackBar(context, AppStrings.totalWeeksRange, isError: true);
      return;
    }

    final startDateStr = _startDateController.text.trim();
    if (startDateStr.isEmpty) {
      showAppSnackBar(context, AppStrings.selectStartDate, isError: true);
      return;
    }

    // Save schedule with startDate and totalWeeks
    final sortedWeekdays = _selectedWeekdays.toList()..sort();
    final updated = widget.schedule.copyWith(
      name: name,
      maxCoursesPerDay: _maxCoursesPerDay,
      displayedWeekdays: sortedWeekdays,
      startDate: startDateStr,
      totalWeeks: totalWeeks,
    );

    try {
      await ref.read(scheduleRepositoryProvider).updateSchedule(updated);

      ref.invalidate(scheduleListProvider);
      ref.invalidate(currentScheduleProvider);
      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      if (context.mounted) {
        showAppSnackBar(context, '${AppStrings.saveFailed}: $e', isError: true);
      }
    }
  }
}
