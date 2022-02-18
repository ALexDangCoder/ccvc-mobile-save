import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tabbar_newspaper.dart';
import 'package:ccvc_mobile/presentation/forgot_password/ui/mobile/forgot_password_screen.dart';
import 'package:ccvc_mobile/presentation/forgot_password/ui/tablet/forgot_password_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/ui/mobile/hoi_dap_screen.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/ui/tablet/hoi_dap_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/main_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/main_lich_hop_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/qlvb_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/qlvb_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
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
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icCameraTablet,
            iconMobile: ImageAssets.icCamera,
          ),
          title: S.current.hop,
        );
      case MenuType.quanLyNhiemVu:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icQuanLyNhiemVuTablet,
            iconMobile: ImageAssets.icQuanLyNhiemVu,
          ),
          title: S.current.quan_ly_nhiem_vu,
        );
      case MenuType.hanhChinhCong:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icHanhChinhCongTablet,
            iconMobile: ImageAssets.icHanhChinhCong,
          ),
          title: S.current.hanh_chinh_cong,
        );
      case MenuType.yKienNguoiDan:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icYKienNguoiDanTablet,
            iconMobile: ImageAssets.icYKienNguoiDan,
          ),
          title: S.current.y_kien_nguoi_dan,
        );
      case MenuType.quanLyVanBan:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icQuanLyVanBanTablet,
            iconMobile: ImageAssets.icQuanLyVanBan,
          ),
          title: S.current.quan_ly_van_ban,
        );
      case MenuType.baoChiMangXaHoi:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icBaoChiTablet,
            iconMobile: ImageAssets.icBaoChiMangXaHoi,
          ),
          title: S.current.bao_chi_mang_xa_hoi,
        );
      case MenuType.ketNoi:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icKetNoiTablet,
            iconMobile: ImageAssets.icKetNoi,
          ),
          title: S.current.ket_noi,
        );
      case MenuType.tienIch:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icTienIchTablet,
            iconMobile: ImageAssets.icTienIch,
          ),
          title: S.current.tien_ich,
        );
      case MenuType.chuyenPhamVi:
        return MenuCellType(
          url: ImageAssets.icChuyenPhamVi,
          title: S.current.chuyen_pham_vi,
        );
      case MenuType.caiDatGiaoDien:
        return MenuCellType(
          url: ImageAssets.icCaiDatGiaoDien,
          title: S.current.cai_dat_giao_dien,
        );
      case MenuType.hoiDap:
        return MenuCellType(
          url: ImageAssets.icHoiDap,
          title: S.current.hoi_dap,
        );
      case MenuType.doiMatKhau:
        return MenuCellType(
          url: ImageAssets.icDoiMatKhau,
          title: S.current.doi_mat_khau,
        );
    }
  }

  String urlIconScreen({
    required String iconMobile,
    required String iconTablet,
  }) {
    return APP_DEVICE == DeviceType.MOBILE ? iconMobile : iconTablet;
  }
}

extension GetScreen on MenuType {
  Widget getScreen() {
    switch (this) {
      case MenuType.hop:
        return screenDevice(
          mobileScreen: const MainLichHop(),
          tabletScreen: const MainLichHopTabLet(),
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
        return screenDevice(
          mobileScreen: const QLVBScreenMobile(),
          tabletScreen: const QLVBScreenTablet(),
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
        return screenDevice(
          mobileScreen: const HoiDapScreen(),
          tabletScreen: const HoiDapScreenTablet(),
        );
      case MenuType.doiMatKhau:
        return screenDevice(
          mobileScreen: const ForgotPassWordScreen(),
          tabletScreen: const ForgotPassWordScreenTablet(),
        );
    }
  }
}

class MenuCellType {
  final String url;
  final String title;

  MenuCellType({required this.url, required this.title});
}
