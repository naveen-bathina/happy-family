import 'package:flutter/material.dart';
import 'package:fluttertest/models/poll_list_item.dart';
import 'package:fluttertest/screens/poll_result_screen.dart';

class PollVotingScreen extends StatefulWidget {
  final PollListItem poll;
  const PollVotingScreen({super.key, required this.poll});

  @override
  _PollVotingScreenState createState() => _PollVotingScreenState();
}

class _PollVotingScreenState extends State<PollVotingScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting'), // Updated page title
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poll title in the body
            Text(
              widget.poll.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select an option:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children:
                    widget.poll.options.map((option) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: RadioListTile<String>(
                          title: Text(
                            option.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: option.id,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() => selectedOption = value);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectedOption != null ? _submitVote : null,
        backgroundColor:
            selectedOption != null
                ? Theme.of(context).primaryColor
                : Colors.grey,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }

  void _submitVote() {
    if (selectedOption != null) {
      // Simulate adding the user to the voted users list
      widget.poll.votedUsers.add('user_123');

      // Navigate to the results screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PollResultScreen(poll: widget.poll)),
      );

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your vote has been submitted!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
