import 'dart:convert';

import 'package:ccvc_mobile/domain/model/lich_hop/file_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'xem_ket_luan_hop_response.g.dart';

@JsonSerializable()
class XemKetLuanHopDataResponse extends Equatable {
  @JsonKey(name: 'data')
  XemKetLuanHopDataResponseData? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  XemKetLuanHopDataResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory XemKetLuanHopDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$XemKetLuanHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$XemKetLuanHopDataResponseToJson(this);

  // TODO: implement props
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class XemKetLuanHopDataResponseData extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'reportStatusId')
  String? reportStatusId;
  @JsonKey(name: 'startDate')
  String? startDate;
  @JsonKey(name: 'endDate')
  String? endDate;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'statusName')
  String? statusName;
  @JsonKey(name: 'scheduleTitle')
  String? scheduleTitle;
  @JsonKey(name: 'reportStatus')
  String? reportStatus;
  @JsonKey(name: 'reportStatusCode')
  String? reportStatusCode;
  @JsonKey(name: 'createBy')
  String? createBy;
  @JsonKey(name: 'canBoChuTriId')
  String? canBoChuTriId;
  @JsonKey(name: 'nguoiTao')
  String? nguoiTao;
  @JsonKey(name: 'nguoiChuTri')
  String? nguoiChuTri;
  @JsonKey(name: 'files')
  String? files;
  @JsonKey(name: 'reportTemplateId')
  String? reportTemplateId;
  @JsonKey(name: 'noiDungHuy')
  String? noiDungHuy;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'createAt')
  String? createAt;

  XemKetLuanHopDataResponseData();

  factory XemKetLuanHopDataResponseData.fromJson(Map<String, dynamic> json) =>
      _$XemKetLuanHopDataResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$XemKetLuanHopDataResponseDataToJson(this);

  @override
  List<Object?> get props => throw [];

  XemKetLuanHopModel toModel() {
    final List<FileDetailMeetModel> listFile = [];
    if (files != null) {
      final listData = jsonDecode(files ?? '') as List<dynamic>;
      for (final element in listData) {
        listFile.add(ListFileDataresponse.fromJson(element).toModel());
      }
    }
    return XemKetLuanHopModel(
      id: id ?? '',
      scheduleId: scheduleId ?? '',
      reportStatusId: reportStatusId ?? '',
      startDate: startDate ?? '',
      endDate: endDate ?? '',
      content: content ?? '',
      status: status ?? 0,
      statusName: statusName ?? '',
      scheduleTitle: scheduleTitle ?? '',
      reportStatus: reportStatus ?? '',
      reportStatusCode: reportStatusCode ?? '',
      createBy: createBy ?? '',
      canBoChuTriId: canBoChuTriId ?? '',
      nguoiTao: nguoiTao ?? '',
      nguoiChuTri: nguoiChuTri ?? '',
      files: listFile,
      reportTemplateId: reportTemplateId ?? '',
      noiDungHuy: noiDungHuy ?? '',
      title: title ?? '',
      createAt: createAt?.changeToNewPatternDate(
        DateTimeFormat.DATE_TIME_RECEIVE,
        DateTimeFormat.DATE_DD_MM_HM,
      ) ??
          '',
    );
  }
}

@JsonSerializable()
class ListFileDataresponse extends Equatable {
  @JsonKey(name: 'Id')
  String? Id;
  @JsonKey(name: 'Name')
  String? Name;
  @JsonKey(name: 'Extension')
  String? Extension;
  @JsonKey(name: 'Size')
  double? Size;
  @JsonKey(name: 'Path')
  String? Path;
  @JsonKey(name: 'Documents')
  String? Documents;
  @JsonKey(name: 'EntityId')
  String? EntityId;

  ListFileDataresponse();

  factory ListFileDataresponse.fromJson(Map<String, dynamic> json) =>
      _$ListFileDataresponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListFileDataresponseToJson(this);

  @override
  List<Object?> get props => throw [];

  FileDetailMeetModel toModel() => FileDetailMeetModel(
        Id: Id ?? '',
        Name: Name ?? '',
        Extension: Extension ?? '',
        Size: Size,
        Path: Path ?? '',
        Documents: Documents ?? '',
        EntityId: EntityId ?? '',
      );
}
