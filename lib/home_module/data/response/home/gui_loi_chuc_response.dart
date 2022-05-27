import 'package:ccvc_mobile/home_module/domain/model/home/message_model.dart';

class GuiLoiChucResponse {
  bool? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  GuiLoiChucResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  GuiLoiChucResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }

  MessageModel toDomain() =>
      MessageModel(succeeded: succeeded ?? false, message: message ?? '');
}
