import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/presentation/todo_list/todo_list_screen.dart';

/// This is a robot class for the Todo feature.
class TodoRobot {
  final WidgetTester tester;

  TodoRobot(this.tester);

  /// Pumps the TodoListScreen
  Future<void> pumpTodoListScreen(
      TodoRepository todoRepository, AuthRepository authRepository) async {
    // Create container and pump widget
    return tester.pumpWidget(ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWithValue(todoRepository),
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: TodoListScreen(),
        ),
      ),
    ));
  }
}
