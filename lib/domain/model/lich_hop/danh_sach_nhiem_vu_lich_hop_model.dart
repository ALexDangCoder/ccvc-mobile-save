import 'ket_luan_hop_model.dart';

class DanhSachNhiemVuLichHopModel {
  String soNhiemVu = '';
  String noiDungTheoDoi = '';
  String tinhHinhThucHienNoiBo = '';
  String hanXuLy;

  String loaiNhiemVu = '';
  TrangThai trangThai = TrangThai.ChoDuyet;

  DanhSachNhiemVuLichHopModel({
    required this.soNhiemVu,
    required this.noiDungTheoDoi,
    required this.tinhHinhThucHienNoiBo,
    required this.hanXuLy,
    required this.loaiNhiemVu,
    required this.trangThai,
  });
}

