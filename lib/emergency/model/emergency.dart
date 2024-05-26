class Emergency {
  final int id;
  final String uid;
  final String content;

  Emergency({
    required this.id,
    required this.uid,
    required this.content,
  });

  factory Emergency.fromJson(Map<String, dynamic> json) {
    return Emergency(
      id: json['id'],
      uid: json['uid'],
      content: json['content'],
    );
  }

}
