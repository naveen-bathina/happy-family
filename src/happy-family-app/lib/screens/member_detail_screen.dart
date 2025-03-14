import 'package:flutter/material.dart';
import 'package:fluttertest/models/family_member_info.dart';

class MemberDetailsScreen extends StatelessWidget {
  final FamilyMemberInfo member;

  // Constructor to accept the member data
  const MemberDetailsScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and name section
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(member.displayPicture),
                radius: 50,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '${member.firstName} ${member.lastName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                '${member.role} - ${member.relation}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 24),

            // Call and Chat buttons
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Chat button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle chat action
                      print('Chat with ${member.firstName} ${member.lastName}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.chat, color: Colors.white, size: 18),
                    label: const Text(
                      'Chat',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8), // Spacing between buttons
                  // Call button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle call action
                      print('Call ${member.firstName} ${member.lastName}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.call, color: Colors.white, size: 18),
                    label: const Text(
                      'Call',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Contact details
            Text('Contact: ${member.contactNumber}'),
            SizedBox(height: 8),
            Text('Email: ${member.emailAddress}'),
            SizedBox(height: 8),
            Text('Address: ${member.address}'),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
