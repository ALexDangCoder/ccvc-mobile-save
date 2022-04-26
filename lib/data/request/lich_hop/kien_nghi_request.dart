import 'package:json_annotation/json_annotation.dart';

part 'kien_nghi_request.g.dart';

@JsonSerializable()
class BieuQuyetRequest {
  @JsonKey(name: 'dateStart')
  String? dateStart;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'loaiBieuQuyet')
  bool? loaiBieuQuyet;
  @JsonKey(name: 'danhSachLuaChon')
  List<DanhSachLuaChon>? danhSachLuaChon;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'quyenBieuQuyet')
  bool? quyenBieuQuyet;
  @JsonKey(name: 'DanhSachThanhPhanThamGia')
  List<DanhSachThanhPhanThamGia>? danhSachThanhPhanThamGia;

  BieuQuyetRequest({
    required this.dateStart,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.loaiBieuQuyet,
    required this.danhSachLuaChon,
    required this.noiDung,
    required this.lichHopId,
    required this.trangThai,
    required this.quyenBieuQuyet,
    required this.danhSachThanhPhanThamGia,
  });

  factory BieuQuyetRequest.fromJson(Map<String, dynamic> json) =>
      _$BieuQuyetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BieuQuyetRequestToJson(this);
}

@JsonSerializable()
class DanhSachLuaChon {
  @JsonKey(name: 'tenLuaChon')
  String? tenLuaChon;
  @JsonKey(name: 'mauBieuQuyet')
  String? mauBieuQuyet;

  DanhSachLuaChon({required this.tenLuaChon, required this.mauBieuQuyet});

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

  DanhSachThanhPhanThamGia({
    required this.canBoId,
    required this.donViId,
    required this.idPhienhopCanbo,
  });

  factory DanhSachThanhPhanThamGia.fromJson(Map<String, dynamic> json) =>
      _$DanhSachThanhPhanThamGiaFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachThanhPhanThamGiaToJson(this);
}
