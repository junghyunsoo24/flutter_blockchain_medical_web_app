class Question {
  final int id;
  final String uid;
  final String title;
  final String category;
  final String symptom;
  final String content;
  final List<String> bodyParts;
  final dynamic personalData;

  Question({
    required this.id,
    required this.uid,
    required this.title,
    required this.category,
    required this.symptom,
    required this.content,
    required this.bodyParts,
    this.personalData,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      uid: json['uid'],
      title: json['title'],
      category: json['category'],
      symptom: json['symptom'],
      content: json['content'],
      bodyParts: List<String>.from(json['bodyParts']),
      personalData: json['personalData'],
    );
  }
}
