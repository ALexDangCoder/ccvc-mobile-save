import 'package:json_annotation/json_annotation.dart';

part 'dash_board_vb_den_request.g.dart';

@JsonSerializable()
class VBDenRequest {
  final String NgayDauTien;
  final String NgayCuoiCung;
  VBDenRequest({
    required this.NgayDauTien,
    required this.NgayCuoiCung,

  });
  factory VBDenRequest.fromJson(Map<String, dynamic> json) =>
      _$VBDenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VBDenRequestToJson(this);
}