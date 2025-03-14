import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/event_list_item.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';

final eventsProvider = FutureProvider<List<EventListItem>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getAllEventsEndpoint}',
  );

  if (response == null ||
      response['hasError'] == true ||
      response['data'] == null) {
    return [];
  }

  List<EventListItem> calendarEvents = [];
  response['data'].forEach((eventItem) {
    calendarEvents.add(EventListItem.fromJson(eventItem));
  });
  return calendarEvents;
});
