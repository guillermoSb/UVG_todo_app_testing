// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'7662744c44a7a0ad47129687e01092b4552f49f9';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = Provider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoRepositoryRef = ProviderRef<TodoRepository>;
String _$todoStreamHash() => r'866f203490d0f495118c6c8c552f85f99703cc8b';

/// See also [todoStream].
@ProviderFor(todoStream)
final todoStreamProvider = AutoDisposeStreamProvider<List<Todo>>.internal(
  todoStream,
  name: r'todoStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoStreamRef = AutoDisposeStreamProviderRef<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
