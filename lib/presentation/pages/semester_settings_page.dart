import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/datasources/database.dart';
import '../providers/semester_provider.dart';

class SemesterSettingsPage extends ConsumerStatefulWidget {
  const SemesterSettingsPage({super.key});

  @override
  ConsumerState<SemesterSettingsPage> createState() =>
      _SemesterSettingsPageState();
}

class _SemesterSettingsPageState extends ConsumerState<SemesterSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _startDateController;
  late TextEditingController _totalWeeksController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _startDateController = TextEditingController();
    _totalWeeksController = TextEditingController(text: '20');

    final semesterAsync = ref.read(activeSemesterProvider);
    semesterAsync.whenData((semester) {
      if (semester != null) {
        _nameController.text = semester.name;
        _startDateController.text = semester.startDate.substring(0, 10);
        _totalWeeksController.text = semester.totalWeeks.toString();
      }
    });
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
    final semesterAsync = ref.watch(activeSemesterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('学期设置'),
      ),
      body: semesterAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('加载失败: $error')),
        data: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '学期名称',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? '请输入学期名称' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    labelText: '开学日期',
                    hintText: 'YYYY-MM-DD',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      _startDateController.text =
                          date.toIso8601String().substring(0, 10);
                    }
                  },
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? '请选择开学日期' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _totalWeeksController,
                  decoration: const InputDecoration(
                    labelText: '总周数',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '请输入总周数';
                    final weeks = int.tryParse(v.trim());
                    if (weeks == null || weeks < 1 || weeks > 30) {
                      return '请输入1-30之间的数字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => _save(),
                  child: const Text('保存'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref.read(activeSemesterProvider.notifier).setConfig(
            SemesterConfigsCompanion(
              name: drift.Value(_nameController.text.trim()),
              startDate: drift.Value('${_startDateController.text.trim()}T00:00:00'),
              totalWeeks: drift.Value(int.parse(_totalWeeksController.text.trim())),
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存成功')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    }
  }
}
