import 'dart:convert';

import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DanhSachYKienlichHopResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachYKienlichHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  DanhSachYKienlichHopResponse.fromJson(Map<String, dynamic> json) {
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
  String? content;
  String? nguoiTao;
  String? ngayTao;
  String? nguoiTaoId;
  String? traLoiYKien;

  Data(
      {this.id,
      this.scheduleId,
      this.content,
      this.nguoiTao,
      this.ngayTao,
      this.nguoiTaoId,
      this.traLoiYKien});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['scheduleId'];
    content = json['content'];
    nguoiTao = json['nguoiTao'];
    ngayTao = json['ngayTao'];
    nguoiTaoId = json['nguoiTaoId'];
    traLoiYKien = json['traLoiYKien'];
  }

  YkienCuocHopModel toDomain() {
    final List<YkienCuocHopModel> listFile = [];
    if (traLoiYKien != null) {
      final listData = jsonDecode(traLoiYKien ?? '') as List<dynamic>;
      for (final element in listData) {
        listFile.add(DataTraLoiYKien.fromJson(element).toDomain());
      }
    }
    return YkienCuocHopModel(
      id: id,
      ngayTao:
          DateTime.parse(ngayTao ?? DateTime.now().toString()).formatApiTung,
      nguoiTaoId: nguoiTaoId ?? '',
      nguoiTao: nguoiTao ?? '',
      content: content?.parseHtml() ?? '',
      scheduleId: scheduleId,
      traLoiYKien: listFile,
    );
  }
}

class DataTraLoiYKien {
  String? id;
  String? scheduleId;
  String? content;
  String? nguoiTao;
  String? ngayTao;
  String? nguoiTaoId;

  DataTraLoiYKien({
    this.id,
    this.scheduleId,
    this.content,
    this.nguoiTao,
    this.ngayTao,
    this.nguoiTaoId,
  });

  DataTraLoiYKien.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    scheduleId = json['ScheduleId'];
    content = json['Content'];
    nguoiTao = json['NguoiTao'];
    ngayTao = json['NgayTao'];
    nguoiTaoId = json['NguoiTaoId'];
  }

  YkienCuocHopModel toDomain() {
    return YkienCuocHopModel(
      ngayTao:
          DateTime.parse(ngayTao ?? DateTime.now().toString()).formatApiTung,
      nguoiTao: nguoiTao ?? '',
      content: content?.parseHtml() ?? '',
    );
  }
}
