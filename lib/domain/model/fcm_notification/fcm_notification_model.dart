import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_detail_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/report_detail_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/main_diem_danh_tablet_screen.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

enum ScreenType {
  LICH_LAM_VIEC,
  LICH_HOP,
  VB_DI,
  VB_DEN,
  QLNV,
  PAKN,
  BAO_CAO,
  DIEM_DANH
}

class FcmNotificationModel {
  String screenType = '';
  String appCode = '';
  String detailId = '';
  String taskId = '';
  ScreenType? screenTypeEnum;
  bool isCaNhan = false;

  FcmNotificationModel.fromJson(Map<String, dynamic> json) {
    appCode = json['AppCode'] ?? '';
    screenType = json['ScreenType'] ?? '';
    detailId = json['Id'] ?? '';
    taskId = json['taskId'] ?? '';
    screenTypeEnum = toEnum();
  }
  ScreenType? toEnum() {
    switch (appCode) {
      case ScreenTypeFcm.VPDT:
        return toVPDT();
      case ScreenTypeFcm.QLVB:
        return toQLVB();
      case ScreenTypeFcm.QLNV:
        return toQLNV();
      case ScreenTypeFcm.PAKN:
        return ScreenType.PAKN;
      case ScreenTypeFcm.BAO_CAO:
        return ScreenType.BAO_CAO;
      case ScreenTypeFcm.DIEM_DANH:
        return ScreenType.DIEM_DANH;
    }
  }

  ScreenType? toVPDT() {
    switch (screenType) {
      case ScreenTypeFcm.LICH_LAM_VIEC:
        return ScreenType.LICH_LAM_VIEC;
      case ScreenTypeFcm.LICH_HOP:
        return ScreenType.LICH_HOP;
    }
  }

  ScreenType? toQLVB() {
    switch (screenType) {
      case ScreenTypeFcm.VAN_BAN_DEN:
        return ScreenType.VB_DEN;
      case ScreenTypeFcm.VAN_BAN_DI:
        return ScreenType.VB_DI;
    }
  }

  ScreenType? toQLNV() {
    switch (screenType) {
      case ScreenTypeFcm.CA_NHAN:
        isCaNhan = true;
        return ScreenType.QLNV;
      case ScreenTypeFcm.DON_VI:
        isCaNhan = false;
        return ScreenType.QLNV;
    }
  }
}

extension ScreenTypeScreen on ScreenType {
  Widget screen({required FcmNotificationModel data}) {
    switch (this) {
      case ScreenType.LICH_LAM_VIEC:
        return screenDevice(
          mobileScreen: ChiTietLichLamViecScreen(
            id: data.detailId,
          ),
          tabletScreen: ChiTietLamViecTablet(
            id: data.detailId,
          ),
        );
      case ScreenType.LICH_HOP:
        return screenDevice(
          mobileScreen: DetailMeetCalenderScreen(
            id: data.detailId,
          ),
          tabletScreen: DetailMeetCalenderTablet(
            id: data.detailId,
          ),
        );
      case ScreenType.VB_DI:
        return screenDevice(
          mobileScreen: ChiTietVanBanDiMobile(
            id: data.detailId,
          ),
          tabletScreen: ChiTietVanBanDiTablet(
            id: data.detailId,
          ),
        );
      case ScreenType.VB_DEN:
        return screenDevice(
          mobileScreen: ChiTietVanBanDenMobile(
            taskId: data.taskId,
            processId: data.detailId,
          ),
          tabletScreen: ChiTietVanBanDenTablet(
            taskId: data.taskId,
            processId: data.detailId,
          ),
        );
      case ScreenType.QLNV:
        return screenDevice(
          mobileScreen: ChiTietNhiemVuPhoneScreen(
            isCheck: data.isCaNhan,
            id: data.detailId,
          ),
          tabletScreen: ChiTietNhiemVuTabletScreen(
            isCheck: data.isCaNhan,
            id: data.detailId,
          ),
        );
      case ScreenType.PAKN:
        return screenDevice(
          mobileScreen: ChiTietPKAN(
            iD: data.detailId,
            taskID: data.taskId,
          ),
          tabletScreen: ChiTietPKANTablet(
            iD: data.detailId,
            taskID: data.taskId,
          ),
        );
      case ScreenType.BAO_CAO:
        return screenDevice(
          mobileScreen: ReportDetailMobile(
            isListView: true,
            cubit: ReportListCubit(),
            reportId: data.detailId,
            rootNotification: true,
            title: S.current.bao_cao,
          ),
          tabletScreen: ReportDetailTablet(
            isListView: true,
            cubit: ReportListCubit(),
            rootNotification: true,
            reportId: data.detailId,
            title: S.current.bao_cao,
          ),
        );
      case ScreenType.DIEM_DANH:
        return screenDevice(
          mobileScreen: const MainDiemDanhScreen(),
          tabletScreen: const MainDiemDanhTabletScreen(),
        );
    }
  }
}
