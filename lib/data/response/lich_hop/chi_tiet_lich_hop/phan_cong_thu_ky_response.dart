import 'package:ccvc_mobile/domain/model/lich_hop/responseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phan_cong_thu_ky_response.g.dart';

@JsonSerializable()
class PhanCongThuKyResponse {
  @JsonKey(name: 'data')
  dynamic data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PhanCongThuKyResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory PhanCongThuKyResponse.fromJson(Map<String, dynamic> json) =>
      _$PhanCongThuKyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhanCongThuKyResponseToJson(this);

  @override
  List<Object?> get props => [];

  ResponseModel toModel() => ResponseModel(
        data: data,
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}
