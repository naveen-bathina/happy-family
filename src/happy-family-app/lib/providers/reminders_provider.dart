// lib/providers/profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/reminder_item.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/providers/data_store_provider.dart';

final remindersProvider = FutureProvider<List<ReminderItem>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getRemindersListEndpoint}',
  );
  List<ReminderItem> reminderItems = [];
  response['data'].forEach((item) {
    reminderItems.add(ReminderItem.fromJson(item));
  });
  return reminderItems;
});
