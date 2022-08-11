import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_detail_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/report_detail_tablet.dart';
import 'package:ccvc_mobile/domain/model/fcm_notification/fcm_notification_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/tablet/chi_tiet_cong_viec_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/chi_tiet_pakn.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/chi_tiet_pakn_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_di_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

enum ScreenType {
  LICH_LAM_VIEC,
  LICH_HOP,
  VB_DI,
  VB_DEN,
  QLNV,
  QLCV,
  HANH_CHINH_CONG,
  PAKN,
  BAO_CAO,
  DIEM_DANH
}

class FcmNotificationModel {
  String screenType = '';
  String appCode = '';
  String detailId = '';
  ScreenType? screenTypeEnum;
  FcmNotificationModel.fromJson(Map<String, dynamic> json) {
    appCode = json['AppCode'] ?? '';
    screenType = json['screenType'] ?? appCode;
    detailId = json['Id'] ?? '';
    screenTypeEnum = toEnum();
  }
  ScreenType? toEnum() {
    switch (screenType) {
      case ScreenTypeFcm.LICH_LAM_VIEC:
        return ScreenType.LICH_LAM_VIEC;
      case ScreenTypeFcm.LICH_HOP:
        return ScreenType.LICH_HOP;
      case ScreenTypeFcm.QUAN_LY_NHIEM_VU:
        return ScreenType.QLNV;
      case ScreenTypeFcm.PAKN:
        return ScreenType.PAKN;
      case ScreenTypeFcm.BAO_CAO:
        return ScreenType.BAO_CAO;
      case ScreenTypeFcm.DIEM_DANH:
        return ScreenType.DIEM_DANH;
      case ScreenTypeFcm.VAN_BAN_DI:
        return ScreenType.VB_DI;
      case ScreenTypeFcm.VAN_BAN_DEN:
        return ScreenType.VB_DEN;
    }
  }
}

extension ScreenTypeScreen on ScreenType {
  Widget screen(String id) {
    switch (this) {
      case ScreenType.LICH_LAM_VIEC:
        return screenDevice(
          mobileScreen: ChiTietLichLamViecScreen(
            id: id,
          ),
          tabletScreen: ChiTietLamViecTablet(
            id: id,
          ),
        );
      case ScreenType.LICH_HOP:
        return screenDevice(
            mobileScreen: DetailMeetCalenderScreen(
              id: id,
            ),
            tabletScreen: DetailMeetCalenderTablet(
              id: id,
            ));
      case ScreenType.VB_DI:
        return screenDevice(
            mobileScreen: ChiTietVanBanDiMobile(
              id: id,
            ),
            tabletScreen: ChiTietVanBanDiTablet(
              id: id,
            ));
      case ScreenType.VB_DEN:
        return screenDevice(
            mobileScreen: ChiTietVanBanDenMobile(
              taskId: id,
              processId: id,
            ),
            tabletScreen: ChiTietVanBanDenTablet(
              taskId: id,
              processId: id,
            ));
      case ScreenType.QLNV:
        return screenDevice(
            mobileScreen: ChiTietNhiemVuPhoneScreen(
              isCheck: false,
              id: id,
            ),
            tabletScreen: ChiTietNhiemVuTabletScreen(
              isCheck: false,
              id: id,
            ));
      case ScreenType.QLCV:
        return screenDevice(
            mobileScreen: ChitietCongViecNhiemVuMobile(
              id: id,
            ),
            tabletScreen: ChitietCongViecNhiemVuTablet(
              id: id,
            ));
      case ScreenType.HANH_CHINH_CONG:
        return const Scaffold();
      case ScreenType.PAKN:
        return screenDevice(
            mobileScreen: ChiTietPKAN(
              iD: id,
              taskID: id,
            ),
            tabletScreen: ChiTietPKANTablet(
              iD: id,
              taskID: id,
            ));
      case ScreenType.BAO_CAO:
        return screenDevice(
          mobileScreen: ReportDetailMobile(
            isListView: true,
            cubit: ReportListCubit(),
            reportModel: ReportItem(id: id),
            title: S.current.bao_cao,
          ),
          tabletScreen: ReportDetailTablet(
            isListView: true,
            cubit: ReportListCubit(),
            reportModel: ReportItem(id: id),
            title: S.current.bao_cao,
          ),
        );
      case ScreenType.DIEM_DANH:
        return screenDevice(
            mobileScreen: const MainDiemDanhScreen(),
            tabletScreen: const MainDiemDanhTabletScreen());
    }
  }
}
