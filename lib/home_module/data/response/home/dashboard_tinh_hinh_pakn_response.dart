import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
class TinhHinhXuLyPAKNCaNhan {

  DataCaNhan? data;

  bool? isSuccess;

  TinhHinhXuLyPAKNCaNhan(
      { this.data,this.isSuccess});

  TinhHinhXuLyPAKNCaNhan.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ?  DataCaNhan.fromJson(json['Data']) : null;
    isSuccess = json['IsSuccess'];
  }
  DocumentDashboardModel toDomain() => DocumentDashboardModel(
      soLuongChoTiepNhan: data?.tiepNhan?.choTiepNhan ?? 0,
      soLuongPhanXuLy: data?.tiepNhan?.phanXuLy ?? 0,
      soLuongDangXuLy: data?.tiepNhan?.dangXuLy ?? 0,
      soLuongChoDuyet: data?.tiepNhan?.choDuyet  ?? 0,
      soLuongChoBoSungThongTin: data?.tiepNhan?.choBoSungThongTin  ?? 0,
      soLuongQuaHan: data?.hanXuLy?.quaHan ?? 0,
      soLuongDenHan: data?.hanXuLy?.denHan ?? 0,
      soLuongTrongHan: data?.hanXuLy?.trongHan ?? 0,
      soLuongChoTiepNhanXuLy: data?.xuLy?.choTiepNhanXuLy ?? 0,
      soLuongChoXuLy: data?.xuLy?.choXuLy ?? 0,
      soLuongChoPhanXuLy: data?.xuLy?.choPhanXuLy ?? 0,
      soLuongDaPhanCong: data?.xuLy?.daPhanCong ?? 0,
      soLuongDaHoanThanh: data?.xuLy?.daHoanThanh ?? 0,
     soLuongChoDuyetXuLy: data?.xuLy?.choDuyet ?? 0,
  );


}

class DataCaNhan {
  TiepNhan? tiepNhan;
  XuLy? xuLy;
  HanXuLy? hanXuLy;

  DataCaNhan({this.tiepNhan, this.xuLy, this.hanXuLy});

  DataCaNhan.fromJson(Map<String, dynamic> json) {
    tiepNhan = json['TiepNhan'] != null
        ?  TiepNhan.fromJson(json['TiepNhan'])
        : null;
    xuLy = json['XuLy'] != null ?  XuLy.fromJson(json['XuLy']) : null;
    hanXuLy =
    json['HanXuLy'] != null ?  HanXuLy.fromJson(json['HanXuLy']) : null;
  }


}

class TiepNhan {
  int? choTiepNhan;
  int? phanXuLy;
  int? dangXuLy;
  int? choDuyet;
  int? choBoSungThongTin;
  int? daHoanThanh;

  TiepNhan(
      {this.choTiepNhan,
        this.phanXuLy,
        this.dangXuLy,
        this.choDuyet,
        this.choBoSungThongTin,
        this.daHoanThanh});

  TiepNhan.fromJson(Map<String, dynamic> json) {
    choTiepNhan = json['ChoTiepNhan'];
    phanXuLy = json['PhanXuLy'];
    dangXuLy = json['DangXuLy'];
    choDuyet = json['ChoDuyet'];
    choBoSungThongTin = json['ChoBoSungThongTin'];
    daHoanThanh = json['DaHoanThanh'];
  }


}

class XuLy {
  int? choTiepNhanXuLy;
  int? choXuLy;
  int? choDuyet;
  int? choPhanXuLy;
  int? daPhanCong;
  int? daHoanThanh;

  XuLy(
      {this.choTiepNhanXuLy,
        this.choXuLy,
        this.choDuyet,
        this.choPhanXuLy,
        this.daPhanCong,
        this.daHoanThanh});

  XuLy.fromJson(Map<String, dynamic> json) {
    choTiepNhanXuLy = json['ChoTiepNhanXuLy'];
    choXuLy = json['ChoXuLy'];
    choDuyet = json['ChoDuyet'];
    choPhanXuLy = json['ChoPhanXuLy'];
    daPhanCong = json['DaPhanCong'];
    daHoanThanh = json['DaHoanThanh'];
  }


}

class HanXuLy {
  int? quaHan;
  int? denHan;
  int? trongHan;

  HanXuLy({this.quaHan, this.denHan, this.trongHan});

  HanXuLy.fromJson(Map<String, dynamic> json) {
    quaHan = json['QuaHan'];
    denHan = json['DenHan'];
    trongHan = json['TrongHan'];
  }

}
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
