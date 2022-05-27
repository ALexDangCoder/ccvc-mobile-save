import 'package:ccvc_mobile/domain/model/edit_personal_information/up_load_anh_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'up_load_anh_response.g.dart';

@JsonSerializable()
class PostFileResponse  {
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'Data')
  dynamic data;

  PostFileResponse(this.isSuccess,this.data,);

  factory PostFileResponse.fromJson(Map<String, dynamic> json) =>
      _$PostFileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostFileResponseToJson(this);

}



@JsonSerializable()
class UpLoadAnhResponse {
  @JsonKey(name: 'data')
  DataUpLoadAnhResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  UpLoadAnhResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory UpLoadAnhResponse.fromJson(Map<String, dynamic> json) =>
      _$UpLoadAnhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpLoadAnhResponseToJson(this);

  UpLoadAnhModel toModel() => UpLoadAnhModel(
        data: data?.toMoDel() ?? DataUpLoadAnhModel(),
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}

@JsonSerializable()
class DataUpLoadAnhResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'fileUrl')
  String? fileUrl;
  @JsonKey(name: 'fileName')
  String? fileName;
  @JsonKey(name: 'fileType')
  String? fileType;
  @JsonKey(name: 'filePath')
  String? filePath;
  @JsonKey(name: 'fieldUpload')
  String? fieldUpload;

  DataUpLoadAnhResponse({
    this.id,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.filePath,
    this.fieldUpload,
  });

  factory DataUpLoadAnhResponse.fromJson(Map<String, dynamic> json) =>
      _$DataUpLoadAnhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataUpLoadAnhResponseToJson(this);

  DataUpLoadAnhModel toMoDel() => DataUpLoadAnhModel(
        id: id,
        fileUrl: fileUrl,
        fileName: fileName,
        fileType: fileType,
        filePath: filePath,
        fieldUpload: fieldUpload,
      );
}
