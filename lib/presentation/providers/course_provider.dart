import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/course.dart';
import '../../domain/repositories/course_repository.dart';

part 'course_provider.g.dart';

@Riverpod(keepAlive: true)
CourseRepository courseRepository(CourseRepositoryRef ref) {
  throw UnimplementedError('Must be overridden with database instance');
}

@riverpod
class CourseList extends _$CourseList {
  @override
  Stream<List<Course>> build() {
    final repo = ref.watch(courseRepositoryProvider);
    return repo.watchAllCourses();
  }

  Future<void> addCourse(Course course) async {
    final repo = ref.read(courseRepositoryProvider);
    await repo.addCourse(course);
  }

  Future<void> updateCourse(Course course) async {
    final repo = ref.read(courseRepositoryProvider);
    await repo.updateCourse(course);
  }

  Future<void> deleteCourse(String id) async {
    final repo = ref.read(courseRepositoryProvider);
    await repo.deleteCourse(id);
  }
}
