import 'package:json_annotation/json_annotation.dart';

part 'thu_hoi_lich_lam_viec_request.g.dart';

@JsonSerializable()
class RecallRequest {
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int status ;

  RecallRequest({
    this.donViId,
    this.scheduleId,
    this.canBoId,
    this.id,
    this.status = 0,
  });

  factory RecallRequest.fromJson(Map<String, dynamic> json) =>
      _$RecallRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RecallRequestToJson(this);
}
