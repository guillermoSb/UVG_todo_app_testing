import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  /// Sign in with email and password.
  Future<void> signInWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  /// Sign up with email and password.
  Future<void> signUpWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  /// Sign out.
  Future<void> signOut() {
    throw UnimplementedError();
  }

  /// Stream to expose auth state changes.
  Stream<AppUser?> get authStateChanges {
    throw UnimplementedError();
  }

  /// Get the current user.
  AppUser? get currentUser {
    throw UnimplementedError();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();
