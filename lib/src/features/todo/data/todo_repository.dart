import 'package:todo_app/src/features/authentication/domain/app_user.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';

/// Repository for [Todo] entities.
class TodoRepository {
  /// Stream of all [Todo] entities.
  Stream<List<Todo>> watchTodos(UserID userID) {
    throw UnimplementedError();
  }

  /// Creates a new [Todo] entity.
  Future<void> createTodo(
    UserID userId,
    Todo todo,
  ) {
    throw UnimplementedError();
  }

  /// Updates a [Todo] entity.
  Future<void> updateTodo(
    UserID userId,
    Todo todo,
  ) {
    throw UnimplementedError();
  }

  /// Deletes a [Todo] entity.
  Future<void> deleteTodo(
    UserID userId,
    Todo todo,
  ) {
    throw UnimplementedError();
  }
}
