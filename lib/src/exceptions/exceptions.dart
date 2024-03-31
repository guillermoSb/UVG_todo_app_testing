/// Custom [Exception] class for handling exceptions in the app.
class AppException implements Exception {
  final String message;
  final String code;

  AppException(this.code, this.message);

  @override
  String toString() => message;
}
