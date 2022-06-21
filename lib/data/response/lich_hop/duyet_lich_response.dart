import 'package:ccvc_mobile/domain/model/lich_hop/duyet_lich_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duyet_lich_response.g.dart';

@JsonSerializable()
class DuyetLichResponse {
  @JsonKey(name: 'data')
  bool? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DuyetLichResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory DuyetLichResponse.fromJson(Map<String, dynamic> json) =>
      _$DuyetLichResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DuyetLichResponseToJson(this);

  DuyetLichModel toModel() => DuyetLichModel(
        data: data,
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}
