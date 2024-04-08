import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';

/// Wrapper for the [User] class from Firebase.
class FirebaseAppUser implements AppUser {
  final User _user;
  FirebaseAppUser(this._user);

  @override
  String get email => _user.email ?? '';

  @override
  UserID get id => _user.uid;
}
