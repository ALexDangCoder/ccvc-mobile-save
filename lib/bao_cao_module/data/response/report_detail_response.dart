import 'dart:convert';

import 'package:ccvc_mobile/bao_cao_module/domain/model/report_detail_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'report_detail_response.g.dart';

@JsonSerializable()
class ReportDetailResponse {
  @JsonKey(name: 'data')
  ReportDataResponse? dataResponse;
  @JsonKey(name: 'message')
  String? message;

  ReportDetailResponse(
    this.dataResponse,
    this.message,
  );

  factory ReportDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailResponseToJson(this);
}

@JsonSerializable()
class ReportDataResponse {
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
  @JsonKey(name: 'folderId')
  String? folderId;
  @JsonKey(name: 'folderName')
  String? folderName;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'urls')
  String? urls;
  @JsonKey(name: 'order')
  int? order;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'isPin')
  bool? isPin;
  @JsonKey(name: 'shareToMe')
  bool? shareToMe;
  @JsonKey(name: 'access')
  UserAccessResponse? access;
  @JsonKey(name: 'userAccesses')
  List<UserAccessResponse>? userAccesses;

  ReportDataResponse(
    this.id,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
    this.folderId,
    this.folderName,
    this.code,
    this.name,
    this.description,
    this.urls,
    this.order,
    this.status,
    this.isPin,
    this.shareToMe,
    this.access,
    this.userAccesses,
  );

  factory ReportDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataResponseToJson(this);

  ReportDetailModel toModel() => ReportDetailModel(
        id: id,
        createdAt: createdAt,
        createdBy: createdBy,
        createdByName: createdByName,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        updatedByName: updatedByName,
        folderId: folderId,
        folderName: folderName,
        code: code,
        name: name,
        description: description,
        urls: UrlsReportModel.fromJson(jsonDecode(urls ?? '')),
        order: order,
        status: status,
        isPin: isPin,
        shareToMe: shareToMe,
        access: access?.toModel(),
        listUserAccesses: userAccesses?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class UserAccessResponse {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'fullname')
  String? fullname;
  @JsonKey(name: 'applyAllChildren')
  bool? applyAllChildren;
  @JsonKey(name: 'permissions')
  List<PermissionsResponse>? permissions;

  UserAccessResponse(
    this.userId,
    this.fullname,
    this.applyAllChildren,
    this.permissions,
  );

  factory UserAccessResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccessResponseToJson(this);

  UserAccessReportDetail toModel() => UserAccessReportDetail(
        userId: userId,
        fullname: fullname,
        applyAllChildren: applyAllChildren,
        listPermission: permissions?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class PermissionsResponse {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'title')
  String? title;

  PermissionsResponse(
    this.code,
    this.title,
  );

  factory PermissionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PermissionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionsResponseToJson(this);

  Permissions toModel() => Permissions(
        code: code,
        title: title,
      );
}
