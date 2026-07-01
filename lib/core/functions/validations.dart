class AppValidations {
  const AppValidations._();

  static String? requiredPassword(
      String? value, {
        String fieldName = 'Password',
      }) {
    final String password = value ?? '';

    if (password.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? newPassword(
      String? value, {
        required String currentPassword,
      }) {
    final String password = value ?? '';

    if (password.trim().isEmpty) {
      return 'New password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special symbol';
    }

    if (currentPassword.isNotEmpty && password == currentPassword) {
      return 'New password must be different from current password';
    }

    return null;
  }

  static String? confirmPassword(
      String? value, {
        required String newPassword,
      }) {
    final String confirmPassword = value ?? '';

    if (confirmPassword.trim().isEmpty) {
      return 'Confirm password is required';
    }

    if (confirmPassword != newPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}