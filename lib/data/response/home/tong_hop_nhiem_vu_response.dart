import 'dart:developer';

import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/home/tong_hop_nhiem_vu_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

class TongHopNhiemVuResponse {
  dynamic messages;
  List<Data>? data;
  dynamic validationResult;
  bool? isSuccess;
  Map<String, Data> mapData = {};
  TongHopNhiemVuResponse(
      {this.messages, this.data, this.validationResult, this.isSuccess});

  TongHopNhiemVuResponse.fromJson(Map<String, dynamic> json) {
    messages = json['Messages'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        final result = Data.fromJson(v);
        mapData.addAll({result.code ?? '': result});
        data!.add(result);
      });
    }
    validationResult = json['ValidationResult'];
    isSuccess = json['IsSuccess'];
  }
  List<TongHopNhiemVuModel> toDomain() {
    return [
      mapData[NhiemVuStatus.TONG_SO_NHIEM_VU]?.toDomain() ??
          TongHopNhiemVuModel(),
      mapData[NhiemVuStatus.HOAN_THANH_NHIEM_VU]?.toDomain() ??
          TongHopNhiemVuModel(),
      mapData[NhiemVuStatus.NHIEM_VU_DANG_THUC_HIEN]?.toDomain() ??
          TongHopNhiemVuModel(),
      mapData[NhiemVuStatus.HOAN_THANH_QUA_HAN]?.toDomain() ??
          TongHopNhiemVuModel(),
      mapData[NhiemVuStatus.DANG_THUC_HIEN_TRONG_HAN]?.toDomain() ??
          TongHopNhiemVuModel(),
      mapData[NhiemVuStatus.DANG_THUC_HIEN_QUA_HAN]?.toDomain() ??
          TongHopNhiemVuModel(),
    ];
  }
}

class Data {
  String? name;
  String? code;
  int? value;

  Data({this.name, this.code, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    code = json['Code'];
    value = json['Value'];
  }
  TongHopNhiemVuModel toDomain() => TongHopNhiemVuModel(
        name: name ?? '',
        code: code ?? '',
        value: value ?? 0,
      );
}
