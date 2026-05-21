import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/ui_utils.dart';
import '../../data/models/schedule.dart';
import '../providers/schedule_provider.dart';
import 'schedule_edit_page.dart';

class ScheduleListPage extends ConsumerWidget {
  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(scheduleListProvider);
    final currentAsync = ref.watch(currentScheduleProvider);
    final currentId = currentAsync.valueOrNull?.id;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.selectSchedule)),
      body: schedulesAsync.when(
        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(child: Text(AppStrings.noSchedule));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: schedules.length + 1, // +1 for create button at bottom
            itemBuilder: (context, index) {
              if (index == schedules.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: OutlinedButton.icon(
                    onPressed: () => _createSchedule(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text(AppStrings.createSchedule),
                  ),
                );
              }
              final s = schedules[index];
              final isActive = s.id == currentId;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      if (!isActive)
                        TextButton(
                          onPressed: () => _applySchedule(context, ref, s),
                          child: const Text(AppStrings.apply),
                        ),
                      if (isActive)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.check, size: 20, color: Colors.green),
                        ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ScheduleEditPage(schedule: s),
                            ),
                          );
                        },
                        child: const Text(AppStrings.edit),
                      ),
                      TextButton(
                        onPressed: () => _confirmDelete(context, ref, s),
                        child: Text(AppStrings.delete,
                            style: const TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${AppStrings.loadFailed}: $e')),
      ),
    );
  }

  void _applySchedule(BuildContext context, WidgetRef ref, Schedule s) {
    ref.read(currentScheduleProvider.notifier).switchSchedule(s);
    showAppSnackBar(context, '${AppStrings.scheduleSwitchedTo}「${s.name}」');
    context.pop();
  }

  Future<void> _createSchedule(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.newSchedule),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(hintText: AppStrings.scheduleName),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, nameCtrl.text.trim()),
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );
    if (result == null || result.isEmpty) return;
    final newSchedule = Schedule(
      id: const Uuid().v4(),
      name: result,
      createdAt: DateTime.now(),
    );
    await ref.read(scheduleRepositoryProvider).createSchedule(newSchedule);
    ref.invalidate(scheduleListProvider);
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Schedule s) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.confirmDeleteTitle),
        content: Text('${AppStrings.confirmDeleteMessage}「${s.name}」吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(scheduleRepositoryProvider).deleteSchedule(s.id);
                ref.invalidate(scheduleListProvider);
                ref.invalidate(currentScheduleProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              } catch (e) {
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  showAppSnackBar(context, '$e', isError: true);
                }
              }
            },
            child: Text(AppStrings.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
