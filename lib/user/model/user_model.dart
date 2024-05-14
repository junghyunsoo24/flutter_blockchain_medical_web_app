// import 'package:json_annotation/json_annotation.dart';
// import '../../data_utils.dart';
//
// part 'user_model.g.dart';
//
// abstract class UserModelBase {}
//
// class UserModelError extends UserModelBase {
//   final String message;
//
//   UserModelError({
//     required this.message,
//   });
// }
//
// class UserModelLoading extends UserModelBase {}
//
// @JsonSerializable()
// class UserModel extends UserModelBase {
//   final String username;
//   final String password;
//   @JsonKey(
//     fromJson: DataUtils.pathToUrl,
//   )
//
//   UserModel({
//     required this.username,
//     required this.password,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);
// }