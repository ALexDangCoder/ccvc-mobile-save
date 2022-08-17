import 'package:ccvc_mobile/bao_cao_module/domain/model/source_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_share_detail_response.g.dart';

@JsonSerializable()
class DataSourceShareResponse {
  @JsonKey(name: 'data')
  SourceDetailResponse? dataResponse;
  @JsonKey(name: 'message')
  String? message;

  DataSourceShareResponse(
    this.dataResponse,
    this.message,
  );

  factory DataSourceShareResponse.fromJson(Map<String, dynamic> json) =>
      _$DataSourceShareResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceShareResponseToJson(this);
}

@JsonSerializable()
class SourceDetailResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'createdByName')
  String? createdByName;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'updatedByName')
  String? updatedByName;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'parentName')
  String? parentName;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'groupAccesses')
  List<GroupAccessesResponse>? groupAccesses;
  @JsonKey(name: 'userCommons')
  List<UserCommonsResponse>? userCommons;
  @JsonKey(name: 'unitAccesses')
  List<UnitAccessesResponse>? unitAccesses;
  @JsonKey(name: 'userInThisSystems')
  List<UserInThisSystemsResponse>? userInThisSystems;

  SourceDetailResponse({
    this.id,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
    this.parentId,
    this.parentName,
    this.name,
    this.description,
    this.type,
    this.groupAccesses,
    this.userCommons,
    this.userInThisSystems,
    this.unitAccesses,
  });

  factory SourceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceDetailResponseToJson(this);

  SourceDetail toDomain() => SourceDetail(
        id: id,
        createdAt: createdAt,
        createdBy: createdBy,
        createdByName: createdByName,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        updatedByName: updatedByName,
        parentId: parentId,
        parentName: parentName,
        name: name,
        description: description,
        type: type,
        unitAccesses: unitAccesses?.map((e) => e.toDomain()).toList() ?? [],
        groupAccesses: groupAccesses?.map((e) => e.toDomain()).toList() ?? [],
        userCommons: userCommons?.map((e) => e.toDomain()).toList() ?? [],
        userInThisSystems:
            userInThisSystems?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class GroupAccessesResponse {
  @JsonKey(name: 'groupId')
  String? groupId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;

  GroupAccessesResponse({
    this.groupId,
    this.name,
    this.code,
  });

  factory GroupAccessesResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupAccessesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupAccessesResponseToJson(this);

  GroupAccesses toDomain() => GroupAccesses(
        groupId: groupId,
        name: name,
        code: code,
      );
}

@JsonSerializable()
class UserCommonsResponse {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'fullname')
  String? fullname;

  UserCommonsResponse({
    this.userId,
    this.username,
    this.fullname,
  });

  factory UserCommonsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserCommonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCommonsResponseToJson(this);

  UserCommons toDomain() => UserCommons(
        userId: userId,
        username: username,
        fullname: fullname,
      );
}

@JsonSerializable()
class UnitAccessesResponse {
  @JsonKey(name: 'countUser')
  int? countUser;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'name')
  String? name;


  UnitAccessesResponse({
    this.countUser,
    this.donViId,
    this.name,
  });

  factory UnitAccessesResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitAccessesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnitAccessesResponseToJson(this);

  UnitAccesses toDomain() => UnitAccesses(
    countUser: countUser,
    donViId: donViId ?? '',
    name: name,
  );
}

@JsonSerializable()
class UserInThisSystemsResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'userId')
  String? userId;

  UserInThisSystemsResponse({
    this.email,
    this.status,
    this.userId,
  });

  factory UserInThisSystemsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInThisSystemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInThisSystemsResponseToJson(this);

  UserInThisSystems toDomain() => UserInThisSystems(
        email: email,
        status: status,
        userId: userId,
      );
}
