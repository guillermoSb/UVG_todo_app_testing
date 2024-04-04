import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/todo/application/todo_list_service.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
part 'todo_form_controller.g.dart';

@riverpod
class TodoFormController extends _$TodoFormController {
  @override
  FutureOr<void> build() {} // No implementation

  /// Add todo
  Future<void> addTodo(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(todoListServiceProvider.notifier)
        .createTodo(Todo(title: title)));
  }
}
