import 'package:flutter/material.dart';

class NewSupportRequestScreen extends StatefulWidget {
  const NewSupportRequestScreen({super.key});

  @override
  _NewSupportRequestScreenState createState() =>
      _NewSupportRequestScreenState();
}

class _NewSupportRequestScreenState extends State<NewSupportRequestScreen> {
  final _titleController = TextEditingController();
  final String _selectedStatus = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Support Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Issue Title:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Enter issue title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle adding the new support request
                // final newIssue = IssueListItem(
                //   title: _titleController.text,
                //   reportedDate: DateTime.now(),
                //   status: _selectedStatus,
                // );
                // Ideally, save this new issue to your database or state management solution
                Navigator.pop(context); // Go back after adding the request
              },
              child: Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
