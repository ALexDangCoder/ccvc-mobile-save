import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_bieu_quyet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_bieu_quyet_respone.g.dart';

@JsonSerializable()
class ChiTietBieuQuyetResponse {
  @JsonKey(name: 'data')
  DataChiTietBieuQuyetResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ChiTietBieuQuyetResponse(this.succeeded, this.code);

  factory ChiTietBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietBieuQuyetResponseToJson(this);

  ChiTietBieuQuyetModel toModel() => ChiTietBieuQuyetModel(
        data: data?.toModel() ?? DataBieuQuyet(),
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}

@JsonSerializable()
class DataChiTietBieuQuyetResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'idLichHop')
  String? idLichHop;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'loaiBieuQuyet')
  bool? loaiBieuQuyet;
  @JsonKey(name: 'quyenBieuQuyet')
  bool? quyenBieuQuyet;
  @JsonKey(name: 'thoiGianTaoMoi')
  String? thoiGianTaoMoi;
  @JsonKey(name: 'thoiGianCapNhat')
  String? thoiGianCapNhat;
  @JsonKey(name: 'isPublish')
  bool? isPublish;
  @JsonKey(name: 'dsLuaChon')
  List<DanhSachLuaChonResponse>? dsLuaChon;
  @JsonKey(name: 'dsThanhPhanThamGia')
  List<DanhSachThanhPhanThamGiaResponse>? dsThanhPhanThamGia;

  DataChiTietBieuQuyetResponse({
    this.id,
    this.idLichHop,
    this.trangThai,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.loaiBieuQuyet,
    this.quyenBieuQuyet,
    this.thoiGianTaoMoi,
    this.thoiGianCapNhat,
    this.isPublish,
    this.dsLuaChon,
    this.dsThanhPhanThamGia,
  });

  factory DataChiTietBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$DataChiTietBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataChiTietBieuQuyetResponseToJson(this);

  DataBieuQuyet toModel() => DataBieuQuyet(
        id: id,
        idLichHop: idLichHop,
        trangThai: trangThai,
        noiDung: noiDung,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianKetThuc: thoiGianKetThuc,
        loaiBieuQuyet: loaiBieuQuyet,
        quyenBieuQuyet: quyenBieuQuyet,
        thoiGianTaoMoi: thoiGianTaoMoi,
        thoiGianCapNhat: thoiGianCapNhat,
        isPublish: isPublish,
        dsLuaChon: dsLuaChon?.map((e) => e.toModel()).toList() ?? [],
        dsThanhPhanThamGia:
            dsThanhPhanThamGia?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DanhSachLuaChonResponse {
  @JsonKey(name: 'luaChonId')
  String? luaChonId;
  @JsonKey(name: 'tenLuaChon')
  String? tenLuaChon;
  @JsonKey(name: 'color')
  String? color;
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'dsCanBo')
  List<dynamic>? dsCanBo;

  DanhSachLuaChonResponse({
    this.luaChonId,
    this.tenLuaChon,
    this.color,
    this.count,
    this.dsCanBo,
  });

  factory DanhSachLuaChonResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLuaChonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLuaChonResponseToJson(this);

  DanhSachLuaChonModel toModel() => DanhSachLuaChonModel(
        luaChonId: luaChonId,
        tenLuaChon: tenLuaChon,
        color: color,
        count: count,
        dsCanBo: dsCanBo,
      );
}

@JsonSerializable()
class DanhSachThanhPhanThamGiaResponse {
  @JsonKey(name: 'bieuQuyetId')
  String? bieuQuyetId;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'id')
  String? id;

  DanhSachThanhPhanThamGiaResponse({
    this.bieuQuyetId,
    this.lichHopId,
    this.canBoId,
    this.hoTen,
    this.tenDonVi,
    this.donViId,
    this.id,
  });

  factory DanhSachThanhPhanThamGiaResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachThanhPhanThamGiaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachThanhPhanThamGiaResponseToJson(this);

  DanhSachThanhPhanThamGiaModel toModel() => DanhSachThanhPhanThamGiaModel(
        bieuQuyetId: bieuQuyetId,
        lichHopId: lichHopId,
        canBoId: canBoId,
        hoTen: hoTen,
        tenDonVi: tenDonVi,
        donViId: donViId,
        id: id,
      );
}
