import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/ket_luan_hop_model.dart';

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

DanhSachNhiemVuLichHopModel danhSachNhiemVuLichHopModel =
    DanhSachNhiemVuLichHopModel(
  soNhiemVu: '2',
  noiDungTheoDoi: 'Cuộc họp giao ban',
  tinhHinhThucHienNoiBo: 'Cuộc họp giao ban',
  hanXuLy: '2022-02-15T07:45:00',
  loaiNhiemVu: 'Nhiệm vụ đơn vị',
  trangThai: TrangThai.DaDuyet,
);
