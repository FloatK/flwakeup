import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'app.dart';
import 'data/datasources/database.dart';
import 'data/datasources/sample_data.dart';
import 'data/repositories/course_repository_impl.dart';
import 'presentation/providers/course_provider.dart';
import 'presentation/providers/semester_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(appDir.path, 'flwakeup.db');
  final db = AppDatabase(NativeDatabase(File(dbPath)));

  await _initSampleData(db);

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        courseRepositoryProvider.overrideWithValue(CourseRepositoryImpl(db)),
      ],
      child: const App(),
    ),
  );
}

Future<void> _initSampleData(AppDatabase db) async {
  final count = await (db.select(db.courses)..limit(1)).get();
  if (count.isEmpty) {
    await insertSampleData(db);
  }
}
