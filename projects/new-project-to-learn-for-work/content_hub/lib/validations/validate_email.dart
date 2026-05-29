String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  if (email.isEmpty) {
    return 'Email is required';
  }

  if (email.length > 254) {
    return 'Email must have at most 254 characters';
  }

  if (!emailRegex.hasMatch(email)) {
    return 'Enter a valid email';
  }

  return null;
}
