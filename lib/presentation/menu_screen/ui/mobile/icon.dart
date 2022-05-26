import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

String headerMenu() {
  if (APP_BACKGROUND != null) {
    return _iconHeaderBackGround();
  }
  switch (APP_THEME) {
    case AppMode.MAC_DINH:
      return ImageAssets.headerMenu;
    case AppMode.XANH:
      return ImageAssets.icHeaderMenuBlue;
    case AppMode.HONG:
      return ImageAssets.icHeaderMenuPink;
    case AppMode.VANG:
      return ImageAssets.icHeaderMenuYellow;
  }
}

String _iconHeaderBackGround() {
  switch (APP_BACKGROUND) {
    case AppBackGround.XUAN:
      return ImageAssets.headerMenuXuan;
    case AppBackGround.HA:
      return ImageAssets.headerMenuHa;

    case AppBackGround.THU:
      return ImageAssets.headerMenuThu;

    case AppBackGround.DONG:
      return ImageAssets.headerMenuDong;
    case AppBackGround.TET_NGUYEN_DAN:
      return ImageAssets.icHeaderMenuTetNguyenDan;
    case AppBackGround.LE_TINH_NHAN:
      return ImageAssets.icHeaderMenuLeTinhNhan;
    case AppBackGround.NGAY_QUOC_TE_PHU_NU:
      return ImageAssets.icHeaderMenuLeQuocTePhuNu;
    case AppBackGround.GIO_TO_HUNG_VUONG:
      return ImageAssets.icHeaderMenuGioToHungVuong;
    case AppBackGround.NGAY_QUOC_TE_LAO_DONG:
      return ImageAssets.icHeaderMenuQuocTeLaoDong;
    case AppBackGround.NGAY_QUOC_TE_THIEU_NHI:
      return ImageAssets.icHeaderMenuQuocTeThieuNhi;
    case AppBackGround.NGAY_QUOC_KHANH:
      return ImageAssets.icHeaderMenuQuocKhanh;
    case AppBackGround.TET_TRUNG_THU:
      return ImageAssets.icHeaderMenuTrungThu;
    case AppBackGround.NGAY_PHU_NU_VIET_NAM:
      return ImageAssets.icHeaderMenuPhuNuVietNam;
    case AppBackGround.NGAY_LE_GIANG_SINH:
      return ImageAssets.icHeaderMenuLeGiangSinh;
    case AppBackGround.NGAY_HALLOWEEN:
      return ImageAssets.icHeaderMenuHalloween;
    case AppBackGround.NGAY_NHA_GIAO_VIET_NAM:
      return ImageAssets.icHeaderMenuNhaGiaoVietNam;
    default:
      {
        return '';
      }
  }
}
