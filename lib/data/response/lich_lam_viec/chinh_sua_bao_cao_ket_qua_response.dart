import 'package:ccvc_mobile/domain/model/message_model.dart';

class ChinhSuaBaoCaoKetQuaResponse {
  String? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ChinhSuaBaoCaoKetQuaResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ChinhSuaBaoCaoKetQuaResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
  MessageModel toDomain() => MessageModel(
        code: code ?? '',
        succeeded: succeeded ?? false,
      );
}
