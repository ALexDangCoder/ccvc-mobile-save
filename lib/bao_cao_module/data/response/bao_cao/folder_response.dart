
import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/folder_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_response.g.dart';

@JsonSerializable()
class FolderResponse {
  @JsonKey(name: 'data')
  GroupDataResponse? data;

  FolderResponse(
    this.data,
  );

  factory FolderResponse.fromJson(Map<String, dynamic> json) =>
      _$FolderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FolderResponseToJson(this);
}

@JsonSerializable()
class GroupDataResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'order')
  int? order;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'isRoot')
  bool? isRoot;
  @JsonKey(name: 'tree')
  String? tree;

  GroupDataResponse(
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.name,
    this.description,
    this.order,
    this.isDeleted,
    this.isRoot,
    this.tree,
  );

  factory GroupDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataResponseToJson(this);

  FolderModel toDomain() => FolderModel(
        id: id,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        name: name,
        description: description,
        order: order,
        isDeleted: isDeleted,
        isRoot: isRoot,
        tree: tree,
      );
}
