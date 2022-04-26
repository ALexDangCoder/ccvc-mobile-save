import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/them_y_kien_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'xoa_chuong_trinh_hop_response.g.dart';

@JsonSerializable()
class XoaChuongTrinhHopResponse {
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

  XoaChuongTrinhHopResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory XoaChuongTrinhHopResponse.fromJson(Map<String, dynamic> json) =>
      _$XoaChuongTrinhHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$XoaChuongTrinhHopResponseToJson(this);

  ThemYKienModel toDomain() => ThemYKienModel(
        data: data,
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}
