import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

String headerMenu() {
  if (APP_BACKGROUND != null) {
    return _iconHeaderBackGround();
  }
  switch (APP_THEME) {
    case AppMode.MAC_DINH:
      return ImageAssets.imgHeaderMenuTablet;
    case AppMode.XANH:
      return ImageAssets.icHeaderMenuBlueTablet;
    case AppMode.HONG:
      return ImageAssets.icHeaderMenuPinkTablet;
    case AppMode.VANG:
      return ImageAssets.icHeaderMenuYellowTablet;
  }
}

String _iconHeaderBackGround() {
  switch (APP_BACKGROUND) {
    case AppBackGround.XUAN:
      return ImageAssets.headerMenuXuanTablet;
    case AppBackGround.HA:
      return ImageAssets.headerMenuHaTablet;

    case AppBackGround.THU:
      return ImageAssets.headerMenuThuTablet;

    case AppBackGround.DONG:
      return ImageAssets.headerMenuDongTablet;
    case AppBackGround.TET_NGUYEN_DAN:
      return ImageAssets.icHeaderMenuTetNguyenDanTablet;
    case AppBackGround.LE_TINH_NHAN:
      return ImageAssets.icHeaderMenuLeTinhNhanTablet;
    case AppBackGround.NGAY_QUOC_TE_PHU_NU:
      return ImageAssets.icHeaderMenuLeQuocTePhuNuTablet;
    case AppBackGround.GIO_TO_HUNG_VUONG:
      return ImageAssets.icHeaderMenuGioToHungVuongTablet;
    case AppBackGround.NGAY_QUOC_TE_LAO_DONG:
      return ImageAssets.icHeaderMenuQuocTeLaoDongTablet;
    case AppBackGround.NGAY_QUOC_TE_THIEU_NHI:
      return ImageAssets.icHeaderMenuQuocTeThieuNhiTablet;
    case AppBackGround.NGAY_QUOC_KHANH:
      return ImageAssets.icHeaderMenuQuocKhanhTablet;
    case AppBackGround.TET_TRUNG_THU:
      return ImageAssets.icHeaderMenuTrungThuTablet;
    case AppBackGround.NGAY_PHU_NU_VIET_NAM:
      return ImageAssets.icHeaderMenuPhuNuVietNamTablet;
    case AppBackGround.NGAY_LE_GIANG_SINH:
      return ImageAssets.icHeaderMenuLeGiangSinhTablet;
    case AppBackGround.NGAY_HALLOWEEN:
      return ImageAssets.icHeaderMenuHalloweenTablet;
    case AppBackGround.NGAY_NHA_GIAO_VIET_NAM:
      return ImageAssets.icHeaderMenuNhaGiaoVietNamTablet;
    default:
      {
        return '';
      }
  }
}
