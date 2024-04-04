// ignore_for_file: public_member_api_docs, sort_constructors_first
// coverage:ignore-file
import 'package:todo_app/src/exceptions/exceptions.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_app_user.dart';
import 'package:todo_app/src/features/authentication/domain/app_user.dart';
import 'package:todo_app/src/utils/delay.dart';
import 'package:todo_app/src/utils/in_memory_store.dart';

/// Fake Authentication repository for testing.
class FakeAuthRepository implements AuthRepository {
  final bool addDelay;
  final _userStore = InMemoryStore<AppUser?>(null);
  final List<FakeAppUser> _users = [
    const FakeAppUser(id: '1', email: 'test@test.com', password: '123456')
  ];

  FakeAuthRepository({
    this.addDelay = false,
  });

  @override
  Stream<AppUser?> get authStateChanges => _userStore.stream;

  @override
  AppUser? get currentUser => _userStore.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    final user = _findUserByEmail(email);
    if (user == null) throw UserNotFoundException();
    if (user.password != password) throw InvalidCredentialsException();
    _userStore.value = user;
    return Future.value();
  }

  @override
  Future<void> signOut() async {
    _userStore.value = null;
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    final user = FakeAppUser(
        id: email.split('').reversed.join(), email: email, password: password);
    if (_findUserByEmail(email) != null) throw EmailInUseException();
    _users.add(user);
    _userStore.value = user;
    return Future.value();
  }

  /// Search for a user by email.
  FakeAppUser? _findUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email,
          orElse: () => throw UserNotFoundException());
    } catch (e) {
      return null;
    }
  }
}
