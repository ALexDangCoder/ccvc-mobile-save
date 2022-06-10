// ignore_for_file: avoid_positional_boolean_parameters

import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  @JsonKey(name: 'data')
  ReportDataResponse dataResponse;

  ReportResponse(
    this.dataResponse,
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

  ReportItemsResponse(
    this.id,
    this.name,
    this.description,
    this.urls,
    this.order,
    this.status,
    this.parentId,
    this.numberReport,
    this.childrenTotal,
    this.type,
    this.typeTitle,
    this.level,
    this.isOwner,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
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
        childrenTotal: childrenTotal,
        type: type,
        typeTitle: typeTitle,
        level: level,
        isOwner: isOwner,
        dateTime: createdAt,
      );
}
