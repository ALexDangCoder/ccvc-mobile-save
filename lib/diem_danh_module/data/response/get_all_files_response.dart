import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_files_response.g.dart';

@JsonSerializable()
class GetAllFilesResponse {
  @JsonKey(name: 'data')
  GetAllFileData? data;
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

  factory GetAllFilesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFilesResponseToJson(this);
}

@JsonSerializable()
class GetAllFileData {
  @JsonKey(name: 'items')
  List<FileImageResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  GetAllFileData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  GetAllFilesIdModel get toModel => GetAllFilesIdModel(
        items: items?.map((e) => e.toModel).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  factory GetAllFileData.fromJson(Map<String, dynamic> json) =>
      _$GetAllFileDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFileDataToJson(this);
}

@JsonSerializable()
class FileImageResponse {
  @JsonKey(name: 'item')
  String? id;
  @JsonKey(name: 'entityName')
  String? entityName;
  @JsonKey(name: 'fileTypeUpload')
  String? fileTypeUpload;

  FileImageResponse({
    required this.id,
    required this.entityName,
    required this.fileTypeUpload,
  });

  FileImageModel get toModel => FileImageModel(
        id: id,
        entityName: entityName,
        fileTypeUpload: fileTypeUpload,
      );

  factory FileImageResponse.fromJson(Map<String, dynamic> json) =>
      _$FileImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileImageResponseToJson(this);
}
