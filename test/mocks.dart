import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:todo_app/src/features/todo/data/fake_todo_repository.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

class MockTodoRepository extends Mock implements FakeTodoRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
