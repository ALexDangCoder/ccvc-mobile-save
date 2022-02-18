import 'package:json_annotation/json_annotation.dart';

part 'dash_board_vb_di_request.g.dart';

@JsonSerializable()
class VBDiRequest {
  final String NgayDauTien;
  final String NgayCuoiCung;
  VBDiRequest({
    required this.NgayDauTien,
    required this.NgayCuoiCung,

  });
  factory VBDiRequest.fromJson(Map<String, dynamic> json) =>
      _$VBDiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VBDiRequestToJson(this);
}