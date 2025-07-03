import 'package:json_annotation/json_annotation.dart';

part 'UserInfoModel.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String UID;
  final String uesr_name;
  final String email;
  final String phone_num;
  final String? image_profile;

  UserInfoModel({
    required this.UID,
    required this.uesr_name,
    required this.email,
    required this.phone_num,
    this.image_profile,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
