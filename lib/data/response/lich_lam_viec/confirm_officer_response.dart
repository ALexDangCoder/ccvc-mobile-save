import 'package:ccvc_mobile/domain/model/message_model.dart';

class ConfirmOfficerResponse {
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ConfirmOfficerResponse(
      {this.statusCode, this.succeeded, this.code, this.message});

  ConfirmOfficerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }

  MessageModel toDomain() =>
      MessageModel(code: code ?? '', succeeded: succeeded ?? false);
}
