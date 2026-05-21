import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/export_utils.dart';
import '../../core/utils/ui_utils.dart';
import '../../data/models/course.dart';
import '../utils/import_helper.dart';

/// 课表导出对话框。
class ExportDialog extends StatelessWidget {
  final List<Course> courses;

  const ExportDialog({super.key, required this.courses});

  /// 显示导出对话框。
  static void show(BuildContext context, List<Course> courses) {
    if (courses.isEmpty) return;
    showDialog(
      context: context,
      builder: (_) => ExportDialog(courses: courses),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = ExportUtils.compactEncode(courses);

    return AlertDialog(
      title: const Text(AppStrings.shareSchedule),
      content: const Text(AppStrings.chooseExportMethod),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            final copyText = '将该条消息复制，点击从文本导入即可导入课表。\n「$compact」';
            Clipboard.setData(ClipboardData(text: copyText));
            showAppSnackBar(
                context, AppStrings.copiedMessage(compact.length));
          },
          child: const Text(AppStrings.copyCompactCode),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            try {
              final dir = await getTemporaryDirectory();
              final file = File(
                  '${dir.path}/fl${DateTime.now().microsecondsSinceEpoch}.txt');
              final fileText =
                  '将该条消息复制，点击从文本导入即可导入课表。\n「$compact」';
              await file.writeAsString(fileText);
              await Share.shareXFiles(
                [XFile(file.path)],
                text: '课表数据',
              );
            } catch (e) {
              if (context.mounted) {
                showAppSnackBar(context, '${AppStrings.shareFailed}: $e',
                    isError: true);
              }
            }
          },
          child: const Text(AppStrings.shareFile),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
      ],
    );
  }
}

/// 从文本导入对话框。
class ImportFromTextDialog extends ConsumerStatefulWidget {
  const ImportFromTextDialog({super.key});

  /// 显示从文本导入对话框。
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const ImportFromTextDialog(),
    );
  }

  @override
  ConsumerState<ImportFromTextDialog> createState() =>
      _ImportFromTextDialogState();
}

class _ImportFromTextDialogState extends ConsumerState<ImportFromTextDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.importFromText),
      content: TextField(
        controller: _controller,
        maxLines: 8,
        decoration: const InputDecoration(
          hintText: AppStrings.pasteCompactHint,
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final clipboardData =
                await Clipboard.getData(Clipboard.kTextPlain);
            if (clipboardData == null || clipboardData.text == null) return;
            _controller.text = clipboardData.text!.trim();
          },
          child: const Text(AppStrings.pasteFromClipboard),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () => _parseAndImport(context),
          child: const Text(AppStrings.parse),
        ),
      ],
    );
  }

  void _parseAndImport(BuildContext context) {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    // Extract compact code from 「…」
    final match = RegExp(r'「(.+?)」').firstMatch(text);
    if (match != null) text = match.group(1)!;

    List<Course> courses;
    try {
      final uuid = const Uuid();
      if (ExportUtils.isCompactFormat(text)) {
        courses = ExportUtils.compactDecode(text);
      } else if (ExportUtils.isValidScheduleJson(text)) {
        courses = ExportUtils.importFromJson(text);
      } else {
        showAppSnackBar(context, AppStrings.invalidFormat, isError: true);
        return;
      }
      // Assign fresh UUIDs to avoid UNIQUE constraint conflicts
      courses = courses.map((c) => c.copyWith(id: uuid.v4())).toList();
    } catch (e) {
      showAppSnackBar(context, '${AppStrings.importFailed}: $e',
          isError: true);
      return;
    }

    Navigator.pop(context);
    ImportHelper.showChoiceDialogAndImport(
      context: context,
      ref: ref,
      courseCount: courses.length,
      courses: courses,
      onOverwrite: overwriteImport,
      onNewSchedule: (r, c) async {
        final nameCtrl = TextEditingController();
        await showDialog(
          context: context,
          builder: (ctx2) => AlertDialog(
            title: const Text(AppStrings.newSchedule),
            content: TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: AppStrings.scheduleName,
                hintText: AppStrings.scheduleNameHint,
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx2),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx2),
                child: const Text(AppStrings.confirmImport),
              ),
            ],
          ),
        );
        await newScheduleImport(r, c,
            scheduleName: nameCtrl.text.trim());
      },
      onComplete: () {
        if (context.mounted) {
          showAppSnackBar(
              context, AppStrings.importCourseCount(courses.length));
        }
      },
    );
  }
}
