import 'package:flutter/material.dart';
import 'package:fluttertest/models/poll_list_item.dart';

class PollResultScreen extends StatelessWidget {
  final PollListItem poll;
  const PollResultScreen({super.key, required this.poll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll Results'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poll title
            Text(
              poll.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            // Total votes
            const SizedBox(height: 16),
            Text(
              'Total Votes: ${_calculateTotalVotes()}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to calculate total votes
  int _calculateTotalVotes() {
    return poll.options.fold(0, (sum, option) => sum + (option.votes ?? 0));
  }
}