import 'package:json_annotation/json_annotation.dart';

part 'moi_hop_request.g.dart';

@JsonSerializable()
class MoiHopRequest {
  String? CanBoId;
  String? DonViId;
  int? VaiTroThamGia;
  String? chucVu;
  String? hoTen;
  String? id;
  int? status;
  String? tenDonVi;
  int? type;
  String? userId;

  MoiHopRequest({
    required this.CanBoId,
    required this.DonViId,
    required this.VaiTroThamGia,
    required this.chucVu,
    required this.hoTen,
    required this.id,
    required this.status,
    required this.tenDonVi,
    required this.type,
    required this.userId,
  });

  factory MoiHopRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MoiHopRequestToJson(this);
}
