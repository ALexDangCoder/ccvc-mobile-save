import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';

class DanhSachNhiemVulichHopResponse {
  List<Data>? data;

  DanhSachNhiemVulichHopResponse({
    this.data,
  });

  DanhSachNhiemVulichHopResponse.fromJson(Map<String, dynamic> json) {
    data = json.values.map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  String? id;
  String? ma;
  bool? nhiemVuChinhPhu;
  String? ten;

  Data({
    this.id,
    this.ma,
    this.nhiemVuChinhPhu,
    this.ten,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    ma = json['Ma'];
    nhiemVuChinhPhu = json['NhiemVuChinhPhu'];
    ten = json['Ten'];
  }

  DanhSachLoaiNhiemVuLichHopModel toDomain() => DanhSachLoaiNhiemVuLichHopModel(
        id: id ?? '',
        ma: ma ?? '',
        nhiemVuChinhPhu: nhiemVuChinhPhu,
        ten: ten ?? '',
      );
}
