import 'package:ccvc_mobile/data/response/account/data_login_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  @JsonKey(name: 'data')
  DataLoginResponse data;

  LoginResponse(this.data);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
