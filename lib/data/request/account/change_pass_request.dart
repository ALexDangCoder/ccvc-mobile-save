import 'package:json_annotation/json_annotation.dart';

part 'change_pass_request.g.dart';

@JsonSerializable()
class ChangePassRequest {
  final String passwordOld;
  final String password;
  final String repeatPassword;

  ChangePassRequest({
    required this.passwordOld,
    required this.password,
    required this.repeatPassword,
  });

  factory ChangePassRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePassRequestToJson(this);
}
