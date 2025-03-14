class Document {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String author;
  final String fileType;
  final String downloadUrl;

  // Constructor
  Document({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
    required this.fileType,
    required this.downloadUrl,
  });

  // Convert JSON to Document object
  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      author: json['author'],
      fileType: json['fileType'],
      downloadUrl: json['downloadUrl'],
    );
  }

  // Convert Document object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'author': author,
      'fileType': fileType,
      'downloadUrl': downloadUrl,
    };
  }
}
