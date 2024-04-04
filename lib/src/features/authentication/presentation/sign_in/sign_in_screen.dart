import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/constants/app_sizes.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/auth_form_type.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/auth_form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:todo_app/src/utils/async_ui.dart';

/// User Sign In Screen.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const AuthenticationForm(),
    );
  }
}

/// Email & Password Authentication Form. Supports:
/// - sign in
/// - sign up
class AuthenticationForm extends ConsumerStatefulWidget {
  static const buttonKey = Key('auth_button_key');
  final AuthFormType formType;
  const AuthenticationForm({super.key, this.formType = AuthFormType.signIn});

  @override
  ConsumerState<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends ConsumerState<AuthenticationForm>
    with AuthFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late var _authFormType = widget.formType;
  var _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInScreenControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              controller: _emailController,
              validator: (value) =>
                  _submitted ? emailErrorText(value ?? '') : null,
            ),
            gapH12,
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              autocorrect: false,
              controller: _passwordController,
              validator: (value) =>
                  _submitted ? passwordErrorText(value ?? '') : null,
            ),
            gapH24,
            if (state.isLoading) const CircularProgressIndicator(),
            if (!state.isLoading)
              CupertinoButton.filled(
                key: AuthenticationForm.buttonKey,
                onPressed: state.isLoading
                    ? null
                    : () async {
                        setState(() => _submitted = true);
                        if (_formKey.currentState?.validate() == false) return;

                        final controller =
                            ref.read(signInScreenControllerProvider.notifier);

                        await controller.submit(
                          email: _emailController.text,
                          password: _passwordController.text,
                          formType: _authFormType,
                        );
                      },
                child: Text(_authFormType.title),
              ),
            gapH12,
            if (!state.isLoading)
              CupertinoButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        setState(() {
                          _authFormType = _authFormType.opposite;
                          _submitted = false;
                        });
                      },
                child: Text(_authFormType.secondaryTitle),
              ),
          ],
        ),
      ),
    );
  }
}
