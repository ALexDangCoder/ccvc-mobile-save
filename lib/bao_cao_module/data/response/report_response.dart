import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  @JsonKey(name: 'data')
  ReportDataResponse? dataResponse;
  @JsonKey(name: 'message')
  String? message;

  ReportResponse(
    this.dataResponse,
    this.message,
  );

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}

@JsonSerializable()
class ReportDataResponse {
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'items')
  List<ReportItemsResponse>? listReportItem;

  ReportDataResponse(this.totalCount, this.listReportItem);

  factory ReportDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataResponseToJson(this);
}

@JsonSerializable()
class ReportItemsResponse {
  @JsonKey(name: 'id')
  String? id;
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
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'numberReport')
  int? numberReport;
  @JsonKey(name: 'allPublicReportNumber')
  int? allFolderAndPublicReportTotal;
  @JsonKey(name: 'childrenTotal')
  int? childrenTotal;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'typeTitle')
  String? typeTitle;
  @JsonKey(name: 'level')
  int? level;
  @JsonKey(name: 'isOwner')
  bool? isOwner;
  @JsonKey(name: 'isPin')
  bool? isPin;
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
  @JsonKey(name: 'shareByMe')
  bool? shareByMe;
  @JsonKey(name: 'isShared')
  bool? isShared;
  @JsonKey(name: 'shareToMe')
  bool? shareToMe;
  @JsonKey(name: 'hasSharedAccess')
  bool? hasSharedAccess;

  ReportItemsResponse(
    this.id,
    this.name,
    this.description,
    this.urls,
    this.order,
    this.status,
    this.isShared,
    this.parentId,
    this.numberReport,
    this.childrenTotal,
    this.allFolderAndPublicReportTotal,
    this.type,
    this.typeTitle,
    this.level,
    this.isOwner,
    this.isPin,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
    this.shareByMe,
    this.shareToMe,
  );

  factory ReportItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportItemsResponseToJson(this);

  ReportItem toModel() => ReportItem(
        id: id,
        name: name,
        description: description,
        order: order,
        parentId: parentId,
        numberReport: numberReport,
        childrenTotal: allFolderAndPublicReportTotal,
        type: type,
        typeTitle: typeTitle,
        level: level,
        isOwner: isOwner,
        dateTime: updatedAt ?? createdAt,
        isPin: isPin,
        status: status,
        shareByMe: shareByMe,
        shareToMe: shareToMe,
        hasSharedAccess: hasSharedAccess ?? false,
        createdBy: createdBy,
      );

  ReportItem toModelShare() => ReportItem(
        id: id,
        name: name,
        description: description,
        order: order,
        parentId: parentId,
        numberReport: numberReport,
        childrenTotal: allFolderAndPublicReportTotal,
        type: type,
        typeTitle: typeTitle,
        level: level,
        isOwner: isOwner,
        dateTime: updatedAt ?? createdAt,
        isPin: isPin,
        status: status,
        shareToMe: isShared,
        isSourceShare: true,
        hasSharedAccess: hasSharedAccess ?? false,
      );
}
