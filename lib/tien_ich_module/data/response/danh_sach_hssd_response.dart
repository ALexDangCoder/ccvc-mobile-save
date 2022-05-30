import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_hssd_response.g.dart';

@JsonSerializable()
class DataDanhSachHDSDResponse extends Equatable {
  @JsonKey(name: 'data')
  PageDataDanhSachHDSDResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataDanhSachHDSDResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataDanhSachHDSDResponse.fromJson(Map<String, dynamic> json) =>
      _$DataDanhSachHDSDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataDanhSachHDSDResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PageDataDanhSachHDSDResponse extends Equatable {
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'pageData')
  List<DanhSachHDSDResponse>? pageData;
  @JsonKey(name: 'hasPreviousPage')
  bool? hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;

  PageDataDanhSachHDSDResponse({
    this.pageIndex,
    this.totalPages,
    this.totalItems,
    this.pageData,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory PageDataDanhSachHDSDResponse.fromJson(Map<String, dynamic> json) =>
      _$PageDataDanhSachHDSDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataDanhSachHDSDResponseToJson(this);

  DataDanhSachTitleHDSD toModel() => DataDanhSachTitleHDSD(
        pageIndex: pageIndex,
        totalPages: totalPages,
        totalItems: totalItems,
        pageData: pageData?.map((e) => e.toModel()).toList() ?? [],
        hasPreviousPage: hasPreviousPage,
        hasNextPage: hasNextPage,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachHDSDResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'topic')
  String? topic;
  @JsonKey(name: 'topicStr')
  String? topicStr;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'createdOn')
  String? createdOn;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'inUsed')
  bool? inUsed;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'updatedOn')
  String? updatedOn;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'order')
  int? order;

  DanhSachHDSDResponse({
    this.id,
    this.title,
    this.topic,
    this.topicStr,
    this.type,
    this.createdOn,
    this.createdBy,
    this.inUsed,
    this.isDeleted,
    this.updatedOn,
    this.updatedBy,
    this.order,
  });

  factory DanhSachHDSDResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachHDSDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachHDSDResponseToJson(this);

  DanhSachTitleHDSD toModel() => DanhSachTitleHDSD(
        id: id,
        title: title,
        topic: topic,
        topicStr: topicStr,
        type: type,
        createdOn: createdOn,
        createdBy: createdBy,
        inUsed: inUsed,
        isDeleted: isDeleted,
        updatedOn: updatedOn,
        updatedBy: updatedBy,
        order: order,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
