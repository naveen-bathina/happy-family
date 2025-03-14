import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/chat_message.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';

class ChatState {
  final Map<String, List<ChatMessage>> messages;
  final Map<String, String> lastMessages;
  final bool isLoading;

  ChatState({
    required this.messages,
    required this.lastMessages,
    required this.isLoading,
  });

  ChatState copyWith({
    Map<String, List<ChatMessage>>? messages,
    Map<String, String>? lastMessages,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      lastMessages: lastMessages ?? this.lastMessages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;

  ChatNotifier(this.ref)
    : super(ChatState(messages: {}, lastMessages: {}, isLoading: false));

  Future<void> fetchMessages(String chatId) async {
    state = state.copyWith(isLoading: true);
    try {
      final dataStore = ref.read(dataStoreProvider);
      final response = await dataStore.fetchDataFromNetwork(
        '${AppConstants.unsecuredApiUrl}${AppConstants.getChatMessagesEndpoint}/$chatId',
      );

      List<ChatMessage> chatMessages =
          response['data']
              .map<ChatMessage>((msg) => ChatMessage.fromJson(msg))
              .toList();

      final updatedMessages = {...state.messages, chatId: chatMessages};
      final updatedLastMessages = {...state.lastMessages};

      if (chatMessages.isNotEmpty) {
        updatedLastMessages[chatId] = chatMessages.last.text;
      }

      state = state.copyWith(
        messages: updatedMessages,
        lastMessages: updatedLastMessages,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendMessage(String chatId, ChatMessage message) async {
    try {
      final dataStore = ref.read(dataStoreProvider);
      await dataStore.syncDataWithNetwork(
        '${AppConstants.unsecuredApiUrl}${AppConstants.sendMessageEndpoint}/$chatId',
        chatId,
      );

      final updatedMessages = {...state.messages};
      updatedMessages.putIfAbsent(chatId, () => []).add(message);

      final updatedLastMessages = {...state.lastMessages};
      updatedLastMessages[chatId] = message.text;

      state = state.copyWith(
        messages: updatedMessages,
        lastMessages: updatedLastMessages,
      );
    } catch (error) {
      // Handle error
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});

final lastMessagesProvider = Provider<Map<String, String>>((ref) {
  return ref.watch(chatProvider).lastMessages;
});
