import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';



extension GetDataNoti on String {
  String urlIconScreen({
    required String iconMobile,
    required String iconTablet,
  }) {
    return APP_DEVICE == DeviceType.MOBILE ? iconMobile : iconTablet;
  }

  String getIcon() {
    switch (this) {
      case 'QLVB':
        return urlIconScreen(
          iconTablet: ImageAssets.icCameraTablet,
          iconMobile: ImageAssets.icCamera,
        );

      case 'QLNV':
        return urlIconScreen(
          iconTablet: ImageAssets.icQuanLyNhiemVuTablet,
          iconMobile: ImageAssets.icQuanLyNhiemVu,
        );
      case 'COMMON':
        return urlIconScreen(
          iconTablet: ImageAssets.icHanhChinhCongTablet,
          iconMobile: ImageAssets.icHanhChinhCong,
        );
      case 'VMS':
        return urlIconScreen(
          iconTablet: ImageAssets.icYKienNguoiDanTablet,
          iconMobile: ImageAssets.icYKienNguoiDan,
        );
      case 'PAKN':
        return urlIconScreen(
          iconTablet: ImageAssets.icQuanLyVanBanTablet,
          iconMobile: ImageAssets.icQuanLyVanBan,
        );
      case 'VPDT':
        return urlIconScreen(
          iconTablet: ImageAssets.icBaoChiTablet,
          iconMobile: ImageAssets.icBaoChiMangXaHoi,
        );
      case 'APPDIEUHANH':
        return urlIconScreen(
          iconTablet: ImageAssets.icKetNoiTablet,
          iconMobile: ImageAssets.icKetNoi,
        );

      default:
        return urlIconScreen(
          iconTablet: ImageAssets.icTienIchTablet,
          iconMobile: ImageAssets.icTienIch,
        );
    }
  }
}
