class AppConstants {
  // App's Title
  static const String appName = 'Happy Family';

  // Logo path
  static const String logoPath = 'assets/images/logo.png';

  // Registered Office Address
  static const String officeAddress =
      'Darakastu Road, Ojili Village and Post, \nTirupati District, Andhra Pradesh, \nIndia 524402';

  // Copyright Text
  static const String copyrightText =
      '© 2025 Happy Family. All rights reserved.';

  // Credits
  static const String creditsText = 'Developed by Happy Family Team';

  // Legal Text
  static const String legalText =
      'All information on this app is provided "as is". Happy Family is not responsible for any damage or loss resulting from the use of this app.';

  // Api Url secured
  static const String apiUrl = 'https://10.0.2.2:7115/api/members';

  // Api Url unsecured
  static const String unsecuredApiUrl = 'http://10.0.2.2:5280/api';

  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateWeekDayFormat = 'EEEE, MMM dd, yyyy';

  static const String getFamilyInfoEndpoint = '/family';
  static const String getAllIssuesEndpoint = '/support';
  static const String getAllDocumentsEndpoint = '/documents';
  static const String getAllEventsEndpoint = '/events';
  static const String getAllMembersEndpoint = '/members';
  static const String getAllPollsEndpoint = '/polls';
  static const String getMyProfileDetailsEndpoint = '/members/me';
  static const String getTodoListEndpoint = '/todo';
  static const String getRemindersListEndpoint = '/reminders';
  static const String getChatMessagesEndpoint = '/chat';
  static const String sendMessageEndpoint = '/chat/message';
  static const String requestOtpEndpoint = '/auth/request-otp';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String logoutEndpoint = '/auth/logout';
  static const String joinFamilyWithCodeEndpoint = '/family/join-with-code';
  static const String createFamilyWithNameEndpoint = '/family/create-with-name';

  static const String familyId = "837f2186-942b-418c-85d1-311269dfe6af";
  static const String memberId = "9620430945";

  static const String familyInfoLocalStorageKey = "familyInfo";
}
