import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/auth_form_type.dart';

part 'sign_in_screen_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  SignInScreenController() : super();
  @override
  FutureOr<void> build() => {}; // No implementation

  Future<bool> submit({
    required String email,
    required String password,
    required AuthFormType formType,
  }) async {
    // Choose the method to call based on the form type.
    if (formType == AuthFormType.signIn) {
      state = await AsyncValue.guard(() => ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password));
    } else if (formType == AuthFormType.signUp) {
      state = await AsyncValue.guard(() => ref
          .read(authRepositoryProvider)
          .signUpWithEmailAndPassword(email, password));
    }
    return !state.hasError; // Everything is ok
  }
}
