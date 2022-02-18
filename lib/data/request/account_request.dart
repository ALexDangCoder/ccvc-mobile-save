import 'package:json_annotation/json_annotation.dart';

part 'account_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String username;
  final String password;
  final String appCode;

  LoginRequest({
    required this.username,
    required this.password,
    required this.appCode,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
