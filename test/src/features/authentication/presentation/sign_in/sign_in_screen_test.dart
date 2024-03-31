import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/auth_form_type.dart';

import '../../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = 'testPassword';
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });
  group('Sign In', () {
    testWidgets('''
    Given - user is signing in and form is invalid.
    When - user taps on sign in button.
    Then - signInWithEmailAndPassword is not called.
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          formType: AuthFormType.signIn, authRepository: authRepository);
      // Act
      await robot.tapAuthButton();
      // Assert
      verifyNever(
          () => authRepository.signInWithEmailAndPassword(any(), any()));
    });

    testWidgets('''
    Given - user is signing in and form is valid.
    When - user taps on sign in button.
    Then - signInWithEmailAndPassword is called.
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          formType: AuthFormType.signIn, authRepository: authRepository);
      // Act
      await robot.fillEmail(testEmail);
      await robot.fillPassword(testPassword);
      await robot.tapAuthButton();
      // Assert
      verify(() => authRepository.signInWithEmailAndPassword(
          testEmail, testPassword)).called(1);
    });

    testWidgets('''
    Given - user is signing in and email does not have correct format.
    When - user taps on sign in button.
    Then - signInWithEmailAndPassword is not called
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          authRepository: authRepository, formType: AuthFormType.signIn);
      // Act
      await robot.fillEmail('qwerty');
      await robot.fillPassword(testPassword);
      await robot.tapAuthButton();
      // Assert
      verifyNever(
          () => authRepository.signInWithEmailAndPassword(any(), any()));
    });
  });

  group('Register', () {
    testWidgets('''
    Given - User is registering and form is invalid.
    When - User taps on register button.
    Then - signUpWithEmailAndPassword is not called.
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          formType: AuthFormType.signUp, authRepository: authRepository);
      // Act
      await robot.tapAuthButton();
      // Assert
      verifyNever(
          () => authRepository.signUpWithEmailAndPassword(any(), any()));
    });

    testWidgets('''
    Given - user is creating account and form is valid.
    When - user taps on register button.
    Then - signUpWithEmailAndPassword is called.
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          formType: AuthFormType.signUp, authRepository: authRepository);
      // Act
      await robot.fillEmail(testEmail);
      await robot.fillPassword(testPassword);
      await robot.tapAuthButton();
      // Assert
      verify(() => authRepository.signUpWithEmailAndPassword(
          testEmail, testPassword)).called(1);
    });

    testWidgets('''
    Given - user is creating an account and email does not have correct format.
    When - user taps on sign in button.
    Then - signInWithEmailAndPassword is not called
    ''', (tester) async {
      // Arrange
      final robot = AuthRobot(tester);
      await robot.pumpAuthForm(
          authRepository: authRepository, formType: AuthFormType.signUp);
      // Act
      await robot.fillEmail('qwerty');
      await robot.fillPassword(testPassword);
      await robot.tapAuthButton();
      // Assert
      verifyNever(
          () => authRepository.signUpWithEmailAndPassword(any(), any()));
    });
  });
}
