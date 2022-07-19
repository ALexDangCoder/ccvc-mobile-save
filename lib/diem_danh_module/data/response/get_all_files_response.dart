import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_files_response.g.dart';

@JsonSerializable()
class GetAllFilesResponse {
  @JsonKey(name: 'data')
  List<GetAllFileData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  GetAllFilesResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  List<GetAllFilesIdModel> get toModel {
    return data?.map((e) => e.toModel).toList() ?? [];
  }

  factory GetAllFilesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFilesResponseToJson(this);
}

@JsonSerializable()
class GetAllFileData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'fileId')
  String? fileId;
  @JsonKey(name: 'loaiGocAnh')
  String? loaiGocAnh;
  @JsonKey(name: 'loaiAnh')
  String? loaiAnh;

  GetAllFileData(
    this.id,
    this.userId,
    this.fileId,
    this.loaiGocAnh,
    this.loaiAnh,
  );

  GetAllFilesIdModel get toModel => GetAllFilesIdModel(
        id: id,
        userId: userId,
        fileId: fileId,
        loaiGocAnh: loaiGocAnh,
        loaiAnh: loaiAnh,
      );

  factory GetAllFileData.fromJson(Map<String, dynamic> json) =>
      _$GetAllFileDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFileDataToJson(this);
}
