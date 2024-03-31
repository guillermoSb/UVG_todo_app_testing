mixin AuthFormValidators {
  bool canSubmitEmail(String email) {
    if (email.isEmpty) return false;
    try {
      // https://regex101.com/
      final RegExp regex = RegExp('^\\S+@\\S+\\.\\S+\$');
      final Iterable<Match> matches = regex.allMatches(email);
      for (final match in matches) {
        if (match.start == 0 && match.end == email.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }

  bool canSubmitPassword(String password) => password.isNotEmpty;

  String? emailErrorText(String email) {
    final showError = !canSubmitEmail(email);
    final errorMessage =
        email.isEmpty ? 'Email cannot be empty' : 'Invalid email';
    return showError ? errorMessage : null;
  }

  String? passwordErrorText(String password) {
    final showError = !canSubmitPassword(password);
    final errorMessage =
        password.isEmpty ? 'Password cannot be empty' : 'Invalid password';
    return showError ? errorMessage : null;
  }
}
