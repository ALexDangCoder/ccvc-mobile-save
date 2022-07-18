import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/post_file_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_file_khuon_mat_response.g.dart';

@JsonSerializable()
class PostFileKhuonMatResponse {
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

  PostFileKhuonMatResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  PostFileKhuonMatModel get toModel =>
      PostFileKhuonMatModel(data: data, message: message);

  factory PostFileKhuonMatResponse.fromJson(Map<String, dynamic> json) =>
      _$PostFileKhuonMatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostFileKhuonMatResponseToJson(this);
}
