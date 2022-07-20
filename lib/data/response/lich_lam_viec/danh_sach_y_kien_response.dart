import 'package:ccvc_mobile/domain/model/y_kien_model.dart';

class DanhSachYKienResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachYKienResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  DanhSachYKienResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? id;
  String? scheduleId;
  String? content;
  String? nguoiTao;
  String? ngayTao;
  String? nguoiTaoId;

  Data({
    this.id,
    this.scheduleId,
    this.content,
    this.nguoiTao,
    this.ngayTao,
    this.nguoiTaoId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['scheduleId'];
    content = json['content'];
    nguoiTao = json['nguoiTao'];
    ngayTao = json['ngayTao'];
    nguoiTaoId = json['nguoiTaoId'];
  }

  YKienModel toDomain() => YKienModel(
        time: ngayTao ?? DateTime.now().toString(),
        fileName: '',
        imgAvatar: '',
        name: nguoiTao ?? '',
        content: content ?? '',
      );
}
