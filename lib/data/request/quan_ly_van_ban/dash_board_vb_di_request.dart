import 'package:json_annotation/json_annotation.dart';

part 'dash_board_vb_di_request.g.dart';

@JsonSerializable()
class VBDiRequest {
  @JsonKey(name: 'NgayDauTien')
  final String ngayDauTien;
  @JsonKey(name: 'NgayCuoiCung')
  final String ngayCuoiCung;

  VBDiRequest({
    required this.ngayDauTien,
    required this.ngayCuoiCung,
  });

  factory VBDiRequest.fromJson(Map<String, dynamic> json) =>
      _$VBDiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VBDiRequestToJson(this);
}
