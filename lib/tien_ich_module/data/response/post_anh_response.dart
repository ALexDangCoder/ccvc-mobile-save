import 'package:ccvc_mobile/tien_ich_module/domain/model/post_anh_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_anh_response.g.dart';

@JsonSerializable()
class PostAnhResponse {
  @JsonKey(name: 'data')
  DataPostAnhResponse? data;

  PostAnhResponse({this.data});

  factory PostAnhResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PostAnhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostAnhResponseToJson(this);

  PostAnhModel toMoDel() => PostAnhModel(
        data: data?.toMoDel() ?? DataPostAnhModel(),
      );
}

@JsonSerializable()
class DataPostAnhResponse {
  @JsonKey(name: 'originName')
  String? originName;
  @JsonKey(name: 'filePath')
  String? filePath;
  @JsonKey(name: 'filePathFull')
  String? filePathFull;
  @JsonKey(name: 'fileLength')
  int? fileLength;
  @JsonKey(name: 'fileExtend')
  String? fileExtend;

  DataPostAnhResponse({
    this.originName,
    this.filePath,
    this.filePathFull,
    this.fileLength,
    this.fileExtend,
  });

  factory DataPostAnhResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataPostAnhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataPostAnhResponseToJson(this);

  DataPostAnhModel toMoDel() => DataPostAnhModel(
        originName: originName,
        filePath: filePath,
        filePathFull: filePathFull,
        fileLength: fileLength,
        fileExtend: fileExtend,
      );
}
