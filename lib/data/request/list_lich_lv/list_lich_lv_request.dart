import 'package:json_annotation/json_annotation.dart';

part 'list_lich_lv_request.g.dart';

@JsonSerializable()
class ListLichLvRequest {
  String dateFrom;
  String dateTo;
  int pageIndex;
  int pageSize;
  bool isLichCuaToi;

  ListLichLvRequest({
    required this.dateFrom,
    required this.dateTo,
    required this.pageIndex,
    required this.pageSize,
    required this.isLichCuaToi,
  });

  factory ListLichLvRequest.fromJson(Map<String, dynamic> json) =>
      _$ListLichLvRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListLichLvRequestToJson(this);
}
