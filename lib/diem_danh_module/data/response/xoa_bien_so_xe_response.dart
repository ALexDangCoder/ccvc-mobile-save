import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/xoa_bien_so_xe_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'xoa_bien_so_xe_response.g.dart';

@JsonSerializable()
class XoaBienSoXeResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  XoaBienSoXeResponse({
    this.code,
    this.statusCode,
    this.data,
    this.message,
    this.succeeded,
  });

  factory XoaBienSoXeResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$XoaBienSoXeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$XoaBienSoXeResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  XoaBienSoXeModel toModel() => XoaBienSoXeModel(
        code: code,
        statusCode: statusCode,
        data: data,
        message: message,
        succeeded: succeeded,
      );
}
