import 'package:todo_app/src/features/authentication/domain/app_user.dart';

/// Fake User used in tests.
class FakeAppUser extends AppUser {
  const FakeAppUser(
      {required super.id, required super.email, required this.password});
  final String password;
}
