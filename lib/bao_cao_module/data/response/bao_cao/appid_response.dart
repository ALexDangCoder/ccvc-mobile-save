import 'package:ccvc_mobile/domain/model/bao_cao/htcs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appid_response.g.dart';

@JsonSerializable()
class AppIdResponse {
  @JsonKey(name: 'data')
  GroupDataResponse? data;

  AppIdResponse(
    this.data,
  );

  factory AppIdResponse.fromJson(Map<String, dynamic> json) =>
      _$AppIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppIdResponseToJson(this);
}

@JsonSerializable()
class GroupDataResponse {
  @JsonKey(name: 'items')
  List<GroupResponse>? items;

  GroupDataResponse(this.items);

  factory GroupDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataResponseToJson(this);
}

@JsonSerializable()
class GroupResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  GroupResponse(
    this.id,
    this.name,
    this.code,
    this.description,
    this.isActive,
    this.url,
    this.thuTu,
    this.createdAt,
    this.updatedAt,
  );

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  HTCSModel toDomain() => HTCSModel(
        id: id,
        name: name,
        description: description,
        code: code,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isActive: isActive,
        url: url,
        thuTu: thuTu,
      );
}
