import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:todo_app/src/features/todo/data/fake_todo_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';

import '../../../../../mocks.dart';
import '../../todo_robot.dart';

void main() {
  late final todoRepository;
  late final authRepository;

  setUp(() {
    todoRepository = MockTodoRepository();
    authRepository = MockAuthRepository();
  });
  group('Todo List Screen', () {
    testWidgets('''
    Given - User has 3 tasks
    When - Screen appears
    Then - 3 tasks are shown
    ''', (tester) async {
      // Arrange
      final robot = TodoRobot(tester);
      await robot.pumpTodoListScreen(todoRepository, authRepository);
      // Act
      // Assert
    });
  });
}
