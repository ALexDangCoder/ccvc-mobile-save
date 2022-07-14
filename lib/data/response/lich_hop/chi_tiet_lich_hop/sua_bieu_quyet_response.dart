import 'package:json_annotation/json_annotation.dart';

part 'sua_bieu_quyet_response.g.dart';

@JsonSerializable()
class SuaBieuQuyetResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  SuaBieuQuyetResponse(this.succeeded, this.code);

  factory SuaBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$SuaBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuaBieuQuyetResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
