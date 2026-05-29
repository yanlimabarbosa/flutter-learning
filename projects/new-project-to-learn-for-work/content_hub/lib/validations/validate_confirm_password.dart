String? validateConfirmPassword(String? value, String password) {
  final confirmPassword = value ?? '';

  if (confirmPassword.isEmpty) {
    return 'Confirm your password';
  }

  if (confirmPassword != password) {
    return 'Passwords do not match';
  }

  return null;
}
