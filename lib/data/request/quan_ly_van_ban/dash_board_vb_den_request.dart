import 'package:json_annotation/json_annotation.dart';

part 'dash_board_vb_den_request.g.dart';

@JsonSerializable()
class VBDenRequest {
  @JsonKey(name: 'NgayDauTien')
  final String ngayDauTien;
  @JsonKey(name: 'NgayCuoiCung')
  final String ngayCuoiCung;

  VBDenRequest({
    required this.ngayDauTien,
    required this.ngayCuoiCung,
  });

  factory VBDenRequest.fromJson(Map<String, dynamic> json) =>
      _$VBDenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VBDenRequestToJson(this);
}
