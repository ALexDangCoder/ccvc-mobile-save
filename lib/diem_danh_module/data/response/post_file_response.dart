import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/post_file_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_file_response.g.dart';

@JsonSerializable()
class PostFileResponse {
  @JsonKey(name: 'data')
  List<String>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PostFileResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  PostFileModel get toModel => PostFileModel(data: data, message: message);

  factory PostFileResponse.fromJson(Map<String, dynamic> json) =>
      _$PostFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostFileResponseToJson(this);
}
