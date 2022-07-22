import 'package:json_annotation/json_annotation.dart';

part 'cu_can_bo_di_thay_lich_lam_viec_request.g.dart';

@JsonSerializable()
class DataCuCanBoDiThayLichLamViecRequest {
  String? scheduleId;
  String? scheduleOperativeId;
  List<CuCanBoDiThayLichLamViecRequest>? canBoDiThay;

  DataCuCanBoDiThayLichLamViecRequest({
    required this.scheduleId,
    required this.scheduleOperativeId,
    required this.canBoDiThay,
  });

  factory DataCuCanBoDiThayLichLamViecRequest.fromJson(
          Map<String, dynamic> json) =>
      _$DataCuCanBoDiThayLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataCuCanBoDiThayLichLamViecRequestToJson(this);
}

@JsonSerializable()
class CuCanBoDiThayLichLamViecRequest {
  String? id;
  String? donViId;
  String? canBoId;
  String? taskContent;
  bool? isXoa;

  //isXoa day len ?? hoi backend

  CuCanBoDiThayLichLamViecRequest(
      {required this.id,
      required this.donViId,
      required this.canBoId,
      required this.taskContent,
      required this.isXoa});

  factory CuCanBoDiThayLichLamViecRequest.fromJson(Map<String, dynamic> json) =>
      _$CuCanBoDiThayLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CuCanBoDiThayLichLamViecRequestToJson(this);
}
