import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_nguoi_tham_gia_response.g.dart';

@JsonSerializable()
class DanhSachNguoiThamGiaResponse {
  @JsonKey(name: 'data')
  List<DataNguoiThamGiaResponse>? data;

  DanhSachNguoiThamGiaResponse({required this.data});

  factory DanhSachNguoiThamGiaResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachNguoiThamGiaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachNguoiThamGiaResponseToJson(this);

  List<DanhSachNguoiThamGiaModel> toDomain() =>
      data?.map((e) => e.toDomain()).toList() ?? [];
}

@JsonSerializable()
class DataNguoiThamGiaResponse {
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

  DataNguoiThamGiaResponse(
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
  );

  factory DataNguoiThamGiaResponse.fromJson(Map<String, dynamic> json) =>
      _$DataNguoiThamGiaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataNguoiThamGiaResponseToJson(this);

  DanhSachNguoiThamGiaModel toDomain() => DanhSachNguoiThamGiaModel(
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
}
