import 'package:json_annotation/json_annotation.dart';

part 'cu_can_bo_di_thay_request.g.dart';

@JsonSerializable()
class CuCanBoDiThayRequest {
  String? id;
  String? lichHopId;
  List<CanBoDiThay>? canBoDiThay;

  CuCanBoDiThayRequest({
    required this.id,
    required this.lichHopId,
    required this.canBoDiThay,
  });

  factory CuCanBoDiThayRequest.fromJson(Map<String, dynamic> json) =>
      _$CuCanBoDiThayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CuCanBoDiThayRequestToJson(this);
}

@JsonSerializable()
class CanBoDiThay {
  String? id;
  String? donViId;
  String? canBoId;
  String? taskContent;

  CanBoDiThay({
    required this.id,
    required this.donViId,
    required this.canBoId,
    required this.taskContent,
  });

  factory CanBoDiThay.fromJson(Map<String, dynamic> json) =>
      _$CanBoDiThayFromJson(json);

  Map<String, dynamic> toJson() => _$CanBoDiThayToJson(this);
}
