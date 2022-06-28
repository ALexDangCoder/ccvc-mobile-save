import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_pakn_request.g.dart';

@JsonSerializable()
class DanhSachPAKNRequest {
  @JsonKey(name: 'PageIndex')
  final int pageIndex;
  @JsonKey(name: 'PageSize')
  final int pageSize;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'LoaiMenu')
  String? loaiMenu;
  @JsonKey(name: 'DateFrom')
  final String dateFrom;
  @JsonKey(name: 'DateTo')
  final String dateTo;
  @JsonKey(name: 'HanXuLy')
  int? hanXuLy;

  DanhSachPAKNRequest(this.pageIndex, this.pageSize, this.dateFrom, this.dateTo,
      {this.trangThai, this.loaiMenu, this.hanXuLy});

  factory DanhSachPAKNRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPAKNRequestToJson(this);
}
