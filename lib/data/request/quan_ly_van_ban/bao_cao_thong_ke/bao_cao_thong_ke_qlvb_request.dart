import 'package:json_annotation/json_annotation.dart';

part 'bao_cao_thong_ke_qlvb_request.g.dart';

@JsonSerializable()
class BaoCaoThongKeQLVBRequest {
  @JsonKey(name: 'endDate')
  String? endDate;
  @JsonKey(name: 'startDate')
  String? startDate;
  @JsonKey(name: 'donViId')
  List<String>? donViId;

  BaoCaoThongKeQLVBRequest(this.startDate, this.endDate, this.donViId);

  factory BaoCaoThongKeQLVBRequest.fromJson(Map<String, dynamic> json) =>
      _$BaoCaoThongKeQLVBRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaoCaoThongKeQLVBRequestToJson(this);
}
