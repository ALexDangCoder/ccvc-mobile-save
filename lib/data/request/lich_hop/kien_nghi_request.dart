import 'package:json_annotation/json_annotation.dart';

part 'kien_nghi_request.g.dart';

@JsonSerializable()
class BieuQuyetRequest {
  @JsonKey(name: 'DanhSachThanhPhanThamGia')
  List<DanhSachThanhPhanThamGia> danhSachThanhPhanThamGia;
  List<DanhSachLuaChon> danhSachLuaChon;
  String? dateStart;
  String? lichHopId;
  bool? loaiBieuQuyet;
  String? noiDung;
  bool? quyenBieuQuyet;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  int? trangThai;
  BieuQuyetRequest({
    required this.danhSachThanhPhanThamGia,
    required this.danhSachLuaChon,
    this.dateStart,
    this.lichHopId,
    this.loaiBieuQuyet,
    this.noiDung,
    this.quyenBieuQuyet,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.trangThai,
  });
  factory BieuQuyetRequest.fromJson(Map<String, dynamic> json) =>
      _$BieuQuyetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BieuQuyetRequestToJson(this);
}
@JsonSerializable()
class DanhSachLuaChon {
  String? tenLuaChon;
  String? mauBieuQuyet;

  DanhSachLuaChon({this.tenLuaChon, this.mauBieuQuyet});
  factory DanhSachLuaChon.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLuaChonFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLuaChonToJson(this);
}
@JsonSerializable()
class DanhSachThanhPhanThamGia {
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'IdPhienhopCanbo')
  String? idPhienhopCanbo;
  DanhSachThanhPhanThamGia({this.canBoId, this.donViId, this.idPhienhopCanbo});
  factory DanhSachThanhPhanThamGia.fromJson(Map<String, dynamic> json) =>
      _$DanhSachThanhPhanThamGiaFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachThanhPhanThamGiaToJson(this);
}