// coverage:ignore-file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/exceptions/exceptions.dart';
import 'package:todo_app/src/features/authentication/data/firebase_app_user.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  /// Sign in with email and password.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw InvalidCredentialsException();
      } else if (e.code == 'invalid-credential') {
        throw InvalidCredentialsException();
      }
      rethrow;
    }
  }

  /// Sign up with email and password.
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailInUseException();
      }
      rethrow;
    }
  }

  /// Sign out.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Stream to expose auth state changes.
  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      return _appUserFromFirebase(user);
    });
  }

  /// Get the current user.
  AppUser? get currentUser {
    final user = _auth.currentUser;
    return _appUserFromFirebase(user);
  }

  /// Convert firebase user to domain user.
  FirebaseAppUser? _appUserFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return FirebaseAppUser(user);
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(FirebaseAuth.instance);
