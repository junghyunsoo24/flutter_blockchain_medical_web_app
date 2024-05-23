class Comments {
  final int id;
  final String userId;
  final String content;
  final DateTime createDate;
  final DateTime? lastModifiedDate;

  Comments({
    required this.id,
    required this.userId,
    required this.content,
    required this.createDate,
    this.lastModifiedDate,
  });

  factory Comments.fromInsertJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'] as int,
      content: json['content'] as String,
      userId: json['userId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'] as int,
      content: json['content'] as String,
      userId: json['userId'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );
  }

}
