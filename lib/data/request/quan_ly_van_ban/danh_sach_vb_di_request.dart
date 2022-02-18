import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_vb_di_request.g.dart';

@JsonSerializable()
class DanhSachVBDiRequest {
  final String ThoiGianStartFilter;
  final String ThoiGianEndFilter;
  final  int Index;
  final  int Size;
  DanhSachVBDiRequest({
    required this.ThoiGianStartFilter,
    required this.ThoiGianEndFilter,
    required this.Size,
    required this.Index,
  });
  factory DanhSachVBDiRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVBDiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DanhSachVBDiRequestToJson(this);
}