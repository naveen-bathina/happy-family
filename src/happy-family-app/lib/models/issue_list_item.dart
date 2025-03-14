class IssueListItem {
  final String id;
  final String title;
  final DateTime reportedDate;
  final String status;

  IssueListItem({
    required this.id,
    required this.title,
    required this.reportedDate,
    required this.status,
  });

  factory IssueListItem.fromJson(Map<String, dynamic> json) => IssueListItem(
    id: json['id'] as String,
    title: json['title'] as String,
    reportedDate: DateTime.parse(json['reportedDate'] as String),
    status: json['status'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'reportedDate': reportedDate.toIso8601String(),
    'status': status,
  };
}
