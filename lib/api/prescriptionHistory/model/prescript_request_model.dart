class PrescriptionRequestModel {
  final String name; //이름
  final String birthday; //생년월일
  final String phone; //전화번호
  final String provider; //통신사

  PrescriptionRequestModel({
    required this.name,
    required this.birthday,
    required this.phone,
    required this.provider,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'provider': provider,
    };
  }
}
