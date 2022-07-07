import 'package:ccvc_mobile/domain/model/account/unauthorized_model.dart';

class UnauthorizedResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;

  UnauthorizedResponse({
    this.data,
    this.statusCode,
    this.succeeded,
  });

  UnauthorizedResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }
  UnauthorizedModel toModel() =>
      UnauthorizedModel(data?.accessToken ?? '', data?.refreshToken ?? '');
}

class Data {
  String? accessToken;
  String? refreshToken;

  Data({this.accessToken, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
