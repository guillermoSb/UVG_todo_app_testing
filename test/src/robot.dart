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
  Future<void> pumpMyAppWithFakes() async {
    final container = await _createFakeContainer();
    await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()));
  }

  /// Creates a fake repository container
  Future<ProviderContainer> _createFakeContainer() async {
    final todoRepository = FakeTodoRepository();
    final authRepository = FakeAuthRepository();
    return ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      todoRepositoryProvider.overrideWithValue(todoRepository),
    ]);
  }
}
