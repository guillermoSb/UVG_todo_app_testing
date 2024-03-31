import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/todo/application/todo_list_service.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
import 'package:todo_app/src/features/todo/presentation/todo_list/todo_list_screen_controller.dart';

/// Main application screen.
class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref
                    .read(authRepositoryProvider)
                    .signOut(); // Pragmatic Decision
              },
            ),
          ],
        ),
        body: const TodoListContents(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}

/// Display content for this screen.
class TodoListContents extends ConsumerWidget {
  const TodoListContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStreamProvider);

    return todos.when(
      data: (todos) => TodoListItems(todos: todos),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

/// A [ListView] of [Todo] items.
class TodoListItems extends ConsumerWidget {
  final List<Todo> todos;
  const TodoListItems({super.key, required this.todos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
            onTap: () {},
            title: Text(
              todo.title,
            ),
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                ref
                    .read(todoListScreenControllerProvider.notifier)
                    .toggleTodo(todo);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(todoListScreenControllerProvider.notifier)
                    .delete(todo);
              },
            ));
      },
      itemCount: todos.length,
    );
  }
}
