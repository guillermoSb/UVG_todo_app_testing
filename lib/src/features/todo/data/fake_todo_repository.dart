import 'package:todo_app/src/features/authentication/domain/app_user.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
import 'package:todo_app/src/utils/delay.dart';
import 'package:todo_app/src/utils/in_memory_store.dart';
import 'package:uuid/uuid.dart';

const fakeTodos = [
  Todo(id: '1', title: 'Buy milk', completed: false),
  Todo(id: '2', title: 'Buy eggs', completed: false),
  Todo(id: '3', title: 'Buy bread', completed: false),
];

/// Fake Repository for [Todo] entities.
class FakeTodoRepository implements TodoRepository {
  final bool addDelay;
  final InMemoryStore<List<Todo>> _store = InMemoryStore([...fakeTodos]);

  FakeTodoRepository({this.addDelay = false});

  @override
  Future<void> createTodo(UserID userId, Todo todo) async {
    await delay(addDelay);
    const uuid = Uuid();
    _store.value.insert(0, todo.copyWith(id: uuid.v4()));
    _store.value = _store.value;
  }

  @override
  Future<void> deleteTodo(UserID userId, Todo todo) async {
    await delay(addDelay);
    _store.value.remove(todo);
    _store.value = _store.value;
  }

  @override
  Future<void> updateTodo(UserID userId, Todo todo) async {
    await delay(addDelay);
    final index = _store.value.indexWhere((element) => element.id == todo.id);
    _store.value[index] = todo;
    _store.value = _store.value;
  }

  @override
  Stream<List<Todo>> watchTodos(UserID userID) {
    return _store.stream;
  }
}
