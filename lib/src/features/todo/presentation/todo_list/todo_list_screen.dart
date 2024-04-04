import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/constants/app_sizes.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
import 'package:todo_app/src/features/todo/presentation/todo_form/todo_form.dart';
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
              key: const Key('sign_out'),
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
          key: const Key('floating_button'),
          onPressed: () {
            showModalBottomSheet(
              // backgroundColor: Colors.black,
              context: context,
              builder: (context) {
                return const SizedBox(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: Sizes.p12),
                          child: SizedBox(
                            width: 50,
                            child: Divider(
                              thickness: 5.0,
                            ),
                          ),
                        ),
                        gapH32,
                        TodoForm()
                      ],
                    ),
                  ),
                );
              },
            );
          },
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
    final state = ref.watch(todoListScreenControllerProvider);
    return ListView.builder(
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
            title: Text(
              todo.title,
            ),
            leading: Checkbox(
              key: Key('todo_checkbox_$index'),
              value: todo.completed,
              onChanged: (value) async {
                await ref
                    .read(todoListScreenControllerProvider.notifier)
                    .toggleTodo(todo);
              },
            ),
            trailing: IconButton(
              key: Key('delete_todo_button_$index'),
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
