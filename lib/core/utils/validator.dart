class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Regular expression for validating email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }

    return null;
  }

  // static String? passwordValidator(String? value) {
  //   if (value == null || value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   return null;
  // }
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // New regex pattern with updated rules
    const passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{6,}$';

    final passwordRegExp = RegExp(passwordPattern);

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!passwordRegExp.hasMatch(value)) {
      return "Password must contain at least one special character, number, capital and small letter";
    }

    return null;
  }
  static String? validateResetPassword(String? value, String newPasswod) {
  if (value!.isEmpty) {
    // return StringConstants.reEnterPasswordEmptyError;
    return 'Password is required';
  }
  if (value != newPasswod) {
    return 'Passwords do not match';
  }
  return null; // Return null if valid
}
}
