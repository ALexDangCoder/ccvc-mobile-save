
import 'package:ccvc_mobile/domain/model/home/tinh_hinh_y_kien_model.dart';

class YKienNguoiDanResponse {
  List<DanhSachKetQua>? danhSachKetQua;
  String? noiDungThongDiep;
  int? maTraLoi;

  YKienNguoiDanResponse(
      {this.danhSachKetQua, this.noiDungThongDiep, this.maTraLoi});

  YKienNguoiDanResponse.fromJson(Map<String, dynamic> json) {
    if (json['DanhSachKetQua'] != null) {
      danhSachKetQua = <DanhSachKetQua>[];
      json['DanhSachKetQua'].forEach((v) {
        danhSachKetQua!.add(DanhSachKetQua.fromJson(v));
      });
    }
    noiDungThongDiep = json['NoiDungThongDiep'];
    maTraLoi = json['MaTraLoi'];
  }
  List<TinhHinhYKienModel> toDomain() {
    final data = <TinhHinhYKienModel>[];
    danhSachKetQua?.forEach((element) {
      data.add(element.toDomain());
    });
    return data;
  }
}

class DanhSachKetQua {
  String? status;
  int? soLuong;
  double? phanTram;
  int? tongSo;

  DanhSachKetQua({this.status, this.soLuong, this.phanTram, this.tongSo});

  DanhSachKetQua.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    soLuong = json['SoLuong'];
    phanTram = json['PhanTram'];
    tongSo = json['TongSo'];
  }
  TinhHinhYKienModel toDomain() =>
      TinhHinhYKienModel(soLuong: soLuong ?? 0, status: status ?? '');
}
