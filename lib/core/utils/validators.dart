import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static String? validateRequired(
    String? value, {
    String message = AppStrings.fieldRequired,
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateUsername(
    String? value, {
    String requiredMessage = 'Username is required',
    String minLengthMessage = AppStrings.usernameTooShort,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    if (value.trim().length < 3) {
      return minLengthMessage;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }
}
