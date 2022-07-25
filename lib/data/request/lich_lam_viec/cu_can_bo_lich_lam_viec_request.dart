import 'package:json_annotation/json_annotation.dart';

part 'cu_can_bo_lich_lam_viec_request.g.dart';

@JsonSerializable()
class DataCuCanBoLichLamViecRequest {
  String? scheduleId;
  List<CuCanBoLichLamViecRequest>? canBoDiThay;

  DataCuCanBoLichLamViecRequest({
    required this.scheduleId,
    required this.canBoDiThay,
  });

  factory DataCuCanBoLichLamViecRequest.fromJson(Map<String, dynamic> json) =>
      _$DataCuCanBoLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DataCuCanBoLichLamViecRequestToJson(this);
}

@JsonSerializable()
class CuCanBoLichLamViecRequest {
  //truong khoi tao model
  String? canBoId;
  String? confirmDate;
  String? donViId;
  String? hoTen;
  String? id;
  bool? isConfirm;
  String? parentId;
  String? scheduleId;
  int? status;
  String? taskContent;
  String? tenDonVi;
  String? userId;
  String? userName;
  bool? isXoa;

  CuCanBoLichLamViecRequest({
    required this.canBoId,
    required this.confirmDate,
    required this.donViId,
    required this.hoTen,
    required this.id,
    required this.isConfirm,
    required this.parentId,
    required this.scheduleId,
    required this.status,
    required this.taskContent,
    required this.tenDonVi,
    required this.userId,
    required this.userName,
    required this.isXoa,
  }); //truong day len user tham gia,canBoId,donViId,hoTen,isXoa,taskContent,tenDonVi

  factory CuCanBoLichLamViecRequest.fromJson(Map<String, dynamic> json) =>
      _$CuCanBoLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CuCanBoLichLamViecRequestToJson(this);
}
