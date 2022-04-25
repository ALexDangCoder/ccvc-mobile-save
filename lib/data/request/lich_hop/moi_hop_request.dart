import 'package:json_annotation/json_annotation.dart';

part 'moi_hop_request.g.dart';

@JsonSerializable()
class MoiHopRequest {
  @JsonKey(name: 'DauMoiLienHe')
  String? DauMoiLienHe;
  @JsonKey(name: 'Email')
  String? Email;
  @JsonKey(name: 'GhiChu')
  String? GhiChu;
  @JsonKey(name: 'SoDienThoai')
  String? SoDienThoai;
  @JsonKey(name: 'TenCoQuan')
  String? TenCoQuan;
  @JsonKey(name: 'VaiTroThamGia')
  int? VaiTroThamGia;
  @JsonKey(name: 'dauMoi')
  String? dauMoi;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'noiDungLamViec')
  String? noiDungLamViec;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'CanBoId')
  String? CanBoId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'DonViId')
  String? DonViId;
  @JsonKey(name: 'chucVu')
  String? chucVu;

  MoiHopRequest({
    this.DauMoiLienHe,
    this.Email,
    this.GhiChu,
    this.SoDienThoai,
    this.TenCoQuan,
    this.VaiTroThamGia,
    this.dauMoi,
    this.email,
    this.id,
    this.noiDungLamViec,
    this.soDienThoai,
    this.tenCanBo,
    this.tenDonVi,
    this.hoTen,
    this.status,
    this.type,
    this.userId,
    this.donViId,
    this.CanBoId,
    this.DonViId,
    this.chucVu,
  });

  factory MoiHopRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MoiHopRequestToJson(this);
}
