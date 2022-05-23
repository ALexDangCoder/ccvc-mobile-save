import 'package:ccvc_mobile/domain/model/home/sinh_nhat_model.dart';

class SinhNhatUserResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  SinhNhatUserResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  SinhNhatUserResponse.fromJson(Map<String, dynamic> json) {
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
  String? canBoId;
  String? gioiTinh;
  String? ngaySinh;
  String? tenCanBo;
  String? email;

  Data({this.canBoId, this.gioiTinh, this.ngaySinh, this.tenCanBo, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    canBoId = json['canBoId'];
    gioiTinh = json['gioiTinh'];
    ngaySinh = json['ngaySinh'];
    tenCanBo = json['tenCanBo'];
    email = json['email'];
  }
  SinhNhatUserModel toDomain() => SinhNhatUserModel(
        canBoId: canBoId ?? '',
        ngaySinh: ngaySinh ?? '',
        tenCanBo: tenCanBo ?? '',
        gioiTinh: gioiTinh ?? '',
        email: email ?? '',
      );
}
