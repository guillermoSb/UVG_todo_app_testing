import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/auth_form_type.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';

/// A robot that helps to test the authentication feature.
class AuthRobot {
  AuthRobot(this.tester);
  WidgetTester tester;

  /// Pumps the authentication form.
  Future<void> pumpAuthForm({
    required AuthRepository authRepository,
    required AuthFormType formType,
  }) async {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(authRepository)],
        child: MaterialApp(
          home: Scaffold(
              body: AuthenticationForm(
            formType: formType,
          )),
        ),
      ),
    );
  }

  /// Fills the email
  Future<void> fillEmail(String email) async {
    final emailField = find.widgetWithText(TextFormField, 'Email');
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
  }

  /// Fills the password
  Future<void> fillPassword(String password) async {
    final passwordField = find.widgetWithText(TextFormField, 'Password');
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
  }

  /// Search and tap the authentication form's button
  Future<void> tapAuthButton() async {
    final signInButton = find.byKey(AuthenticationForm.buttonKey);
    expect(signInButton, findsOneWidget);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
  }

  /// Expect to find an alert with Error on its title.
  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }
}
