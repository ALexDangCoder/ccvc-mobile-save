import 'dart:core';
import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_file_tao_lich_hop.g.dart';

@JsonSerializable()
class AddFileTaoLichHopResponse extends Equatable {
  @JsonKey(name: 'entityType')
  int? entityType;
  @JsonKey(name: 'entityName')
  String? entityName;
  @JsonKey(name: 'entityId')
  String? entityId;
  @JsonKey(name: 'isMutil')
  bool? isMutil;

  AddFileTaoLichHopResponse({
    this.entityType,
    this.entityName,
    this.entityId,
    this.isMutil,
  });

  factory AddFileTaoLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$AddFileTaoLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFileTaoLichHopResponseToJson(this);

  AddFileModel toModel() => AddFileModel(
        entityType: entityType,
        entityName: entityName,
        entityId: entityId,
        isMutil: isMutil,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
