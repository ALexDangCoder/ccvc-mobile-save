import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_lich_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_bieu_quyet_lich_hop_response.g.dart';

@JsonSerializable()
class DanhSachBieuQuyetLichHopDataResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DanhSachBieuQuyetLichHopResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DanhSachBieuQuyetLichHopDataResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DanhSachBieuQuyetLichHopDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachBieuQuyetLichHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachBieuQuyetLichHopDataResponseToJson(this);

  List<DanhSachBieuQuyetLichHopModel> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachBieuQuyetLichHopResponse extends Equatable {
  @JsonKey(name: 'tenChucVu')
  String? tenChucVu;
  @JsonKey(name: 'diemDanh')
  bool? diemDanh;
  @JsonKey(name: 'disable')
  bool? disable;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'isVangMat')
  bool? isVangMat;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'vaiTro')
  String? vaiTro;
  @JsonKey(name: 'ghiChu')
  String? ghiChu;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'dauMoiLienHe')
  String? dauMoiLienHe;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'tenCoQuan')
  String? tenCoQuan;
  @JsonKey(name: 'isThuKy')
  bool? isThuKy;
  @JsonKey(name: 'isThamGiaBocBang')
  bool? isThamGiaBocBang;
  @JsonKey(name: 'createAt')
  String? createAt;

  DanhSachBieuQuyetLichHopResponse({
    this.tenChucVu,
    this.diemDanh,
    this.disable,
    this.trangThai,
    this.isVangMat,
    this.id,
    this.lichHopId,
    this.donViId,
    this.canBoId,
    this.vaiTro,
    this.ghiChu,
    this.parentId,
    this.vaiTroThamGia,
    this.email,
    this.soDienThoai,
    this.dauMoiLienHe,
    this.tenCanBo,
    this.tenCoQuan,
    this.isThuKy,
    this.isThamGiaBocBang,
    this.createAt,
  });

  factory DanhSachBieuQuyetLichHopResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachBieuQuyetLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachBieuQuyetLichHopResponseToJson(this);

  DanhSachBieuQuyetLichHopModel toModel() => DanhSachBieuQuyetLichHopModel(
        tenChucVu: tenChucVu,
        diemDanh: diemDanh,
        disable: disable,
        trangThai: trangThai,
        isVangMat: isVangMat,
        id: id,
        lichHopId: lichHopId,
        donViId: donViId,
        canBoId: canBoId,
        vaiTro: vaiTro,
        ghiChu: ghiChu,
        parentId: parentId,
        vaiTroThamGia: vaiTroThamGia,
        email: email,
        soDienThoai: soDienThoai,
        dauMoiLienHe: dauMoiLienHe,
        tenCanBo: tenCanBo,
        tenCoQuan: tenCoQuan,
        isThuKy: isThuKy,
        isThamGiaBocBang: isThamGiaBocBang,
        createAt: createAt,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
