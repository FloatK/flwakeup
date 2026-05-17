// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseRepositoryHash() => r'ae4a9f44d8e90f4e3eb435c4a05d348c024f6a35';

/// See also [courseRepository].
@ProviderFor(courseRepository)
final courseRepositoryProvider = Provider<CourseRepository>.internal(
  courseRepository,
  name: r'courseRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CourseRepositoryRef = ProviderRef<CourseRepository>;
String _$courseListHash() => r'403348be9ca8e713561a07220b857f60ce1e8a6c';

/// See also [CourseList].
@ProviderFor(CourseList)
final courseListProvider =
    AutoDisposeStreamNotifierProvider<CourseList, List<Course>>.internal(
  CourseList.new,
  name: r'courseListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$courseListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CourseList = AutoDisposeStreamNotifier<List<Course>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
