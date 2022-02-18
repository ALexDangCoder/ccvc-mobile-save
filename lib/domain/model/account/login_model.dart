import 'dart:convert';

LoginModel loginFromJson(String str) {
  return LoginModel.fromLogin(json.decode(str));
}

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? accessToken;
  String? refreshToken;

  LoginModel({
    this.accessToken,
    this.refreshToken,
  });

  LoginModel.init();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  LoginModel.fromLogin(dynamic json)
      : accessToken = json['accessToken'].toString(),
        refreshToken = json['refreshToken'].toString();
}
