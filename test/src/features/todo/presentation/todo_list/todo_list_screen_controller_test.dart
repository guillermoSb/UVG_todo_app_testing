@Timeout(Duration(milliseconds: 500))
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_app_user.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo.dart';
import 'package:todo_app/src/features/todo/presentation/todo_list/todo_list_screen_controller.dart';

import '../../../../../mocks.dart';

void main() {
  late AuthRepository authRepository;
  late TodoRepository todoRepository;
  const testUser =
      FakeAppUser(id: '1', email: 'test@test.com', password: '123456');
  const testTodo = Todo(
    id: '1',
    title: 'Test',
    completed: false,
  );

  ProviderContainer makeContainer() {
    final providerContainer = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
        todoRepositoryProvider.overrideWithValue(todoRepository),
      ],
    );
    addTearDown(providerContainer.dispose);
    return providerContainer;
  }

  setUp(() {
    authRepository = MockAuthRepository();
    todoRepository = MockTodoRepository();
  });

  setUpAll(() {
    registerFallbackValue(const Todo(
      id: '1',
      title: 'Test',
      completed: false,
    ));
    registerFallbackValue(const AsyncLoading<void>());
  });

  group('Toggle todo', () {
    test('''
    Given - user toggles a todo.
    When - repository is called.
    Then - todo has the opposite completion status.
    ''', () async {
      // Arrange
      final container = makeContainer();
      var listener = Listener<AsyncValue<void>>();
      // listen to the provider changes
      container.listen(
        todoListScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.updateTodo(any(), any()))
          .thenAnswer((invocation) => Future.value(null));
      final todoListScreenController =
          container.read(todoListScreenControllerProvider.notifier);
      // Act
      await todoListScreenController.toggleTodo(testTodo);
      // Assert
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => todoRepository.updateTodo(
          testUser.id, testTodo.copyWith(completed: true))).called(1);
    });

    test('''
    Given - user toggles a todo and an error occurs.
    When - repository is called.
    Then - state is AsyncError
    ''', () async {
      // Arrange
      final container = makeContainer();
      var listener = Listener<AsyncValue<void>>();
      // listen to the provider changes
      container.listen(
        todoListScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.updateTodo(any(), any()))
          .thenAnswer((invocation) => Future.error(Exception()));
      final todoListScreenController =
          container.read(todoListScreenControllerProvider.notifier);
      // Act
      await todoListScreenController.toggleTodo(testTodo);
      // Assert
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });

  group('Delete todo', () {
    test('''
    Given - a user deletes a todo.
    When - repository is called.
    Then - the todo is deleted.
    ''', () async {
      // Arrange
      final container = makeContainer();
      var listener = Listener<AsyncValue<void>>();
      // listen to the provider changes
      container.listen(
        todoListScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(
          () => listener(null, data)); // Initial state is AsyncData<void>(null)
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.deleteTodo(any(), any()))
          .thenAnswer((invocation) => Future.value(null));
      final todoListScreenController =
          container.read(todoListScreenControllerProvider.notifier);
      // Act
      await todoListScreenController.delete(testTodo);
      // Assert
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => todoRepository.deleteTodo(testUser.id, testTodo)).called(1);
    });

    test('''
    Given - a user deletes a todo and an error occurs.
    When - repository is called.
    Then - state is AsyncError
    ''', () async {
      // Arrange
      final container = makeContainer();
      var listener = Listener<AsyncValue<void>>();
      // listen to the provider changes
      container.listen(
        todoListScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => todoRepository.deleteTodo(any(), any()))
          .thenAnswer((invocation) => Future.error(Exception()));
      final todoListScreenController =
          container.read(todoListScreenControllerProvider.notifier);
      // Act
      await todoListScreenController.delete(testTodo);
      // Assert
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
}
