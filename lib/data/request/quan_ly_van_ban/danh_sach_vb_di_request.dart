import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_vb_di_request.g.dart';

@JsonSerializable()
class DanhSachVBDiRequest {
  @JsonKey(name: 'ThoiGianStartFilter')
  final String thoiGianStartFilter;
  @JsonKey(name: 'ThoiGianEndFilter')
  final String thoiGianEndFilter;
  @JsonKey(name: 'Index')
  final int index;
  @JsonKey(name: 'Size')
  final int size;

  DanhSachVBDiRequest({
    required this.thoiGianStartFilter,
    required this.thoiGianEndFilter,
    required this.size,
    required this.index,
  });

  factory DanhSachVBDiRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVBDiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVBDiRequestToJson(this);
}
