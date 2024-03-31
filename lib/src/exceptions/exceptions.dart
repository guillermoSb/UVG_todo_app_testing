/// Custom [Exception] class for handling exceptions in the app.
class AppException implements Exception {
  final String message;
  final String code;

  AppException(this.code, this.message);

  @override
  String toString() => message;
}

// Auth Exceptions

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found.');
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException()
      : super('invalid-credentials', 'Invalid credentials.');
}

class EmailInUseException extends AppException {
  EmailInUseException() : super('email-in-use', 'Email already in use.');
}
