import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/chat_provider.dart';
import 'individual_chat_screen.dart';
import 'group_chat_screen.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final lastMessages = chatState.lastMessages.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Chats'), centerTitle: true),
      body: ListView.builder(
        itemCount: lastMessages.length + 1, // +1 for group chat
        itemBuilder: (context, index) {
          if (index == 0) {
            // Group Chat
            return _buildChatTile(
              context,
              chatId: 'group_chat',
              name: 'Our Family Group Chat',
              lastMessage:
                  chatState.lastMessages['group_chat'] ?? 'Start chatting!',
              timestamp: DateTime.now(),
              avatarIcon: Icons.group,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GroupChatScreen(),
                    ),
                  ),
            );
          } else {
            // Individual Chat
            final chatId = lastMessages[index - 1];
            final lastMessage =
                chatState.lastMessages[chatId] ?? 'Start chatting!';
            final lastTimestamp =
                chatState.messages[chatId]?.last.timestamp ?? DateTime.now();

            return _buildChatTile(
              context,
              chatId: chatId,
              name: chatId, // Replace with member name from your API
              lastMessage: lastMessage,
              timestamp: lastTimestamp,
              avatarIcon: Icons.person,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => IndividualChatScreen(chatId: chatId),
                    ),
                  ),
            );
          }
        },
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context, {
    required String chatId,
    required String name,
    required String lastMessage,
    required DateTime timestamp,
    required IconData avatarIcon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(avatarIcon, color: Colors.white),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        _formatTime(timestamp),
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    if (timestamp.day == now.day &&
        timestamp.month == now.month &&
        timestamp.year == now.year) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
