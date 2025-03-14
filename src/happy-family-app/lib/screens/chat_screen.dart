// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertest/providers/member_provider.dart';
// import 'individual_chat_screen.dart';
// import 'group_chat_screen.dart';
// import 'package:fluttertest/providers/chat_provider.dart';

// class ChatScreen extends ConsumerWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chatState = ref.watch(chatProvider);
//     final membersProvider = ref.watch(memberProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chats'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: members.length + 1, // +1 for group chat
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return ListTile(
//               leading: const CircleAvatar(
//                 backgroundColor: Colors.blueAccent,
//                 child: const Icon(Icons.group, color: Colors.white),
//               ),
//               title: const Text(
//                 'Family Group Chat',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 chatState.lastMessages['group'] ?? 'Tap to start chatting',
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const GroupChatScreen(),
//                   ),
//                 );
//               },
//             );
//           } else {
//             final member = members[index - 1];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage(member.avatarUrl),
//               ),
//               title: Text(
//                 member.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 chatState.lastMessages[member.id] ?? 'Tap to start chatting',
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => IndividualChatScreen(member: member),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
