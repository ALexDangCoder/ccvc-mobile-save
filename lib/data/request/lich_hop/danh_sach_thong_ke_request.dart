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
    this.pageSize,
    required this.typeCalendarId,
  });

  factory DanhSachThongKeRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachThongKeRequestFromJson(json);

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> json = {
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'pageIndex': pageIndex,
      'typeCalendarId': typeCalendarId,
    };
    if(pageSize != null){
      json.putIfAbsent('pageSize', () => pageSize);
    }
    return json;
  }
}
