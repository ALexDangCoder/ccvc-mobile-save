import 'package:json_annotation/json_annotation.dart';

part 'sua_bieu_quyet_request.g.dart';

@JsonSerializable()
class SuaBieuQuyetRequest {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'loaiBieuQuyet')
  bool? loaiBieuQuyet;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'quyenBieuQuyet')
  bool? quyenBieuQuyet;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'danhSachLuaChon')
  List<DanhSachLuaChonNew>? danhSachLuaChon;
  @JsonKey(name: 'danhSachThanhPhanThamGia')
  List<dynamic>? danhSachThanhPhanThamGia;
  @JsonKey(name: 'ngayHop')
  String? ngayHop;
  @JsonKey(name: 'isPublish')
  bool? isPublish;
  @JsonKey(name: 'dsLuaChonOld')
  List<DsLuaChonOld>? dsLuaChonOld;
  @JsonKey(name: 'thanhPhanThamGiaOld')
  List<ThanhPhanThamGiaOld>? thanhPhanThamGiaOld;
  @JsonKey(name: 'dateStart')
  String? dateStart;
  @JsonKey(name: 'DanhSachThanhPhanThamGia')
  List<DanhSachThanhPhanThamGiaNew>? danhSachThanhPhanThamGiaNew;

  SuaBieuQuyetRequest({
    required this.id,
    required this.lichHopId,
    required this.loaiBieuQuyet,
    required this.noiDung,
    required this.quyenBieuQuyet,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.danhSachLuaChon,
    required this.danhSachThanhPhanThamGia,
    required this.ngayHop,
    required this.isPublish,
    required this.dsLuaChonOld,
    required this.thanhPhanThamGiaOld,
    required this.dateStart,
    required this.danhSachThanhPhanThamGiaNew,
  });

  factory SuaBieuQuyetRequest.fromJson(Map<String, dynamic> json) =>
      _$SuaBieuQuyetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SuaBieuQuyetRequestToJson(this);
}

@JsonSerializable()
class DanhSachLuaChonNew {
  String? id;
  String? tenLuaChon;
  String? mauBieuQuyet;

  DanhSachLuaChonNew({
     this.id,
     this.tenLuaChon,
     this.mauBieuQuyet,
  });

  factory DanhSachLuaChonNew.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLuaChonNewFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLuaChonNewToJson(this);
}

@JsonSerializable()
class DsLuaChonOld {
  String? luaChonId;
  String? tenLuaChon;
  String? color;
  int? count;
  List<dynamic>? dsCanBo;

  DsLuaChonOld({
    required this.luaChonId,
    required this.tenLuaChon,
    required this.color,
    required this.count,
    required this.dsCanBo,
  });

  factory DsLuaChonOld.fromJson(Map<String, dynamic> json) =>
      _$DsLuaChonOldFromJson(json);

  Map<String, dynamic> toJson() => _$DsLuaChonOldToJson(this);
}

@JsonSerializable()
class ThanhPhanThamGiaOld {
  String? bieuQuyetId;
  String? lichHopId;
  String? canBoId;
  String? hoTen;
  String? tenDonVi;
  String? donViId;
  String? id;

  ThanhPhanThamGiaOld({
    required this.bieuQuyetId,
    required this.lichHopId,
    required this.canBoId,
    required this.hoTen,
    required this.tenDonVi,
    required this.donViId,
    required this.id,
  });

  factory ThanhPhanThamGiaOld.fromJson(Map<String, dynamic> json) =>
      _$ThanhPhanThamGiaOldFromJson(json);

  Map<String, dynamic> toJson() => _$ThanhPhanThamGiaOldToJson(this);
}

@JsonSerializable()
class DanhSachThanhPhanThamGiaNew {
  String? donViId;
  String? canBoId;
  String? idPhienhopCanbo;

  DanhSachThanhPhanThamGiaNew({
    required this.donViId,
    required this.canBoId,
    required this.idPhienhopCanbo,
  });

  factory DanhSachThanhPhanThamGiaNew.fromJson(Map<String, dynamic> json) =>
      _$DanhSachThanhPhanThamGiaNewFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachThanhPhanThamGiaNewToJson(this);
}
