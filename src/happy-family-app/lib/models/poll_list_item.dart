// Poll class to define each poll with options and votes
class PollListItem {
  final String id;
  final String title;
  final String description;
  final DateTime expiryDate;
  final List<PollOption> options;
  String? selectedOption;
  final Map<String, int> votes = {}; // Store vote counts for each option
  final Set<String> votedUsers = {}; // Track users who have voted

  PollListItem({
    required this.id,
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.options,
  });

  factory PollListItem.fromJson(Map<String, dynamic> json) {
    return PollListItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      expiryDate: DateTime.parse(json['expiryDate']),
      options:
          json['options'].map<PollOption>((option) {
            return PollOption.fromJson(option);
          }).toList(),
    );
  }
}

class PollOption {
  final String id;
  final String title;
  final int votes;

  PollOption({required this.id, required this.title, required this.votes});

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      title: json['title'],
      votes: json['votes'],
    );
  }
}
