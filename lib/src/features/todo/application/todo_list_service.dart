import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';

part 'todo_list_service.g.dart';

/// Service for the todo list.
@Riverpod(keepAlive: true)
class TodoListService extends _$TodoListService {
  @override
  void build() => {}; // No implementation

  /// Updates a [Todo].
  Future<void> updateTodo(Todo todo) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) throw StateError('User is not authenticated');
    await ref.read(todoRepositoryProvider).updateTodo(currentUser.id, todo);
  }

  /// Deletes a [Todo].
  Future<void> deleteTodo(Todo todo) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) throw StateError('User is not authenticated');
    await ref.read(todoRepositoryProvider).deleteTodo(currentUser.id, todo);
  }

  /// Creates a [Todo]
  Future<void> createTodo(Todo todo) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) throw StateError('User is not authenticated');
    await ref.read(todoRepositoryProvider).createTodo(currentUser.id, todo);
  }
}
