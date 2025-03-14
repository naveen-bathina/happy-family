class TodoItem {
  final String id;
  final String title;
  final DateTime dueDate;
  final bool isCompleted;
  final String assignedTo;
  final String assignedBy;

  TodoItem({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
    required this.assignedTo,
    required this.assignedBy,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'],
      assignedTo: json['assignedTo'],
      assignedBy: json['assignedBy'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
    'assignedTo': assignedTo,
    'assignedBy': assignedBy,
  };

  TodoItem copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    bool? isCompleted,
    String? assignedTo,
    String? assignedBy,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
    );
  }
}
