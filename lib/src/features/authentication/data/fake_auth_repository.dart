import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';

/// Fake Authentication repository for testing.
class FakeAuthRepository implements AuthRepository {
  @override
  // TODO: implement authStateChanges
  Stream<AppUser?> get authStateChanges => throw UnimplementedError();

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
