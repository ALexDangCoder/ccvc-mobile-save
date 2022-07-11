import 'package:json_annotation/json_annotation.dart';

part 'cu_can_bo_di_thay_response.g.dart';

@JsonSerializable()
class CuCanBoDiThayResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  CuCanBoDiThayResponse({this.succeeded, this.code});

  factory CuCanBoDiThayResponse.fromJson(Map<String, dynamic> json) =>
      _$CuCanBoDiThayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CuCanBoDiThayResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
