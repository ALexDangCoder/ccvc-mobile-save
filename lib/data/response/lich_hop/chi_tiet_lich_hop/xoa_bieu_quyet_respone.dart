import 'package:json_annotation/json_annotation.dart';

part 'xoa_bieu_quyet_respone.g.dart';

@JsonSerializable()
class XoaBieuQuyetResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  XoaBieuQuyetResponse(this.succeeded, this.code);

  factory XoaBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$XoaBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$XoaBieuQuyetResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
