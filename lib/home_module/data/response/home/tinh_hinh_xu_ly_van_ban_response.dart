class TinhHinhXuLyVanBanResponse {

  Data? data;
  int? statusCode;
  bool? isSuccess;

  TinhHinhXuLyVanBanResponse(
      {this.data, this.statusCode, this.isSuccess});

  TinhHinhXuLyVanBanResponse.fromJson(Map<String, dynamic> json) {

    data = json['Data'] != null ?  Data.fromJson(json['Data']) : null;
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
  }

}

class Data {
  VanBanDen? vanBanDen;
  VanBanDi? vanBanDi;

  Data({this.vanBanDen, this.vanBanDi});

  Data.fromJson(Map<String, dynamic> json) {
    vanBanDen = json['VanBanDen'] != null
        ?  VanBanDen.fromJson(json['VanBanDen'])
        : null;
    vanBanDi = json['VanBanDi'] != null
        ?  VanBanDi.fromJson(json['VanBanDi'])
        : null;
  }


}

class VanBanDen {
  int? choVaoSo;
  int? choXuLy;
  int? dangXuLy;
  int? daXuLy;
  int? quaHan;
  int? trongHan;
  int? denHan;

  VanBanDen(
      {this.choVaoSo,
        this.choXuLy,
        this.dangXuLy,
        this.daXuLy,
        this.quaHan,
        this.trongHan,
        this.denHan});

  VanBanDen.fromJson(Map<String, dynamic> json) {
    choVaoSo = json['ChoVaoSo'];
    choXuLy = json['ChoXuLy'];
    dangXuLy = json['DangXuLy'];
    daXuLy = json['DaXuLy'];
    quaHan = json['QuaHan'];
    trongHan = json['TrongHan'];
    denHan = json['DenHan'];
  }


}

class VanBanDi {
  int? choTrinhKy;
  int? choXuLy;
  int? daXuLy;
  int? choCapSo;
  int? choBanHanh;

  VanBanDi(
      {this.choTrinhKy,
        this.choXuLy,
        this.daXuLy,
        this.choCapSo,
        this.choBanHanh});

  VanBanDi.fromJson(Map<String, dynamic> json) {
    choTrinhKy = json['ChoTrinhKy'];
    choXuLy = json['ChoXuLy'];
    daXuLy = json['DaXuLy'];
    choCapSo = json['ChoCapSo'];
    choBanHanh = json['ChoBanHanh'];
  }


}