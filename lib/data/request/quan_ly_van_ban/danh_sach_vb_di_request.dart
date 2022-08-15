import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_vb_di_request.g.dart';

@JsonSerializable()
class DanhSachVBDiRequest {
  @JsonKey(name: 'NgayTaoStartSearch')
  final String thoiGianStartFilter;
  @JsonKey(name: 'NgayTaoEndSearch')
  final String thoiGianEndFilter;
  @JsonKey(name: 'DoKhan')
  final String? doKhan;
  @JsonKey(name: 'IsDanhSachChoTrinhKy')
  final bool? isDanhSachChoTrinhKy;
  @JsonKey(name: 'IsDanhSachChoXuLy')
  final bool? isDanhSachChoXuLy;
  @JsonKey(name: 'IsDanhSachDaXuLy')
  final bool? isDanhSachDaXuLy;
  @JsonKey(name: 'IsDanhSachChoCapSo')
  final bool? isDanhSachChoCapSo;
  @JsonKey(name: 'IsDanhSachChoBanHanh')
  final bool? isDanhSachChoBanHanh;
  @JsonKey(name: 'TrangThaiFilter')
  final List<int>? trangThaiFilter;
  @JsonKey(name: 'Index')
  final int index;
  @JsonKey(name: 'Size')
  final int size;
  @JsonKey(name: 'KeySearch')
  final String? keySearch;

  DanhSachVBDiRequest({
    required this.thoiGianStartFilter,
    required this.thoiGianEndFilter,
    this.doKhan,
    this.isDanhSachChoTrinhKy,
    this.isDanhSachChoXuLy,
    this.isDanhSachDaXuLy,
    this.isDanhSachChoCapSo,
    this.isDanhSachChoBanHanh,
    this.trangThaiFilter,
    required this.index,
    required this.size,
    this.keySearch,
  });

  factory DanhSachVBDiRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVBDiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVBDiRequestToJson(this);
}
