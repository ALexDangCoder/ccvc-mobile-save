import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_nhiem_vu_request.g.dart';

@JsonSerializable()
class DanhSachNhiemVuRequest {
  @JsonKey(name: 'Index')
  int? index;
  @JsonKey(name: 'IsNhiemVuCaNhan')
  bool? isNhiemVuCaNhan;
  @JsonKey(name: 'IsSortByHanXuLy')
  bool? isSortByHanXuLy;
  @JsonKey(name: 'NoiDungTheoDoi')
  String? noiDungTheoDoi;
  @JsonKey(name: 'MangTrangThai')
  List<String>? mangTrangThai;
  @JsonKey(name: 'NgayTaoNhiemVu')
  Map<String, String>? ngayTaoNhiemVu;
  @JsonKey(name: 'Size')
  int? size;
  @JsonKey(name: 'TrangThaiHanXuLy')
  int? trangThaiHanXuLy;
  @JsonKey(name: 'LoaiNhiemVuId')
  String? loaiNhiemVuId;
  @JsonKey(name: 'IsNhiemVuDonViCon')
  bool? isNhiemVuDonViCon;

  DanhSachNhiemVuRequest({
    this.index,
    this.isNhiemVuCaNhan,
    this.isSortByHanXuLy,
    this.noiDungTheoDoi,
    this.mangTrangThai,
    this.ngayTaoNhiemVu,
    this.size,
    this.trangThaiHanXuLy,
    this.loaiNhiemVuId,
    this.isNhiemVuDonViCon,
  });

  factory DanhSachNhiemVuRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachNhiemVuRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachNhiemVuRequestToJson(this);
}
