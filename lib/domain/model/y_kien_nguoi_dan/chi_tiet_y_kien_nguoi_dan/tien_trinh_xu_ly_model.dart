class TienTrinhXuLyModel {
  String id;
  String paknId;
  String noiDungXuLy;
  String trangThaiXuLy;
  int trangThaiBatDauId;
  int trangThaiChuyenDenId;
  String ngayBatDau;
  String ngayKetThuc;
  String taiKhoanThaoTac;
  String donViThaoTac;
  String nguoiThaoTac;
  List<TaiLieuTienTrinhXuLyModel> taiLieus;

  TienTrinhXuLyModel({
    required this.id,
    required this.paknId,
    required this.noiDungXuLy,
    required this.trangThaiXuLy,
    required this.trangThaiBatDauId,
    required this.trangThaiChuyenDenId,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.taiKhoanThaoTac,
    required this.donViThaoTac,
    required this.nguoiThaoTac,
    required this.taiLieus,
  });
}

class TaiLieuTienTrinhXuLyModel {
  String kienNghiId;
  String ten;
  String duongDan;
  int kieu;
  int thutu;
  int kichThuoc;
  String noiDungKichThuoc;
  String ext;
  String kieuDinhKem;
  String id;
  String thoiGianTaoMoi;
  String thoiGianCapNhat;

  TaiLieuTienTrinhXuLyModel(
      {required this.kienNghiId,
      required this.ten,
      required this.duongDan,
      required this.kieu,
      required this.thutu,
      required this.kichThuoc,
      required this.noiDungKichThuoc,
      required this.ext,
      required this.kieuDinhKem,
      required this.id,
      required this.thoiGianTaoMoi,
      required this.thoiGianCapNhat});
}
