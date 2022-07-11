import 'package:json_annotation/json_annotation.dart';

part 'cap_nhat_trang_thai_response.g.dart';

@JsonSerializable()
class CapNhatTrangThaiResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  CapNhatTrangThaiResponse(this.succeeded, this.code);

  factory CapNhatTrangThaiResponse.fromJson(Map<String, dynamic> json) =>
      _$CapNhatTrangThaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CapNhatTrangThaiResponseToJson(this);

  bool get isSucces => succeeded ?? false;
}
