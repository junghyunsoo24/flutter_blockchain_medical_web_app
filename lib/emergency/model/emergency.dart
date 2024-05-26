class Emergency {
  final int? id;
  final String? uid;
  final String content;
  int get length => 1;
  Emergency({
    this.id,
    this.uid,
    required this.content,
  });

  factory Emergency.fromJson(Map<String, dynamic> json) {
    return Emergency(
      id: json['id'],
      uid: json['uid'],
      content: json['content'],
    );
  }

  factory Emergency.myUrgentContentFromJson(Map<String, dynamic> json) {
    return Emergency(
      content: json['myUrgentContent'],
    );
  }
}
