String? validatePassword(String? value) {
  final password = value ?? '';

  if (password.isEmpty) {
    return 'Password is required';
  }

  if (password.length < 8) {
    return 'Password must have at least 8 characters';
  }

  if (password.length > 128) {
    return 'Password must have at most 128 characters';
  }

  if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
    return 'Password must contain at least one letter';
  }

  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return 'Password must contain at least one number';
  }

  return null;
}
