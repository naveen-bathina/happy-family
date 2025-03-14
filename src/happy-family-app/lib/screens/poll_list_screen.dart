import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/polls_provider.dart';
import 'package:fluttertest/screens/poll_result_screen.dart';
import 'package:fluttertest/screens/poll_voting_screen.dart';
import 'package:fluttertest/utils/formatters.dart';
import 'package:fluttertest/models/poll_list_item.dart';

class PollListScreen extends ConsumerWidget {
  const PollListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pollsAsyncValue = ref.watch(pollsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Family Polls'), centerTitle: true),
      body: pollsAsyncValue.when(
        data: (polls) {
          if (polls.isEmpty) {
            return const Center(
              child: Text(
                'No polls available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: polls.length,
            itemBuilder: (context, index) {
              final poll = polls[index];
              return _buildPollCard(context, poll);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Text(
                'Failed to load polls: $error',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
      ),
    );
  }

  // Helper function to build a poll card
  Widget _buildPollCard(BuildContext context, PollListItem poll) {
    final bool isExpired = DateTime.now().isAfter(poll.expiryDate);
    final bool hasVoted = poll.votedUsers.contains('user_123');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          poll.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Expiry: ${Formatters.formatDate(poll.expiryDate)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            _buildPollStatus(isExpired, hasVoted),
          ],
        ),
        trailing: _buildActionButton(context, poll, isExpired, hasVoted),
      ),
    );
  }

  // Helper function to build the poll status text
  Widget _buildPollStatus(bool isExpired, bool hasVoted) {
    if (isExpired) {
      return Text(
        'Poll Expired',
        style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold),
      );
    } else if (hasVoted) {
      return Text(
        'You have voted',
        style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'Open for voting',
        style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold),
      );
    }
  }

  // Helper function to build the action button
  Widget _buildActionButton(
    BuildContext context,
    PollListItem poll,
    bool isExpired,
    bool hasVoted,
  ) {
    if (hasVoted || isExpired) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PollResultScreen(poll: poll)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isExpired ? Colors.grey : Colors.green,
        ),
        child: const Text(
          'View Results',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PollVotingScreen(poll: poll)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: const Text('Vote', style: TextStyle(color: Colors.white)),
      );
    }
  }
}
