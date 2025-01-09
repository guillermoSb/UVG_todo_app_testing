import 'dart:async';

import 'package:cbl/cbl.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';

/// Repository that uses Couchbase
class CouchTodoRepository implements TodoRepository {
  final Database database; // Couchbase database

  CouchTodoRepository({required this.database});

  @override
  Future<void> createTodo(UserID userId, Todo todo) async {
    final collection = await database.createCollection('todos');
    final document = MutableDocument();
    document
      ..setString(todo.title, key: 'title')
      ..setBoolean(todo.completed, key: 'completed');
    await collection.saveDocument(document);
  }

  @override
  Future<void> deleteTodo(UserID userId, Todo todo) async {
    final collection = await database.createCollection('todos');
    if (todo.id == null) return;
    final doc = await collection.document(todo.id!);
    if (doc == null) return;
    await collection.deleteDocument(doc);
  }

  @override
  Future<void> updateTodo(UserID userId, Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

  @override
  Stream<List<Todo>> watchTodos(UserID userID) {
    final controller = StreamController<List<Todo>>();
    final collectionResult = database.createCollection('todos');
    final collectionFuture = collectionResult is Future
        ? collectionResult as Future<Collection>
        : Future.value(collectionResult);
    collectionFuture.then((collection) {
      final query = const QueryBuilder()
          .select(
            SelectResult.expression(Meta.id),
            SelectResult.property('title'),
            SelectResult.property('completed'),
          )
          .from(DataSource.collection(collection));

      query.changes().listen((change) async {
        final results = await change.results.allResults();
        final todos = <Todo>[];
        for (final result in results) {
          final id = result.string('id');
          final title = result.string('title');
          final completed = result.boolean('completed');
          todos.add(Todo(
            id: id ?? '',
            title: title ?? '',
            completed: completed,
          ));
        }
        controller.add(todos);
      });
    }).catchError((error) {
      // Handle errors
      controller.addError(error);
    });

    return controller.stream;
  }
}
