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
  @JsonKey(name: 'item')
  List<String>? item;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  GetAllFileData({
    this.item,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  GetAllFilesIdModel get toModel => GetAllFilesIdModel(
        item: item,
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  factory GetAllFileData.fromJson(Map<String, dynamic> json) =>
      _$GetAllFileDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFileDataToJson(this);
}
