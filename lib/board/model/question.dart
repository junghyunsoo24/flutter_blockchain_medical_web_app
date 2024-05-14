class Question {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;

  Question({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
