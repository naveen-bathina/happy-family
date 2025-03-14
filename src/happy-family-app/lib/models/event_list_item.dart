class EventListItem {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final bool isJoined;
  final bool isUpcoming;
  final String host;
  final String location;

  EventListItem({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isJoined,
    required this.isUpcoming,
    required this.host,
    required this.location,
  });

  factory EventListItem.fromJson(Map<String, dynamic> json) {
    return EventListItem(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isJoined: json['isJoined'],
      isUpcoming: DateTime.parse(json['startDate']).isAfter(DateTime.now()),
      host: json['host'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'isJoined': isJoined,
    'isUpcoming': isUpcoming,
    'host': host,
    'location': location,
  };
}
