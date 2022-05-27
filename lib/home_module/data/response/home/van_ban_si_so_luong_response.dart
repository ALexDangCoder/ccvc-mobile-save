
import '/home_module/domain/model/home/document_dashboard_model.dart';

class VanBanDiSoLuongResponse {
  String? messages;
  Data? data;
  int? statusCode;
  bool? isSuccess;

  VanBanDiSoLuongResponse(
      {this.messages, this.data, this.statusCode, this.isSuccess});

  VanBanDiSoLuongResponse.fromJson(Map<String, dynamic> json) {
    messages = json['Messages'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
  }
}

class Data {
  int? soLuongChoTrinhKy;
  int? soLuongChoXuLy;
  int? soLuongDaXuLy;
  int? soLuongChoYKien;
  int? soLuongDaChoYKien;
  int? soLuongChoBanHanh;
  int? soLuongChoCapSo;
  int? soLuongDaBanHanh;
  int? soLuongNoiBo;
  int? soLuongDaTraLai;
  int? soLuongQuaHan;
  int? soLuongDenHan;
  int? soLuongTrongHan;
  int? soLuongKhongCoHan;
  int? soLuongThuongKhan;

  Data(
      {this.soLuongChoTrinhKy,
      this.soLuongChoXuLy,
      this.soLuongDaXuLy,
      this.soLuongChoYKien,
      this.soLuongDaChoYKien,
      this.soLuongChoBanHanh,
      this.soLuongChoCapSo,
      this.soLuongDaBanHanh,
      this.soLuongNoiBo,
      this.soLuongDaTraLai,
      this.soLuongQuaHan,
      this.soLuongDenHan,
      this.soLuongTrongHan,
      this.soLuongKhongCoHan,
      this.soLuongThuongKhan});

  Data.fromJson(Map<String, dynamic> json) {
    soLuongChoTrinhKy = json['SoLuongChoTrinhKy'];
    soLuongChoXuLy = json['SoLuongChoXuLy'];
    soLuongDaXuLy = json['SoLuongDaXuLy'];
    soLuongChoYKien = json['SoLuongChoYKien'];
    soLuongDaChoYKien = json['SoLuongDaChoYKien'];
    soLuongChoBanHanh = json['SoLuongChoBanHanh'];
    soLuongChoCapSo = json['SoLuongChoCapSo'];
    soLuongDaBanHanh = json['SoLuongDaBanHanh'];
    soLuongNoiBo = json['SoLuongNoiBo'];
    soLuongDaTraLai = json['SoLuongDaTraLai'];
    soLuongQuaHan = json['SoLuongQuaHan'];
    soLuongDenHan = json['SoLuongDenHan'];
    soLuongTrongHan = json['SoLuongTrongHan'];
    soLuongKhongCoHan = json['SoLuongKhongCoHan'];
    soLuongThuongKhan = json['SoLuongThuongKhan'];
  }
  DocumentDashboardModel toDomain() => DocumentDashboardModel(
      soLuongChoTrinhKy: soLuongChoTrinhKy ?? 0,
      soLuongChoXuLy: soLuongChoXuLy ?? 0,
      soLuongDaXuLy: soLuongDaXuLy ?? 0,
      soLuongChoCapSo: soLuongChoCapSo ?? 0,
      soLuongChoBanHanh: soLuongChoBanHanh??0);
}
