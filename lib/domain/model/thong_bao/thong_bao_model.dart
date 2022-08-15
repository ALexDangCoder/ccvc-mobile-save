import 'package:ccvc_mobile/generated/l10n.dart';

import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

enum ThongBaoType {
  QLNV,
  PAKN,
  BAO_CAO,
  DIEM_DANH,
  QLVB,
  LichHopMoi,
  TinNhanMoi,
}

extension ThongBaoTypeEx on ThongBaoType {
  String getIcon() {
    switch (this) {
      case ThongBaoType.QLNV:
        return ImageAssets.icQuanLyNhiemVu;
      case ThongBaoType.PAKN:
        return ImageAssets.icYKienNguoiDan;
      case ThongBaoType.BAO_CAO:
        return ImageAssets.itemMenuBaoCao;
      case ThongBaoType.DIEM_DANH:
        return ImageAssets.icDiemDanhTopMenu;
      case ThongBaoType.QLVB:
        return ImageAssets.icQuanLyVanBan;
      default:
        return '';
    }
  }

  String getTitle() {
    switch (this) {
      case ThongBaoType.QLNV:
        return S.current.quan_ly_nhiem_vu;
      case ThongBaoType.PAKN:
        return S.current.y_kien_nguoi_dan;
      case ThongBaoType.BAO_CAO:
        return S.current.bao_cao;
      case ThongBaoType.DIEM_DANH:
        return S.current.diem_danh;
      case ThongBaoType.QLVB:
        return S.current.quan_ly_van_ban;
      default:
        return '';
    }
  }
}

class ThongBaoModel {
  String? id;
  String? name;
  String? code;
  String? description;
  int? unreadCount;
  int? total;
  bool? statusSwitch;
  ThongBaoType? thongBaoType;
  ThongBaoModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.unreadCount,
    required this.total,
    this.statusSwitch = false,
  }) {
    thongBaoType = fromEnum();
  }
  ThongBaoType? fromEnum() {
    switch (id) {
      case ThongBaoKeyConst.QLNV:
        return ThongBaoType.QLNV;
      case ThongBaoKeyConst.QLVB:
        return ThongBaoType.QLVB;
      case ThongBaoKeyConst.DIEM_DANH:
        return ThongBaoType.DIEM_DANH;
      case ThongBaoKeyConst.BAO_CAO:
        return ThongBaoType.BAO_CAO;
      case ThongBaoKeyConst.PAKN:
        return ThongBaoType.PAKN;
    }
  }
}
