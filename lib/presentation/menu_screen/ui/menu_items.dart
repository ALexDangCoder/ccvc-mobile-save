import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_screen_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/report_screen_tablet.dart';
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_tablet_screen.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/main_ho_tro_ky_thuat_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/main_ho_tro_ky_thuat_tablet.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/ui/phone/danh_sach_chung_screen.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/ui/tab/danh_sach_chung_screen_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/main_nhiem_vu/main_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/main_nhiem_vu/main_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tabbar_newspaper.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tablet/tabbar_newspaper_tablet.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/cai_dat_giao_dien_screen.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/ui/mobile/main_calendar_meeting.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/ui/tablet/main_calendar_meeting_tablet.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/main_canlendar_mobile_refactor.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/tablet/main_canlendar_refactor_tablet.dart';
import 'package:ccvc_mobile/presentation/change_password/ui/mobile/change_password_screen.dart';
import 'package:ccvc_mobile/presentation/change_password/ui/tablet/change_password_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/ui/mobile/hoi_dap_screen.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/ui/tablet/hoi_dap_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/coming_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/main_menu_qlvb/main_menu_qlvb_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/qlvb_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/qlvb_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/y_kien_nguoidan_screen.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/yknd_tablet_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/menu_tien_ich_screen/ui/mobile/menu_tien_ich_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/menu_tien_ich_screen/ui/tablet/menu_tien_ich_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

final listFeature = [
  MenuType.lichLamViec,
  MenuType.hop,
  MenuType.quanLyVanBan,
  MenuType.quanLyNhiemVu,
  MenuType.hanhChinhCong,
  MenuType.yKienNguoiDan,
  MenuType.baoCao,
  MenuType.tuongTacNoiBo,
  MenuType.baoChiMangXaHoi,
  MenuType.diemDanh,
  MenuType.hoTroKyThuat,
  MenuType.ketNoi,
  MenuType.tienIch,
];
final listFeatureAccount = [
  MenuType.chuyenPhamVi,
  MenuType.caiDatGiaoDien,
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
  doiMatKhau,
  tuongTacNoiBo,
  lichLamViec,
  baoCao,
  diemDanh,
  hoTroKyThuat
}

extension MenuTypeItem on MenuType {
  MenuCellType getItem() {
    switch (this) {
      case MenuType.lichLamViec:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.itemMenuLichLamViecTablet,
            iconMobile: ImageAssets.itemMenuLichLamViec,
          ),
          title: S.current.lich_lam_viec,
        );
      case MenuType.hop:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icCameraTablet,
            iconMobile: ImageAssets.icCamera,
          ),
          title: S.current.hop,
        );
      case MenuType.quanLyVanBan:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icQuanLyVanBanTablet,
            iconMobile: ImageAssets.icQuanLyVanBan,
          ),
          title: S.current.quan_ly_van_ban,
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
          title: S.current.phan_anh_kien_nghi,
        );
      case MenuType.baoCao:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.itemMenuBaoCaoTablet,
            iconMobile: ImageAssets.itemMenuBaoCao,
          ),
          title: S.current.bac_cao,
        );
      case MenuType.tuongTacNoiBo:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.itemMenuTuongTacBoiBoTablet,
            iconMobile: ImageAssets.itemMenuTuongTacBoiBo,
          ),
          title: S.current.tuong_tac_noi_bo,
        );
      case MenuType.baoChiMangXaHoi:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icBaoChiTablet,
            iconMobile: ImageAssets.icBaoChiMangXaHoi,
          ),
          title: S.current.bao_chi_mang_xa_hoi,
        );
      case MenuType.diemDanh:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icDiemDanhTabletMenu,
            iconMobile: ImageAssets.icDiemDanhTopMenu,
          ),
          title: S.current.diem_danh,
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
      case MenuType.doiMatKhau:
        return MenuCellType(
          url: ImageAssets.icDoiMatKhau,
          title: S.current.doi_mat_khau,
        );
      case MenuType.hoTroKyThuat:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icHTKTTablet,
            iconMobile: ImageAssets.ic_ho_tro_ky_thuat,
          ),
          title: S.current.ho_tro_ky_thuat,
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
          mobileScreen: const MainCalendarMeeting(),
          // mobileScreen: const MainLichHop(),
          tabletScreen: const MainCalendarMeetingTablet(),
        );
      case MenuType.quanLyNhiemVu:
        return screenDevice(
          mobileScreen: const MainNhieVuMobile(),
          tabletScreen: const MainNhiemVuTablet(),
        );
      case MenuType.hanhChinhCong:
        return ComingSoonScreen(title: S.current.hanh_chinh_cong);
      case MenuType.yKienNguoiDan:
        return screenDevice(
          mobileScreen: const YKienNguoiDanScreen(),
          tabletScreen: const YKienNguoiDanTablet(),
        );
      case MenuType.quanLyVanBan:
        return screenDevice(
          mobileScreen: const MainMenuQlVBMobile(),
          tabletScreen: const QLVBScreenTablet(),
        );
      case MenuType.baoChiMangXaHoi:
        return screenDevice(
          mobileScreen: const Scaffold(
            body: TabbarNewspaper(),
          ),
          tabletScreen: const TabbarNewspaperTablet(),
        );
      case MenuType.diemDanh:
        return screenDevice(
          mobileScreen: const MainDiemDanhScreen(),
          tabletScreen: const MainDiemDanhTabletScreen(),
        );
      case MenuType.ketNoi:
        return screenDevice(
          mobileScreen: DanhSachChungScreen(
            key: UniqueKey(),
          ),
          tabletScreen: const DanhSachChungScreenTablet(),
        );
      case MenuType.tienIch:
        return screenDevice(
          mobileScreen: const MenuTienIchMobile(),
          tabletScreen: const MenuTienIchTablet(),
        );
      case MenuType.chuyenPhamVi:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case MenuType.caiDatGiaoDien:
        return const CaiDatGiaoDienScreen();
      case MenuType.doiMatKhau:
        return screenDevice(
          mobileScreen: const ChangePassWordScreen(),
          tabletScreen: const ChangePassWordScreenTablet(),
        );
      case MenuType.tuongTacNoiBo:
        return ComingSoonScreen(title: S.current.tuong_tac_noi_bo);
      case MenuType.lichLamViec:
        return screenDevice(
          mobileScreen: const MainCanlendanMobileRefactor(
            isBack: true,
          ),
          tabletScreen: const MainCalendarRefactorTablet(
            isBack: true,
          ),
        );
      case MenuType.baoCao:
        return screenDevice(
          mobileScreen: ReportScreenMobile(
            title: S.current.bac_cao,
          ),
          tabletScreen: ReportScreenTablet(
            title: S.current.bac_cao,
          ),
        );
      case MenuType.hoTroKyThuat:
        return screenDevice(
          mobileScreen: const MainHoTroKyThuatMobile(),
          tabletScreen: const MainHoTroKyThuatTablet(),
        );
    }
  }
}

class MenuCellType {
  final String url;
  final String title;

  MenuCellType({required this.url, required this.title});
}
