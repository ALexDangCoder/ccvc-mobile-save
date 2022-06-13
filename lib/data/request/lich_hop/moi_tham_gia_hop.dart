import 'package:json_annotation/json_annotation.dart';

part 'moi_tham_gia_hop.g.dart';

@JsonSerializable()
class MoiThamGiaHopRequest {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'dauMoiLienHe')
  String? dauMoiLienHe;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'tenCoQuan')
  String? tenCoQuan;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;

  MoiThamGiaHopRequest(
      {this.canBoId,
      this.dauMoiLienHe,
      this.donViId,
      this.createAt,
      this.email,
      this.id,
      this.lichHopId,
      this.soDienThoai,
      this.tenCanBo,
      this.tenCoQuan,
      this.vaiTroThamGia,});

  factory MoiThamGiaHopRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiThamGiaHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MoiThamGiaHopRequestToJson(this);
}
