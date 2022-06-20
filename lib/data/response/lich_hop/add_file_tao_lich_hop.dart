import 'dart:core';

import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_file_tao_lich_hop.g.dart';

@JsonSerializable()
class UploadFileWithMeetingResponse {
  @JsonKey(name: 'data')
  List<AddFileTaoLichHopResponse>? data;

  UploadFileWithMeetingResponse({
    this.data,
  });

  factory UploadFileWithMeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadFileWithMeetingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileWithMeetingResponseToJson(this);

  List<AddFileModel> toList() => data?.map((e) => e.toModel()).toList() ?? [];
}

@JsonSerializable()
class AddFileTaoLichHopResponse {
  @JsonKey(name: 'entityType')
  int? entityType;
  @JsonKey(name: 'entityName')
  String? entityName;
  @JsonKey(name: 'entityId')
  String? entityId;
  @JsonKey(name: 'isMutil')
  bool? isMutil;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'path')
  String? path;

  AddFileTaoLichHopResponse({
    this.entityType,
    this.entityName,
    this.entityId,
    this.isMutil,
    this.id,
    this.path,
  });

  factory AddFileTaoLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$AddFileTaoLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFileTaoLichHopResponseToJson(this);

  AddFileModel toModel() => AddFileModel(
        entityType: entityType,
        entityName: entityName,
        entityId: entityId,
        isMutil: isMutil,
        id: id ?? '',
        path: path ?? '',
      );
}
