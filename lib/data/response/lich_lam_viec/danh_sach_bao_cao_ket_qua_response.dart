import 'dart:convert';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DanhSachBaoCaoResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachBaoCaoResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  DanhSachBaoCaoResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? id;
  String? scheduleId;
  String? reportStatusId;

  String? content;

  String? scheduleTitle;
  String? reportStatus;
  String? reportStatusCode;
  String? createBy;
  String? canBoChuTriId;
  String? nguoiTao;
  String? nguoiChuTri;
  List<Files>? files;

  Data({
    this.id,
    this.scheduleId,
    this.reportStatusId,
    this.content,
    this.scheduleTitle,
    this.reportStatus,
    this.reportStatusCode,
    this.createBy,
    this.canBoChuTriId,
    this.nguoiTao,
    this.nguoiChuTri,
    this.files,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['scheduleId'];
    reportStatusId = json['reportStatusId'];

    content = json['content'];

    scheduleTitle = json['scheduleTitle'];
    reportStatus = json['reportStatus'];
    reportStatusCode = json['reportStatusCode'];
    createBy = json['createBy'];
    canBoChuTriId = json['canBoChuTriId'];
    nguoiTao = json['nguoiTao'];
    nguoiChuTri = json['nguoiChuTri'];
    if (json['files'] != null) {
      final dynamic result = const JsonDecoder().convert(json['files']);
      final file = <Files>[];
      result.forEach((v) {
        file.add(Files.fromJson(v));
      });
      files = file;
    }
  }

  BaoCaoModel toDomain() => BaoCaoModel(
        content: content?.parseHtml() ?? '',
        listFile: files?.map((e) => e.toDomain()).toList() ?? [],
        id: id ?? '',
        reportStatusCode: reportStatusCode ?? '',
        reportStatusId: reportStatusId ?? '',
        canBoChuTriId: canBoChuTriId ?? '',
      );
}

class Files {
  String? id;
  String? name;
  String? extension;
  String? path;
  String? entityId;
  double? size;

  Files.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    extension = json['Extension'];
    path = json['Path'];
    extension = json['EntityId'];
    size = json['Size'];
  }

  FileModel toDomain() =>
      FileModel(id: id ?? '', name: name ?? '', path: path, fileLength: size);
}
