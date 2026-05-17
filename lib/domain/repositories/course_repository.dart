import '../../data/models/course.dart';

abstract class CourseRepository {
  Stream<List<Course>> watchAllCourses();
  Future<void> addCourse(Course course);
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}
