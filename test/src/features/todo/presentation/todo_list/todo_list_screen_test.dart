import 'package:flutter_test/flutter_test.dart';

import '../../../../robot.dart';

void main() {
  setUp(() {});

  group('App Bar', () {
    testWidgets('''
    Given - User is in todo list screen
    When - User signs out
    Then - App redirects to sign in 
    ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      robot.todo.expectFindNTodos(3);
      await robot.auth.tapSignOutButton();
      // Assert
      robot.auth.expectSignInText();
    });
  });
  group('Todo List Screen', () {
    testWidgets('''
      Given - User has 3 tasks
      When - Screen appears
      Then - 3 tasks are shown
      ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      // Log widget tree
      robot.todo.expectFindNTodos(3);
    });

    testWidgets('''
    Given - User has 3 tasks
    When - User deletes one task
    Then - 2 tasks are shown
    ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      robot.todo.expectFindNTodos(3);
      await robot.todo.deleteTodo(0);
      // Assert
      robot.todo.expectFindNTodos(2);
    });

    testWidgets('''
    Given - User has 3 tasks
    When - User checks one task
    Then - Task is marked as completed
    ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      robot.todo.expectFindNTodos(3);
      await robot.todo.tapTodoCheckbox(0);
      // Assert
      robot.todo.expectCheckBoxChecked(0, true);
    });

    testWidgets('''
    Given - User has 3 tasks
    When - User checks one task and then disables it
    Then - Task is marked as completed
    ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      robot.todo.expectFindNTodos(3);
      await robot.todo.tapTodoCheckbox(0);
      await robot.todo.tapTodoCheckbox(0);
      // Assert
      robot.todo.expectCheckBoxChecked(0, false);
    });
    testWidgets('''
    Given - User has 3 tasks
    When - User adds a new task
    Then - There are 4 tasks
    ''', (tester) async {
      // Arrange
      final robot = Robot(tester);
      await robot.pumpMyAppWithFakes();
      // Act
      await robot.auth.loginWithCredentials('test@test.com', '123456');
      robot.todo.expectFindNTodos(3);
      await robot.todo.tapFloatingButton();
      await robot.todo.fillTodoTitle('Test todo');
      await robot.todo.tapOnSaveButton();
      // Assert
      robot.todo.expectFindNTodos(4);
    });
  });
}
