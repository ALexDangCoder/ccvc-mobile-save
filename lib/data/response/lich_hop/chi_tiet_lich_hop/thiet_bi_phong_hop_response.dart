import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';

class ThietBiPhongHopResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ThietBiPhongHopResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ThietBiPhongHopResponse.fromJson(Map<String, dynamic> json) {
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
  String? tenThietBi;
  String? soLuong;
  int? trangThai;
  String? tenTrangThai;

  Data(
      {this.id,
      this.tenThietBi,
      this.soLuong,
      this.trangThai,
      this.tenTrangThai});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenThietBi = json['tenThietBi'];
    soLuong = json['soLuong'];
    trangThai = json['trangThai'];
    tenTrangThai = json['tenTrangThai'];
  }
  ThietBiPhongHopModel toDomain() => ThietBiPhongHopModel(
        trangThai: trangThai ?? 0,
        loaiThietBi: tenThietBi ?? '',
        soLuong: soLuong ?? '0',
      );
}
