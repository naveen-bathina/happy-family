import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data_store.dart';

class DataStateNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final DataStore _dataStore;

  // Injecting DataStore for better testability and flexibility
  DataStateNotifier(this._dataStore) : super(const AsyncValue.loading());

  /// Fetch data from local storage or network
  Future<void> fetchData(String key, String endpoint) async {
    try {
      state = const AsyncValue.loading();

      // Check if data exists locally
      final localData = await _dataStore.getDataLocally(key);
      if (localData != null) {
        state = AsyncValue.data(localData);
        return;
      }

      // Fetch from network if no local data
      final networkData = await _dataStore.fetchDataFromNetwork(endpoint);
      if (networkData != null) {
        await _dataStore.saveDataLocally(key, networkData); // Cache it
        state = AsyncValue.data(networkData);
      } else {
        state = AsyncValue.error(
          'Failed to fetch data from the network',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error: $e', stackTrace);
    }
  }

  /// Sync local data with the network
  Future<void> syncData(String endpoint, String localStorageKey) async {
    try {
      await _dataStore.syncDataWithNetwork(endpoint, localStorageKey);
      await fetchData(localStorageKey, endpoint);
    } catch (e, stackTrace) {
      state = AsyncValue.error('Sync Error: $e', stackTrace);
    }
  }
}
