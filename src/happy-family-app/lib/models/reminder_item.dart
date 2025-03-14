class ReminderItem {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime time;
  final bool isCompleted;
  final String assignedTo;
  final String assignedBy;

  ReminderItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.assignedTo,
    required this.assignedBy,
  });

  factory ReminderItem.fromJson(Map<String, dynamic> json) {
    return ReminderItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      isCompleted: json['isCompleted'],
      assignedTo: json['assignedTo'],
      assignedBy: json['assignedBy'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'time': time.toIso8601String(),
    'isCompleted': isCompleted,
    'assignedTo': assignedTo,
    'assignedBy': assignedBy,
  };
}
