import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';

class ThongTinPhongHopResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ThongTinPhongHopResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ThongTinPhongHopResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? id;
  String? lichHopPhongHopId;
  String? tenPhong;
  String? sucChua;
  String? diaDiem;
  String? thietBiCoSan;
  String? noiDungYeuCau;
  int? trangThai;
  String? tenTrangThai;

  String? trangThaiChuanBi;

  Data(
      {this.id,
      this.lichHopPhongHopId,
      this.tenPhong,
      this.sucChua,
      this.diaDiem,
      this.thietBiCoSan,
      this.noiDungYeuCau,
      this.trangThai,
      this.tenTrangThai,
      this.trangThaiChuanBi});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lichHopPhongHopId = json['lichHopPhongHopId'];
    tenPhong = json['tenPhong'];
    sucChua = json['sucChua'];
    diaDiem = json['diaDiem'];
    thietBiCoSan = json['thietBiCoSan'];
    noiDungYeuCau = json['noiDungYeuCau'];
    trangThai = json['trangThai'];
    tenTrangThai = json['tenTrangThai'];
    trangThaiChuanBi = json['trangThaiChuanBi'];
  }
  ThongTinPhongHopModel toDomain() => ThongTinPhongHopModel(
        id: id ?? '',
        trangThai: trangThai ?? 0,
        thietBiSanCo: thietBiCoSan ?? '',
        tenPhong: tenPhong ?? '',
        diaDiem: diaDiem ?? '',
        sucChua: sucChua ?? '0',
      );
}
