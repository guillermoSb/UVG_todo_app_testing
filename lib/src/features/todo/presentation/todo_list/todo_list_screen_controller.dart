import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/todo/application/todo_list_service.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';

part 'todo_list_screen_controller.g.dart';

@riverpod
class TodoListScreenController extends _$TodoListScreenController {
  @override
  FutureOr<void> build() {} // No implementation

  /// Toggles the completion status of a [Todo].
  Future<void> toggleTodo(Todo todo) async {
    state = const AsyncLoading();
    final newTodo = todo.copyWith(completed: !todo.completed);
    state = await AsyncValue.guard(
      () => ref.read(todoListServiceProvider.notifier).updateTodo(newTodo),
    );
  }

  /// Deletes a [Todo].
  Future<void> delete(Todo todo) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(todoListServiceProvider.notifier).deleteTodo(todo),
    );
  }
}
