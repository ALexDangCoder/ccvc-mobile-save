import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/create_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_image_response.g.dart';

@JsonSerializable()
class CreateImageResponse {
  @JsonKey(name: 'data')
  CreateImageData? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  CreateImageResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  CreateImageModel get toModel => CreateImageModel(
        data: data?.toModel ?? CreateImageDataModel.empty(),
        message: message,
        statusCode: statusCode,
      );

  factory CreateImageResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateImageResponseToJson(this);
}

@JsonSerializable()
class CreateImageData {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'loaiGocAnh')
  String? loaiGocAnh;
  @JsonKey(name: 'loaiAnh')
  String? loaiAnh;
  @JsonKey(name: 'fileId')
  String? fileId;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'id')
  String? id;

  CreateImageData(
    this.userId,
    this.loaiGocAnh,
    this.loaiAnh,
    this.fileId,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.isDeleted,
    this.id,
  );

  CreateImageDataModel get toModel => CreateImageDataModel(
        userId: userId,
        loaiGocAnh: loaiGocAnh,
        loaiAnh: loaiAnh,
        createdBy: createdBy,
        createdAt: createdAt,
        isDeleted: isDeleted,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        fileId: fileId,
        id: id,
      );

  factory CreateImageData.fromJson(Map<String, dynamic> json) =>
      _$CreateImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateImageDataToJson(this);
}
