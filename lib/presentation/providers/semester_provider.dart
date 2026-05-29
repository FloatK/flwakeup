import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/database.dart';

part 'semester_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  throw UnimplementedError('Must be overridden with database instance');
}
