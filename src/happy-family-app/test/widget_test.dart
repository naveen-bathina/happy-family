import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode
import 'package:fluttertest/screens/layout_screen.dart';
import 'package:json_theme/json_theme.dart'; // Import HomeScreen

void main() async {
  // Ensure widgets binding is initialized before any async operations
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock the rootBundle to simulate loading theme from assets
  const String fakeThemeJson =
      '{"primaryColor": "#FFBC8D"}'; // A simple mock theme

  // Use `mockMethodChannel` to mock `rootBundle.loadString`
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
        MethodCall methodCall,
      ) async {
        if (methodCall.method == 'load' &&
            methodCall.arguments['key'] ==
                'assets/themes/appainter_theme.json') {
          return fakeThemeJson;
        }
        return null;
      });

  // Run the app after everything is initialized
  testWidgets('Test Happy Family Theme', (WidgetTester tester) async {
    // Initialize Hive
    await Hive.initFlutter();

    // Load theme data (in this case, a mock)
    final themeJson = jsonDecode(fakeThemeJson);
    final theme = ThemeDecoder.decodeThemeData(themeJson)!;

    // Wrap the app with ProviderScope and provide theme data
    await tester.pumpWidget(ProviderScope(child: MyApp(theme: theme)));

    // Verify the initial state (you can test UI elements here)
    expect(
      find.byType(LayoutScreen),
      findsOneWidget,
    ); // Ensure HomeScreen is loaded
    expect(find.text('Happy Family'), findsOneWidget); // Verify title
  });
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Family',
      theme: theme,
      home: LayoutScreen(),
    );
  }
}
