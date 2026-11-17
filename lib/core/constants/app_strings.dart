class AppStrings {
  AppStrings._();

  static const String appName = 'Habitt';

  // Auth
  static const String loginTitle = 'Log In';
  static const String registerTitle = 'Register';
  static const String usernameHint = 'Enter Username';
  static const String passwordHint = 'Enter Password';
  static const String nameHint = 'Name';
  static const String ageLabel = 'Age';
  static const String countryHint = 'Country';
  static const String forgotPassword = 'Forgot password?';
  static const String signUp = 'Sign up';
  static const String orText = 'or';
  static const String selectHabits = 'Select Your Habits';
  static const String registerButton = 'Register';
  static const List<String> countries = [
    'Australia',
    'Indonesia',
    'United States',
    'United Kingdom',
    'Singapore',
    'Malaysia',
    'Japan',
  ];

  // Validation
  static const String fieldRequired = 'This field is required';
  static const String usernameTooShort =
      'Username must be at least 3 characters';
  static const String passwordTooShort =
      'Password must be at least 6 characters';
}
