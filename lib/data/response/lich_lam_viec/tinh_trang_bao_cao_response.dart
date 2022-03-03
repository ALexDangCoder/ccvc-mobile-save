import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';

class ListTinhTrangResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ListTinhTrangResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ListTinhTrangResponse.fromJson(Map<String, dynamic> json) {
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
  String? displayName;
  String? code;
  String? type;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? id;

  Data(
      {this.displayName,
      this.code,
      this.type,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    code = json['code'];
    type = json['type'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    id = json['id'];
  }
  TinhTrangBaoCaoModel toDomain() =>
      TinhTrangBaoCaoModel(id: id, displayName: displayName);
}
