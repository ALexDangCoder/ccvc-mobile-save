import 'package:ccvc_mobile/domain/model/bao_cao/folder_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_tree_report_respose.g.dart';

@JsonSerializable()
class ListTreeReportResponse {
  @JsonKey(name: 'data')
  List<GroupDataResponse>? data;

  ListTreeReportResponse(
    this.data,
  );

  factory ListTreeReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTreeReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTreeReportResponseToJson(this);
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
