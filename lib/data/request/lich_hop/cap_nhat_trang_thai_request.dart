import 'package:json_annotation/json_annotation.dart';

part 'cap_nhat_trang_thai_request.g.dart';

@JsonSerializable()
class CapNhatTrangThaiRequest {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'ghiChu')
  String? ghiChu;
  @JsonKey(name: 'trangThaiChuanBiId')
  String? trangThaiChuanBiId;

  CapNhatTrangThaiRequest({
    required this.id,
    required this.ghiChu,
    required this.trangThaiChuanBiId,
  });

  factory CapNhatTrangThaiRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CapNhatTrangThaiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CapNhatTrangThaiRequestToJson(this);
}
