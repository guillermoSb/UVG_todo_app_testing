import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:todo_app/src/features/todo/data/fake_todo_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';

import 'features/authentication/auth_robot.dart';
import 'features/todo/todo_robot.dart';

class Robot {
  final WidgetTester tester;
  final TodoRobot todo;
  final AuthRobot auth;

  Robot(this.tester)
      : todo = TodoRobot(tester),
        auth = AuthRobot(tester);

  /// Pumps the application with fake data
  Future<void> pumpMyAppWithFakes({delay = false}) async {
    final container = await _createFakeContainer(delay);
    await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()));
  }

  /// Runs the full todo flow
  Future<void> fullTodoFlow() async {
    await auth.loginWithCredentials('test@test.com', '123456');
    await todo.addTodo('Testing todo');
    todo.expectFindNTodos(4);
    await todo.tapTodoCheckbox(0);
    todo.expectCheckBoxChecked(0, true);
    await todo.deleteTodo(0);
    todo.expectFindNTodos(3);
    await auth.tapSignOutButton();
    auth.expectSignInText();
  }

  /// Creates a fake repository container
  Future<ProviderContainer> _createFakeContainer(bool delay) async {
    final todoRepository = FakeTodoRepository(addDelay: delay);
    final authRepository = FakeAuthRepository(addDelay: delay);
    return ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      todoRepositoryProvider.overrideWithValue(todoRepository),
    ]);
  }
}
