import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';

class DashboardTinhHinhPAKNResponse {
  Data? data;

  bool? isSuccess;

  DashboardTinhHinhPAKNResponse({this.data, this.isSuccess});

  DashboardTinhHinhPAKNResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;

    isSuccess = json['IsSuccess'];
  }
}

class Data {
  int? choTiepNhan;
  int? phanXuLy;
  int? dangXuLy;
  int? choDuyet;
  int? choBoSungThongTin;
  int? quaHan;
  int? denHan;
  int? trongHan;
  int? choTiepNhanXuLy;
  int? choXuLy;
  int? choPhanXuLy;
  int? daPhanCong;
  int? daHoanThanh;

  Data(
      {this.choTiepNhan,
      this.phanXuLy,
      this.dangXuLy,
      this.choDuyet,
      this.choBoSungThongTin,
      this.quaHan,
      this.denHan,
      this.trongHan,
      this.choTiepNhanXuLy,
      this.choXuLy,
      this.choPhanXuLy,
      this.daPhanCong,
      this.daHoanThanh});

  Data.fromJson(Map<String, dynamic> json) {
    choTiepNhan = json['ChoTiepNhan'];
    phanXuLy = json['PhanXuLy'];
    dangXuLy = json['DangXuLy'];
    choDuyet = json['ChoDuyet'];
    choBoSungThongTin = json['ChoBoSungThongTin'];
    quaHan = json['QuaHan'];
    denHan = json['DenHan'];
    trongHan = json['TrongHan'];
    choTiepNhanXuLy = json['ChoTiepNhanXuLy'];
    choXuLy = json['ChoXuLy'];
    choPhanXuLy = json['ChoPhanXuLy'];
    daPhanCong = json['DaPhanCong'];
    daHoanThanh = json['DaHoanThanh'];
  }

  DocumentDashboardModel toDomain() => DocumentDashboardModel(
      soLuongChoTiepNhan: choTiepNhan ?? 0,
      soLuongPhanXuLy: phanXuLy ?? 0,
      soLuongDangXuLy: dangXuLy ?? 0,
      soLuongChoDuyet: choDuyet ?? 0,
      soLuongChoBoSungThongTin: choBoSungThongTin ?? 0,
      soLuongQuaHan: quaHan ?? 0,
      soLuongDenHan: denHan ?? 0,
      soLuongTrongHan: trongHan ?? 0,
      soLuongChoTiepNhanXuLy: choTiepNhanXuLy ?? 0,
      soLuongChoXuLy: choXuLy ?? 0,
      soLuongChoPhanXuLy: choPhanXuLy ?? 0,
      soLuongDaPhanCong: daPhanCong ?? 0,
      soLuongDaHoanThanh: daHoanThanh ?? 0);
}
