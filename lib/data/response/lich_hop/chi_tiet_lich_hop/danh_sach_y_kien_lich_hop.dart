import 'dart:convert';

import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
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
  String? avatar;

  Data(
      {this.id,
      this.scheduleId,
      this.content,
      this.nguoiTao,
      this.ngayTao,
      this.nguoiTaoId,
      this.traLoiYKien,
      this.avatar,

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['scheduleId'];
    content = json['content'];
    nguoiTao = json['nguoiTao'];
    ngayTao = json['ngayTao'];
    nguoiTaoId = json['nguoiTaoId'];
    traLoiYKien = json['traLoiYKien'];
    avatar = json['avatar'];
  }

  YkienCuocHopModel toDomain() {
    List<YkienCuocHopModel> listTraLoi = [];
    if (traLoiYKien != null) {
      final listData = jsonDecode(traLoiYKien ?? '') as List<dynamic>;
      listTraLoi = listData.map((e) => DataTraLoiYKien.fromJson(e).toDomain()).toList();
    }
    return YkienCuocHopModel(
      id: id,
      ngayTao: ngayTao?.changeToNewPatternDate(
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_TIME_PICKER,
      ),
      avatar : avatar ?? '',
      nguoiTaoId: nguoiTaoId ?? '',
      nguoiTao: nguoiTao ?? '',
      content: content?.parseHtml() ?? '',
      scheduleId: scheduleId,
      traLoiYKien: listTraLoi,
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
      ngayTao: ngayTao?.changeToNewPatternDate(
        DateTimeFormat.DATE_TIME_RECEIVE,
        DateTimeFormat.DATE_TIME_PICKER,
      ),
      nguoiTao: nguoiTao ?? '',
      content: content?.parseHtml() ?? '',
    );
  }
}
