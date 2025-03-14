import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/auth_provider.dart';
import 'package:fluttertest/providers/family_info_provider.dart';
import 'package:fluttertest/providers/profile_provider.dart';
import 'package:fluttertest/screens/join_family_screen.dart';
import 'package:fluttertest/screens/layout_screen.dart';
import 'package:fluttertest/screens/login_screen.dart';
import 'package:fluttertest/utils/app_constants.dart';

class MyApp extends ConsumerWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the authentication state
    final userLoggedIn = ref.watch(isUserLoggedInProvider);
    final familyProvider = ref.read(familyInfoProvider);
    final userProfile = ref.watch(profileProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: theme,
      home: userLoggedIn.when(
        data: (loggedIn) {
          // If the user is authenticated, show the HomeScreen
          if (!loggedIn) {
            // check family info and profile info and then show layout
            // if don't have family info then show Joinfamily screen
            // if don't have profile info then show profile screen
            return LoginScreen();
          }

          // Check if profile info is complete
          if (userProfile.hasProfile == false) {
            return ProfileCompletionScreen(); // Create this screen if needed
          }

          // Check if family info exists
          if (familyInfo.hasFamily == false) {
            return JoinFamilyScreen();
          }

          return LayoutScreen();
          // Otherwise, show the LoginScreen
        },
        loading:
            () =>
                const CircularProgressIndicator(), // Show a loader while checking auth state
        error:
            (error, stack) => Center(
              child: Text('Error: $error'),
            ), // Show an error message if something goes wrong
      ),
    );
  }
}
