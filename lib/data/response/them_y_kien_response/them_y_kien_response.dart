import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/them_y_kien_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'them_y_kien_response.g.dart';

@JsonSerializable()
class ThemYKienResponse {
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThemYKienResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory ThemYKienResponse.fromJson(Map<String, dynamic> json) =>
      _$ThemYKienResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemYKienResponseToJson(this);

  ThemYKienModel toDomain() => ThemYKienModel(
        data: data,
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}
