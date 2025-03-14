// lib/providers/profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/poll_list_item.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/providers/data_store_provider.dart';

final pollsProvider = FutureProvider<List<PollListItem>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getAllPollsEndpoint}',
  );
  List<PollListItem> pollItems = [];
  if (response['data'] == null) return [];

  response['data'].forEach((item) {
    pollItems.add(PollListItem.fromJson(item));
  });
  return pollItems;
});
