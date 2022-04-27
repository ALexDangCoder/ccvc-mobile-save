import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/ket_qua_xu_ly_response.dart';

class KetQuaXuLyModel {
  String iD;
  int depth;
  String location;
  String donViId;
  String canBoId;
  String soVanBanDi;
  String ngayKyVanBanDi;
  String coQuanBanHanh;
  String nguoiKyDuyet;
  String trichYeu;
  String tenDonVi;
  String tenCanBo;
  List<TaiLieuDinhKemModel> dSFile;
  String taskContent;
  int trangThai;
  bool isChuTri;

  KetQuaXuLyModel(
      {required this.iD,
      required this.depth,
      required this.location,
      required this.donViId,
      required this.canBoId,
      required this.soVanBanDi,
      required this.ngayKyVanBanDi,
      required this.coQuanBanHanh,
      required this.nguoiKyDuyet,
      required this.trichYeu,
      required this.tenDonVi,
      required this.tenCanBo,
      required this.dSFile,
      required this.taskContent,
      required this.trangThai,
      required this.isChuTri,});
}
class TaiLieuDinhKemModel {
  String id;
  String ten;
  String duongDan;
  String dungLuong;
  bool daKySo;
  bool daGanQR;
  String ngayTao;
  String nguoiTaoId;
  bool suDung;
  int  loaiFileDinhKem;

  TaiLieuDinhKemModel(
      {required this.id,
        required this.ten,
        required this.duongDan,
        required this.dungLuong,
        required this.daKySo,
        required this.daGanQR,
        required this.ngayTao,
        required this.nguoiTaoId,
        required this.suDung,
        required this.loaiFileDinhKem,});
}

