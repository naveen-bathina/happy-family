// lib/providers/profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/issue_list_item.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';

final supportProvider = FutureProvider<List<IssueListItem>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getAllIssuesEndpoint}',
  );
  List<IssueListItem> supportIssueItems = [];
  response['data'].forEach((document) {
    supportIssueItems.add(IssueListItem.fromJson(document));
  });
  return supportIssueItems;
});
