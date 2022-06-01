import 'package:ccvc_mobile/domain/model/account/forgot_password_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: 'message')
  String? messages;
  @JsonKey(name: 'succeeded')
  bool? isSuccess;
  @JsonKey(name: 'statusCode')
  int? statusCode;

  ForgotPasswordResponse({
    this.messages,
    this.isSuccess,
    this.statusCode,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  ForgotPasswordModel toModel() => ForgotPasswordModel(
        messages: messages,
        isSuccess: isSuccess,
        statusCode: statusCode,
      );
}
