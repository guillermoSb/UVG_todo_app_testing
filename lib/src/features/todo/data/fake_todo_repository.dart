import 'package:todo_app/src/features/authentication/domain/app_user.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
import 'package:todo_app/src/utils/in_memory_store.dart';

const fakeTodos = [
  Todo(id: '1', title: 'Buy milk', completed: false),
  Todo(id: '2', title: 'Buy eggs', completed: true),
  Todo(id: '3', title: 'Buy bread', completed: false),
];

/// Fake Repository for [Todo] entities.
class FakeTodoRepository implements TodoRepository {
  final InMemoryStore<List<Todo>> _store = InMemoryStore([...fakeTodos]);

  @override
  Future<void> createTodo(UserID userId, Todo todo) async {
    _store.value.add(todo);
  }

  @override
  Future<void> deleteTodo(UserID userId, Todo todo) async {
    _store.value.remove(todo);
  }

  @override
  Future<void> updateTodo(UserID userId, Todo todo) async {
    final index = _store.value.indexWhere((element) => element.id == todo.id);
    _store.value[index] = todo;
  }

  @override
  Stream<List<Todo>> watchTodos(UserID userID) {
    return _store.stream;
  }
}
