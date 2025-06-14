String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }

  // Allows only alphabets and spaces
  final nameRegExp = RegExp(r"^\s*[a-zA-Z]+( [a-zA-Z]+)*\s*$");
  // final nameRegExp = RegExp(r"^[a-zA-Z]+(\s[a-zA-Z]+)*$");
  if (!nameRegExp.hasMatch(value)) {
    return 'Please enter a valid name';
  }
  return null;
}

// Email Validator
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

// Password Validator (minimum 8 characters, at least one uppercase letter,
// one lowercase letter, one number and one special character)
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  // final passwordRegExp = RegExp(
  //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  final passwordRegExp = RegExp(r'^.{8,}$');
  if (!passwordRegExp.hasMatch(value)) {
    // return '''Password must have 8+ chars, uppercase, number & symbol''';
    return '''Password must have 8+ chars.''';
  }
  return null;
}

String? confirmPasswordValidator(String password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Please confirm your password';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match.';
  }
  return null;
}
