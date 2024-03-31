enum AuthFormType { signIn, signUp }

extension AuthFormTypeX on AuthFormType {
  /// Returns the title of the form type
  String get title {
    switch (this) {
      case AuthFormType.signIn:
        return 'Sign In';
      case AuthFormType.signUp:
        return 'Create Account';
    }
  }

  /// Text to display for the secondary action
  String get secondaryTitle {
    switch (this) {
      case AuthFormType.signIn:
        return 'Need an account?';
      case AuthFormType.signUp:
        return 'Already have an account?';
    }
  }

  /// Returns the form type for the opposite action
  AuthFormType get opposite {
    switch (this) {
      case AuthFormType.signIn:
        return AuthFormType.signUp;
      case AuthFormType.signUp:
        return AuthFormType.signIn;
    }
  }
}
