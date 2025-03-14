import 'package:flutter/material.dart';
import 'package:fluttertest/Models/issue_list_item.dart';
import 'package:fluttertest/utils/formatters.dart';
import 'new_support_request_screen.dart';

class SupportScreen extends StatelessWidget {
  // Sample data for issues reported by the member
  final List<IssueListItem> reportedIssues = [
    IssueListItem(
      id: 'issue1',
      title: 'Login Support',
      reportedDate: DateTime.now().subtract(Duration(days: 5)),
      status: 'Resolved',
    ),
    IssueListItem(
      id: 'issue2',
      title: 'App Crashing on Startup',
      reportedDate: DateTime.now().subtract(Duration(days: 10)),
      status: 'In Progress',
    ),
    IssueListItem(
      id: 'issue3',
      title: 'Unable to Download Files',
      reportedDate: DateTime.now().subtract(Duration(days: 15)),
      status: 'Pending',
    ),
  ];

  SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suppport'), centerTitle: true),
      body: Column(
        children: [
          // Body content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Relationship Manager Section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'John Doe \n(Your Relationship Manager)',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Issues History Section
                  Text(
                    'Support Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reportedIssues.length,
                      itemBuilder: (context, index) {
                        final issue = reportedIssues[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              issue.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reported on: ${Formatters.formatDate(issue.reportedDate)}',
                                ),
                                Text('Status: ${issue.status}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button to add new request
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSupportRequestScreen()),
          );
        },
        tooltip: 'Add New Request',
        child: Icon(Icons.add),
      ),
    );
  }
}
