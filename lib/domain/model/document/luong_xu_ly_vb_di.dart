import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

//Trang thai can bo Trong luong xu ly
const CHO_TRINH_KY = 1;
const DA_TRINH_KY = 2;
const CHO_DUYET = 3;
const DA_DUYET = 4;
const CHO_CAP_SO = 5;
const CHO_BAN_HANH = 6;
const DA_BAN_HANH = 7;
const TRA_LAI = 8;

// Loại ban hành
const SOAN_THAO = 0;
const KY_DUYET = 1;
const KY_VAN_BAN = 2;
const KIEM_TRA_THUC_THE = 3;
const CAP_SO_BAN_HANH = 4;

List<DataRowLuongXuLy> chuThichTrangThai = [
  DataRowLuongXuLy(title: S.current.cho_trinh_ky, color: xamColor),
  DataRowLuongXuLy(title: S.current.cho_duyet, color: duyetColor),
  DataRowLuongXuLy(title: S.current.cho_cap_so, color: capSoColor),
  DataRowLuongXuLy(title: S.current.da_ban_hanh, color: banHanhColor),
  DataRowLuongXuLy(title: S.current.da_trinh_ky, color: daTrinhColor),
  DataRowLuongXuLy(title: S.current.da_duyet, color: daDuyetColor),
  DataRowLuongXuLy(title: S.current.cho_ban_hanh, color: choBanHanhLuongColor),
  DataRowLuongXuLy(title: S.current.tra_lai, color: traLaiColor)
];
List<DataRowLuongXuLy> chuThichTrangThaiLuong = [
  DataRowLuongXuLy(title: S.current.nguoi_soan_thao, color: soanThaoColor),
  DataRowLuongXuLy(title: S.current.nguoi_ky_duyet, color: kyDuyetColor),
  DataRowLuongXuLy(
    title: S.current.nguoi_ky_van_ban,
    color: nguoiKyVanBanColor,
  ),
  DataRowLuongXuLy(
    title: S.current.nguoi_kiem_tra_thuc_the,
    color: kiemTraThucTheColor,
  ),
  DataRowLuongXuLy(
      title: S.current.nguoi_cap_so_ban_hanh, color: nguoiCapSoColor)
];

class LuongXuLyVBDiModel {
  InfoCanBoModel? infoCanBo;

  int? trangThaiHienTai;
  int? loaiXuLy;
  String? idCha;
  String? idTrinhKy;
  String? id;
  bool? isDenLuot;
  LuongXuLyVBDiModel(
      {this.infoCanBo,
      this.trangThaiHienTai,
      this.loaiXuLy,
      this.idCha,
      this.idTrinhKy,
      this.id,
      this.isDenLuot});

  DataRowLuongXuLy getTrangThai() {
    switch (trangThaiHienTai) {
      case CHO_TRINH_KY:
        return DataRowLuongXuLy(title: S.current.cho_trinh_ky, color: xamColor);
      case DA_TRINH_KY:
        return DataRowLuongXuLy(
          title: S.current.da_trinh_ky,
          color: daTrinhColor,
        );
      case CHO_DUYET:
        return DataRowLuongXuLy(title: S.current.cho_duyet, color: duyetColor);
      case DA_DUYET:
        return DataRowLuongXuLy(title: S.current.da_duyet, color: daDuyetColor);
      case CHO_CAP_SO:
        return DataRowLuongXuLy(title: S.current.cho_cap_so, color: capSoColor);
      case CHO_BAN_HANH:
        return DataRowLuongXuLy(
            title: S.current.cho_ban_hanh, color: choBanHanhLuongColor);
      case DA_BAN_HANH:
        return DataRowLuongXuLy(
            title: S.current.da_ban_hanh, color: banHanhColor);
      case TRA_LAI:
        return DataRowLuongXuLy(title: S.current.tra_lai, color: traLaiColor);
    }
    return DataRowLuongXuLy(title: '', color: Colors.transparent);
  }

  DataRowLuongXuLy getLoaiBanHanh() {
    switch (loaiXuLy) {
      case SOAN_THAO:
        return DataRowLuongXuLy(
            title: S.current.nguoi_soan_thao, color: soanThaoColor);
      case KY_DUYET:
        return DataRowLuongXuLy(
            title: S.current.nguoi_ky_duyet, color: kyDuyetColor);
      case KY_VAN_BAN:
        return DataRowLuongXuLy(
            title: S.current.nguoi_ky_van_ban, color: nguoiKyVanBanColor);
      case KIEM_TRA_THUC_THE:
        return DataRowLuongXuLy(
            title: S.current.nguoi_kiem_tra_thuc_the,
            color: kiemTraThucTheColor);
      case CAP_SO_BAN_HANH:
        return DataRowLuongXuLy(
            title: S.current.nguoi_cap_so_ban_hanh, color: nguoiCapSoColor);
    }
    return DataRowLuongXuLy(title: '', color: Colors.transparent);
  }

  Color colorText() {
    switch (trangThaiHienTai) {
      case CHO_CAP_SO:
        return Colors.black;
    }
    return Colors.white;
  }
}

class DataRowLuongXuLy {
  final String title;
  final Color color;

  DataRowLuongXuLy({required this.title, required this.color});
}

class InfoCanBoModel {
  String? id;
  String? hoTen;
  String? donVi;
  String? chucVu;
  String? idChucVu;
  String? idDonVi;
  String? tenTaiKhoan;
  String? sdt;
  String? ngaySinh;
  bool? gioiTinh;
  String? email;
  String? pathAnhDaiDien;
  String? pathChuKy;
  String? user;
  String? anhDaiDien;
  String? anhChuKy;

  InfoCanBoModel(
      {this.id,
      this.hoTen,
      this.donVi,
      this.chucVu,
      this.idChucVu,
      this.idDonVi,
      this.tenTaiKhoan,
      this.sdt,
      this.ngaySinh,
      this.gioiTinh,
      this.email,
      this.pathAnhDaiDien,
      this.pathChuKy,
      this.user,
      this.anhDaiDien,
      this.anhChuKy});
}
