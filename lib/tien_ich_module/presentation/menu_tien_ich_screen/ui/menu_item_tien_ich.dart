import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/mobile/speech_to_text_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/tablet/speech_to_text_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/ui/mobile/chuyen_van_ban_thanh_giong_noi_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/ui/tablet/chuyen_van_ban_thanh_giong_noi_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/danh_ba_dien_tu_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/tablet/danh_ba_dien_tu_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/mobile/danh_sach_cong_viec_tien_ich_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/tablet/danh_sach_cong_viec_tien_ich_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/ui/mobile/huong_dan_su_dung_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/ui/tablet/huong_dan_su_dung_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/mobile/lich_am_duong_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/tablet/lich_am_duong_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/mang_xa_hoi_noi_bo/ui/mobile/mang_xa_hoi_noi_bo_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/mang_xa_hoi_noi_bo/ui/tablet/mang_xa_hoi_noi_bo_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/mobile/phien_dich_tu_dong_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/tablet/phien_dich_tu_dong_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/tra_cuu_van_ban_phap_luat/ui/mobile/tra_cuu_van_ban_phap_luat_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/tra_cuu_van_ban_phap_luat/ui/tablet/tra_cuu_van_ban_phap_luat_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';

enum MenuTypeTienIch {
  chuyenGiongNoiThanhVanBan,
  chuyenVanBanThanhGiongNoi,
  phienDichTuDong,
  lichAmDuong,
  danhBaDienTu,
  danhSachCongViec,
}

final listFeatureTienIch = [
  MenuTypeTienIch.chuyenGiongNoiThanhVanBan,
  MenuTypeTienIch.chuyenVanBanThanhGiongNoi,
  MenuTypeTienIch.phienDichTuDong,
  MenuTypeTienIch.lichAmDuong,
  MenuTypeTienIch.danhBaDienTu,
  MenuTypeTienIch.danhSachCongViec,
];

extension MenuTypeItem on MenuTypeTienIch {
  MenuCellTypeTienIch getItemTienIch() {
    switch (this) {
      case MenuTypeTienIch.chuyenGiongNoiThanhVanBan:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icChuyenGiongNoiThanhVanBan,
            iconMobile: ImageAssets.icChuyenGiongNoiThanhVanBan,
          ),
          title: S.current.chuyen_giong_noi_thanh_van_ban,
        );
      case MenuTypeTienIch.chuyenVanBanThanhGiongNoi:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icChuyenVanBanThanhGiongNoi,
            iconMobile: ImageAssets.icChuyenVanBanThanhGiongNoi,
          ),
          title: S.current.chuyen_van_ban_thanh_giong_noi,
        );
      case MenuTypeTienIch.phienDichTuDong:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icPhienDichTuDong,
            iconMobile: ImageAssets.icPhienDichTuDong,
          ),
          title: S.current.phien_dich_tu_dong,
        );
      case MenuTypeTienIch.lichAmDuong:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icLichAmDuong,
            iconMobile: ImageAssets.icLichAmDuong,
          ),
          title: S.current.lich_am_duong,
        );
      case MenuTypeTienIch.danhBaDienTu:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icDanhBaDienTu,
            iconMobile: ImageAssets.icDanhBaDienTu,
          ),
          title: S.current.danh_ba_dien_tu,
        );
      case MenuTypeTienIch.danhSachCongViec:
        return MenuCellTypeTienIch(
          url: urlIconScreenTienIch(
            iconTablet: ImageAssets.icDanhSachCongViec,
            iconMobile: ImageAssets.icDanhSachCongViec,
          ),
          title: S.current.danh_sach_cong_viec,
        );
    }
  }

  String urlIconScreenTienIch({
    required String iconMobile,
    required String iconTablet,
  }) {
    return isMobile() ? iconMobile : iconTablet;
  }
}

extension GetScreen on MenuTypeTienIch {
  Widget getScreenTienIch() {
    switch (this) {
      case MenuTypeTienIch.chuyenGiongNoiThanhVanBan:
        return screenDevice(
          mobileScreen: const SpeechToTextMobile(),
          tabletScreen: const SpeechToTextTablet(),
        );
      case MenuTypeTienIch.chuyenVanBanThanhGiongNoi:
        return screenDevice(
          mobileScreen: const ChuyenVanBanThanhGiongNoi(),
          tabletScreen: const ChuyenVanBanThanhGiongNoiTablet(),
        );
      case MenuTypeTienIch.phienDichTuDong:
        return screenDevice(
          mobileScreen: const PhienDichTuDongMobile(),
          tabletScreen: const PhienDichTuDongTablet(),
        );
      case MenuTypeTienIch.lichAmDuong:
        return screenDevice(
          mobileScreen: const LichAmDuongMobile(),
          tabletScreen: const LichAmDuongTablet(),
        );
      case MenuTypeTienIch.danhBaDienTu:
        return screenDevice(
          mobileScreen: const DanhBaDienTuMobile(),
          tabletScreen: const DanhBaDienTuTablet(),
        );
      case MenuTypeTienIch.danhSachCongViec:
        return screenDevice(
          mobileScreen: const DanhSachCongViecTienIchMobile(),
          tabletScreen: const DanhSachCongViecTienIchTablet(),
        );
    }
  }
}

class MenuCellTypeTienIch {
  final String url;
  final String title;

  MenuCellTypeTienIch({
    required this.url,
    required this.title,
  });
}
