import 'package:json_annotation/json_annotation.dart';

part 'new_member_request.g.dart';

@JsonSerializable()
class NewUserRequest {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'fullname')
  String? fullName;
  @JsonKey(name: 'birthday')
  String? birthday;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'position')
  String? position;
  @JsonKey(name: 'unit')
  String? unit;
  @JsonKey(name: 'description')
  String? description;

  NewUserRequest({
    this.email,
    this.fullName,
    this.phone,
    this.position,
    this.unit,
    this.description,
    this.birthday,
  });

  factory NewUserRequest.fromJson(Map<String, dynamic> json) =>
      _$NewUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserRequestToJson(this);
}
