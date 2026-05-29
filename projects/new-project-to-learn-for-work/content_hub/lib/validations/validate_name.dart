String? validateName(String? value) {
  final name = value?.trim() ?? '';

  if (name.isEmpty) {
    return 'Name is required';
  }

  if (name.length < 2) {
    return 'Name must have at least 2 characters';
  }

  if (name.length > 60) {
    return 'Name must have at most 60 characters';
  }

  return null;
}
