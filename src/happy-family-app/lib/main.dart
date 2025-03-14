import 'package:flutter/material.dart';
import 'package:fluttertest/providers/data_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/screens/my_app.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();

  // Initialize DataStore
  final dataStore = DataStore();
  await dataStore.initialize();

  final themeStr = await rootBundle.loadString(
    'assets/themes/appainter_theme_purple.json',
  );
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(ProviderScope(child: MyApp(theme: theme)));
}
