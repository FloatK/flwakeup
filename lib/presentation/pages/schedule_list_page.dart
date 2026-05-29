import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/ui_utils.dart';
import '../../core/utils/vibrate.dart';
import '../../data/models/schedule.dart';
import '../../l10n/app_localizations.dart';
import '../providers/schedule_provider.dart';
import 'schedule_edit_page.dart';

class ScheduleListPage extends ConsumerWidget {
  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final schedulesAsync = ref.watch(scheduleListProvider);
    final currentAsync = ref.watch(currentScheduleProvider);
    final currentId = currentAsync.valueOrNull?.id;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectSchedule)),
      body: schedulesAsync.when(
        data: (schedules) {
          if (schedules.isEmpty) {
            return Center(child: Text(l10n.noSchedule));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: schedules.length + 1, // +1 for create button at bottom
            itemBuilder: (context, index) {
              if (index == schedules.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: OutlinedButton.icon(
                    onPressed: () { Vibrate.light(); _createSchedule(context, ref); },
                    icon: const Icon(Icons.add),
                    label: Text(l10n.createSchedule),
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
                          onPressed: () { Vibrate.light(); _applySchedule(context, ref, s); },
                          child: Text(l10n.apply),
                        ),
                      if (isActive)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.check, size: 20, color: Colors.green),
                        ),
                      TextButton(
                        onPressed: () {
                          Vibrate.light();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ScheduleEditPage(schedule: s),
                            ),
                          );
                        },
                        child: Text(l10n.edit),
                      ),
                      TextButton(
                          onPressed: () { Vibrate.light(); _confirmDelete(context, ref, s); },
                        child: Text(l10n.delete,
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
        error: (e, _) => Center(child: Text('${l10n.loadFailed}: $e')),
      ),
    );
  }

  void _applySchedule(BuildContext context, WidgetRef ref, Schedule s) {
    ref.read(currentScheduleProvider.notifier).switchSchedule(s);
    final l10n = AppLocalizations.of(context)!;
    showAppSnackBar(context, '${l10n.scheduleSwitchedTo}「${s.name}」');
    context.pop();
  }

  Future<void> _createSchedule(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.newSchedule),
        content: TextField(
          controller: nameCtrl,
          decoration: InputDecoration(hintText: l10n.scheduleName),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () { Vibrate.light(); Navigator.pop(ctx); },
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () { Vibrate.light(); Navigator.pop(ctx, nameCtrl.text.trim()); },
            child: Text(l10n.confirm),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmDeleteTitle),
        content: Text('${l10n.confirmDeleteMessage}「${s.name}」吗？'),
        actions: [
          TextButton(
            onPressed: () { Vibrate.light(); Navigator.pop(ctx); },
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Vibrate.light();
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
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
