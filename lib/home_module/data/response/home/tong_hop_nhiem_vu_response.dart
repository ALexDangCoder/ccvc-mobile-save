

import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/utils/constants/app_constants.dart';

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
      Data(name: '',code: NhiemVuStatus.CHO_PHAN_XU_LY,value: 10).toDomain(),
      Data(name: '',code: NhiemVuStatus.CHUA_THUC_HIEN,value: 20).toDomain(),
      Data(name: '',code: NhiemVuStatus.DANG_THUC_HIEN,value: 30).toDomain(),
      Data(name: '',code: NhiemVuStatus.HOAN_THANH_NHIEM_VU,value: 40).toDomain(),
      // mapData[NhiemVuStatus.TONG_SO_NHIEM_VU]?.toDomain() ??
      //     TongHopNhiemVuModel(),
      // mapData[NhiemVuStatus.HOAN_THANH_NHIEM_VU]?.toDomain() ??
      //     TongHopNhiemVuModel(),
      // mapData[NhiemVuStatus.NHIEM_VU_DANG_THUC_HIEN]?.toDomain() ??
      //     TongHopNhiemVuModel(),
      // mapData[NhiemVuStatus.HOAN_THANH_QUA_HAN]?.toDomain() ??
      //     TongHopNhiemVuModel(),
      // mapData[NhiemVuStatus.DANG_THUC_HIEN_TRONG_HAN]?.toDomain() ??
      //     TongHopNhiemVuModel(),
      // mapData[NhiemVuStatus.DANG_THUC_HIEN_QUA_HAN]?.toDomain() ??
      //     TongHopNhiemVuModel(),
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
