import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/todo_item.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/providers/data_store.dart';

/// StateNotifierProvider for managing the Todo list
final todoProvider = StateNotifierProvider<TodoNotifier, List<TodoItem>>((ref) {
  final dataStore = ref.watch(dataStoreProvider);
  return TodoNotifier(dataStore);
});

/// Notifier class to manage Todo list operations
class TodoNotifier extends StateNotifier<List<TodoItem>> {
  final DataStore dataStore;

  TodoNotifier(this.dataStore) : super([]) {
    fetchTodos(); // Fetch todos on initialization
  }

  /// Fetch todo list from API
  Future<void> fetchTodos() async {
    try {
      final response = await dataStore.fetchDataFromNetwork(
        '${AppConstants.unsecuredApiUrl}${AppConstants.getTodoListEndpoint}',
      );

      if (response != null && response['data'] is List) {
        state =
            response['data']
                .map<TodoItem>((item) => TodoItem.fromJson(item))
                .toList();
      } else {
        state = [];
      }
    } catch (e) {
      print("Error fetching todos: $e");
      state = []; // Handle error by setting an empty list
    }
  }

  /// Toggle todo completion status
  void toggleTodo(TodoItem task) {
    state =
        state
            .map(
              (t) =>
                  t.id == task.id
                      ? t.copyWith(
                        isCompleted: !t.isCompleted,
                      ) // Ensure copyWith exists
                      : t,
            )
            .toList();
  }

  /// Add a new todo item
  void addTodo(TodoItem task) {
    state = [...state, task];
  }

  /// Remove a todo item by ID
  void removeTodo(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}
