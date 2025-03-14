import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data_store.dart';
import 'data_state_notifier.dart';

// Provide a single instance of DataStore
final dataStoreProvider = Provider<DataStore>((ref) => DataStore());

// Provide a StateNotifier with the injected DataStore
final dataProvider =
    StateNotifierProvider<DataStateNotifier, AsyncValue<dynamic>>(
      (ref) => DataStateNotifier(ref.watch(dataStoreProvider)),
    );
