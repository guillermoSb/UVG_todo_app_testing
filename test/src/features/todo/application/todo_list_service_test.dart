import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_app_user.dart';
import 'package:todo_app/src/features/todo/application/todo_list_service.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';

import '../../../../mocks.dart';

void main() {
  late AuthRepository authRepository;
  late TodoRepository todoRepository;
  const testTodo = Todo(
    id: '1',
    title: 'Test',
    completed: false,
  );
  const testUser =
      FakeAppUser(id: '1', email: 'test@test.com', password: '123456');

  setUp(() {
    authRepository = MockAuthRepository();
    todoRepository = MockTodoRepository();
  });

  group('Todo List Service', () {
    test('''
      Given - user is not authenticated.
      When - updateTodo is called.
      Then - StateError is catched.
      ''', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            authRepository,
          )
        ],
      );
      final todoListService = container.read(todoListServiceProvider.notifier);
      // Act
      call() => todoListService.updateTodo(testTodo.copyWith(completed: true));
      // Assert
      expect(
        call,
        throwsA(isA<StateError>()),
      );
    });

    test('''
      Given - user is not authenticated.
      When - deleteTodo is called.
      Then - StateError is catched.
      ''', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            authRepository,
          )
        ],
      );
      final todoListService = container.read(todoListServiceProvider.notifier);
      // Act
      call() => todoListService.deleteTodo(testTodo);
      // Assert
      expect(
        call,
        throwsA(isA<StateError>()),
      );
    });

    test('''
      Given - user is authenticated.
      When - updateTodo is called.
      Then - updateTodo is called on todoRepository.
      ''', () async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            authRepository,
          ),
          todoRepositoryProvider.overrideWithValue(todoRepository),
        ],
      );
      final todoListService = container.read(todoListServiceProvider.notifier);
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.updateTodo(testUser.id, testTodo))
          .thenAnswer((_) => Future.value(null));
      // Act
      await todoListService.updateTodo(testTodo);
      // Assert
      verify(() => todoRepository.updateTodo(testUser.id, testTodo)).called(1);
    });

    test('''
      Given - user is authenticated.
      When - deleteTodo is called.
      Then - deleteTodo is called on todoRepository.
    ''', () async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            authRepository,
          ),
          todoRepositoryProvider.overrideWithValue(todoRepository),
        ],
      );
      final todoListService = container.read(todoListServiceProvider.notifier);
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.deleteTodo(testUser.id, testTodo))
          .thenAnswer((_) => Future.value(null));
      // Act
      await todoListService.deleteTodo(testTodo);
      // Assert
      verify(() => todoRepository.deleteTodo(testUser.id, testTodo)).called(1);
    });
  });
}
