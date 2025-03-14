class AuthCheck {
  final bool isUserLoggedIn;
  final bool isFamilySetup;
  final bool isUserProfileSetup;
  final String? errorMessage;

  AuthCheck({
    required this.isUserLoggedIn,
    required this.isFamilySetup,
    required this.isUserProfileSetup,
    this.errorMessage,
  });
}
