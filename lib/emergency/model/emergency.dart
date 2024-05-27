class Emergency {
  final int? id;
  final String? uid;
  final String? doctorId;
  final String content;
  final String? reason;
  final DateTime? date;
  int get length => 1;
  Emergency({
    this.id,
    this.uid,
    this.doctorId,
    required this.content,
    this.reason,
    this.date
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

  factory Emergency.myEmergencyDataHistoryFromJson(Map<String, dynamic> json) {
    return Emergency(
      doctorId: json['doctorId'],
      reason: json['reason'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      content: json['content']
    );
  }
}
