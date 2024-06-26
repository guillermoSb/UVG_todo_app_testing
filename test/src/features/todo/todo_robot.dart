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

  /// Deletes todo by [index]
  Future<void> deleteTodo(int index) async {
    final key = Key('delete_todo_button_$index');
    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
  }

  /// Taps the checkbox of the todo by [index]
  Future<void> tapTodoCheckbox(int index) async {
    final key = Key('todo_checkbox_$index');
    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
  }

  /// Tap on floating_button
  Future<void> tapFloatingButton() async {
    const key = Key('floating_button');
    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
  }

  /// Fill todo_text_field
  Future<void> fillTodoTitle(String title) async {
    final todoField = find.widgetWithText(TextFormField, 'Todo');
    expect(todoField, findsOneWidget);
    await tester.enterText(todoField, title);
    await tester.pumpAndSettle();
  }

  /// Tap on save button
  Future<void> tapOnSaveButton() async {
    final saveButon = find.widgetWithText(ElevatedButton, 'Save');
    expect(saveButon, findsOneWidget);
    await tester.tap(saveButon);
    await tester.pumpAndSettle();
  }

  /// Add a todo with [title]
  Future<void> addTodo(String title) async {
    await tapFloatingButton();
    await fillTodoTitle(title);
    await tapOnSaveButton();
  }

  /// Expect to find [n] todos in the list
  void expectFindNTodos(int n) {
    expect(find.byType(ListTile), findsNWidgets(n));
  }

  /// Expect the checkbox of the todo by [index] to be checked
  void expectCheckBoxChecked(int index, bool checked) {
    final key = Key('todo_checkbox_$index');
    final checkbox = tester.widget<Checkbox>(find.byKey(key));
    expect(checkbox.value, checked);
  }
}
