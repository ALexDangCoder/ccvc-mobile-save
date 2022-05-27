import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';

class TongHopNhiemVuResponse {

  Data? data;
  int? statusCode;
  bool? isSuccess;

  TongHopNhiemVuResponse(
      { this.data, this.statusCode, this.isSuccess});

  TongHopNhiemVuResponse.fromJson(Map<String, dynamic> json) {

    data = json['Data'] != null ?  Data.fromJson(json['Data']) : null;
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
  }


}

class Data {
  int? choPhanXuLy;
  int? chuaThucHien;
  int? dangThucHien;
  int? hoanThanhNhiemVu;

  Data(
      {this.choPhanXuLy,
        this.chuaThucHien,
        this.dangThucHien,
        this.hoanThanhNhiemVu});

  Data.fromJson(Map<String, dynamic> json) {
    choPhanXuLy = json['ChoPhanXuLy'];
    chuaThucHien = json['ChuaThucHien'];
    dangThucHien = json['DangThucHien'];
    hoanThanhNhiemVu = json['HoanThanhNhiemVu'];
  }

  DocumentDashboardModel toDomain() =>DocumentDashboardModel(

    soLuongChoPhanXuLy: choPhanXuLy ??0,
    soLuongChuaThucHien: chuaThucHien ?? 0,
    soLuongDangThucHien: dangThucHien ?? 0,
    soLuongHoanThanhNhiemVu: hoanThanhNhiemVu ?? 0,


  );
}