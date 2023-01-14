class Validators {
  static String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title.';
    }
    return null;
  }

  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description.';
    }
    return null;
  }

  static String? dateValidator(String? value) {
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2} \d{1,2}:\d{1,2} (AM|PM)$');
    if (value == null || value.isEmpty) {
      return 'Please enter a date.';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid date.';
    }
    return null;
  }
}
