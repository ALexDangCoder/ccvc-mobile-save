import 'dart:convert';

import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_files_response.g.dart';

@JsonSerializable()
class GetAllFilesResponse {
  List<GetAllFileData>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  GetAllFilesResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  GetAllFilesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GetAllFileData>[];
      if (json['data']['anhKhuonMat'] != null) {
        data = <GetAllFileData>[];
        final List<dynamic> result =
            const JsonDecoder().convert(json['data']['anhKhuonMat']);
        for (final v in result) {
          data!.add(GetAllFileData.fromJson(v));
        }
      }
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }

  List<GetAllFilesIdModel> get toModel {
    return data?.map((e) => e.toModel).toList() ?? [];
  }

  Map<String, dynamic> toJson() => _$GetAllFilesResponseToJson(this);
}

@JsonSerializable()
class GetAllFileData {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'UserId')
  String? userId;
  @JsonKey(name: 'FileId')
  String? fileId;
  @JsonKey(name: 'LoaiGocAnh')
  String? loaiGocAnh;
  @JsonKey(name: 'LoaiAnh')
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
