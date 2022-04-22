import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_y_kien_pakn_request.g.dart';

@JsonSerializable()
class DanhSachYKienPAKNRequest {
  @JsonKey(name: 'KienNghiId')
  final String kienNghiId;
  @JsonKey(name: 'Type')
  final int? type;
  DanhSachYKienPAKNRequest({
    required this.kienNghiId,
    required this.type,
  });

  factory DanhSachYKienPAKNRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachYKienPAKNRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachYKienPAKNRequestToJson(this);
}
