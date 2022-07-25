import 'package:json_annotation/json_annotation.dart';

part 'cu_can_bo_lich_lam_viec_response.g.dart';

@JsonSerializable()
class CuCanBoLichLamViecResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  CuCanBoLichLamViecResponse({this.succeeded, this.code});

  factory CuCanBoLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$CuCanBoLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CuCanBoLichLamViecResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
