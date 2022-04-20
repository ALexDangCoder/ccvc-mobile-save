import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_thong_ke_request.g.dart';

@JsonSerializable()
class DanhSachThongKeRequest {
  String? dateFrom;
  String? dateTo;
  int? pageIndex;
  int? pageSize;
  String? typeCalendarId;

  DanhSachThongKeRequest({
    required this.dateFrom,
    required this.dateTo,
    required this.pageIndex,
    required this.pageSize,
    required this.typeCalendarId,
  });

  factory DanhSachThongKeRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachThongKeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachThongKeRequestToJson(this);
}
