import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

class PermissionMenuModel {
  final String code;
  final String id;
  MenuType? menuType;

  PermissionMenuModel({required this.code, required this.id}) {
    menuType = coverEnum();
  }

  MenuType? coverEnum() {
    switch (code) {
      case MenuItemConst.HOP:
        return MenuType.hop;
      case MenuItemConst.QUAN_LY_NHIEM_VU:
        return MenuType.quanLyNhiemVu;
      case MenuItemConst.HANH_CHINH_CONG:
        return MenuType.hanhChinhCong;
      case MenuItemConst.Y_KIEN_NGUOI_DAN:
        return MenuType.yKienNguoiDan;
      case MenuItemConst.QUAN_LY_VA_BAN:
        return MenuType.quanLyVanBan;
      case MenuItemConst.BAO_CHI_MANG_XA_HOI:
        return MenuType.baoChiMangXaHoi;
      case MenuItemConst.KET_NOI:
        return MenuType.ketNoi;
      case MenuItemConst.TIEN_ICH:
        return MenuType.tienIch;
    }
  }
}
