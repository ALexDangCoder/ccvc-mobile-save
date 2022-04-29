import 'package:ccvc_mobile/data/response/account/data_login_response.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'data')
  DataLoginResponse? data;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'statusCode')
  int? statusCode;

  LoginResponse({
    this.data,
    this.succeeded,
    this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  DataLogin toModel() => DataLogin(
    dataUser:data?.toDomainDataUser(),
    succeeded:succeeded,
    statusCode: statusCode,
  );
}
