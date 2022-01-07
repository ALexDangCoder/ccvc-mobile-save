import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tabbar_newspaper.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

final listFeature = [
  MenuType.hop,
  MenuType.quanLyNhiemVu,
  MenuType.hanhChinhCong,
  MenuType.yKienNguoiDan,
  MenuType.quanLyVanBan,
  MenuType.baoChiMangXaHoi,
  MenuType.ketNoi,
  MenuType.tienIch,
];
final listFeatureAccount = [
  MenuType.chuyenPhamVi,
  MenuType.caiDatGiaoDien,
  MenuType.hoiDap,
  MenuType.doiMatKhau
];
enum MenuType {
  hop,
  quanLyNhiemVu,
  hanhChinhCong,
  yKienNguoiDan,
  quanLyVanBan,
  baoChiMangXaHoi,
  ketNoi,
  tienIch,
  chuyenPhamVi,
  caiDatGiaoDien,
  hoiDap,
  doiMatKhau
}

extension MenuTypeItem on MenuType {
  MenuCellType getItem() {
    switch (this) {
      case MenuType.hop:
        return MenuCellType(url: ImageAssets.icCamera, title: S.current.hop);
      case MenuType.quanLyNhiemVu:
        return MenuCellType(
            url: ImageAssets.icQuanLyNhiemVu,
            title: S.current.quan_ly_nhiem_vu);
      case MenuType.hanhChinhCong:
        return MenuCellType(
            url: ImageAssets.icHanhChinhCong, title: S.current.hanh_chinh_cong);
      case MenuType.yKienNguoiDan:
        return MenuCellType(
            url: ImageAssets.icYKienNguoiDan,
            title: S.current.y_kien_nguoi_dan);
      case MenuType.quanLyVanBan:
        return MenuCellType(
            url: ImageAssets.icQuanLyVanBan, title: S.current.quan_ly_van_ban);
      case MenuType.baoChiMangXaHoi:
        return MenuCellType(
            url: ImageAssets.icBaoChiMangXaHoi,
            title: S.current.bao_chi_mang_xa_hoi);
      case MenuType.ketNoi:
        return MenuCellType(
            url: ImageAssets.icKetNoi, title: S.current.ket_noi);
      case MenuType.tienIch:
        return MenuCellType(
            url: ImageAssets.icTienIch, title: S.current.tien_ich);
      case MenuType.chuyenPhamVi:
        return MenuCellType(
            url: ImageAssets.icChuyenPhamVi, title: S.current.chuyen_pham_vi);
      case MenuType.caiDatGiaoDien:
        return MenuCellType(
            url: ImageAssets.icCaiDatGiaoDien,
            title: S.current.cai_dat_giao_dien);
      case MenuType.hoiDap:
        return MenuCellType(
            url: ImageAssets.icHoiDap, title: S.current.hoi_dap);
      case MenuType.doiMatKhau:
        return MenuCellType(
            url: ImageAssets.icDoiMatKhau, title: S.current.doi_mat_khau);
    }
  }
}

extension GetScreen on MenuType {
  Widget getScreen() {
    switch (this) {
      case MenuType.hop:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.quanLyNhiemVu:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.hanhChinhCong:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.yKienNguoiDan:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.quanLyVanBan:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.baoChiMangXaHoi:
        return const Scaffold(body: TabbarNewspaper());
      case MenuType.ketNoi:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.tienIch:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.chuyenPhamVi:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.caiDatGiaoDien:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.hoiDap:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.doiMatKhau:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
    }
  }
}

class MenuCellType {
  final String url;
  final String title;

  MenuCellType({required this.url, required this.title});
}
