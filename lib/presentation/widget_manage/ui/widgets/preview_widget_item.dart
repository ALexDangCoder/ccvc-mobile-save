import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/items/phan_anh_kien_nghi_don_vi_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/items/situation_of_handling_people_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/items/van_ban_don_vi_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/items/phan_anh_kien_nghi_don_vi_tablet.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/items/van_ban_don_vi_tablet.dart';
import 'package:flutter/cupertino.dart';

import '/home_module/presentation/home_screen/ui/mobile/items/calendar_work_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/document_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/meeting_schedule_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/nhiem_vu_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/people_opinions_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/press_social_net_word_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/sinh_nhat_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/summary_of_task_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/word_processing_state_widget.dart';
import '/home_module/presentation/home_screen/ui/mobile/items/work_list_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/calendar_work_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/document_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/meeting_schedule__tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/nhiem_vu_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/people_opinions__tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/press_social_net_word__tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/sinh_nhat__tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/summary_of_task_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/tinh_hinh_pakn_cua_ca_nhan_tablet.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/word_processing_state_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/items/work_list_tablet_widget.dart';

extension ItemPreview on WidgetType {
  Widget getItemsMobilePreview() {
    switch (this) {
      case WidgetType.wordProcessState:
        return WordProcessingStateWidget(
          key: KeyKeepAlivePreview._keyWordProcessState,
          homeItemType: WidgetType.wordProcessState,
        );
      case WidgetType.document:
        return DocumentWidget(
          key: KeyKeepAlivePreview._keyDocument,
          homeItemType: WidgetType.document,
        );
      case WidgetType.summaryOfTask:
        return SummaryOfTaskWidget(
          key: KeyKeepAlivePreview._keySummaryOfTask,
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return TinhHinhPAKNCuaCaNhanMobileWidget(
          key: KeyKeepAlivePreview._keySituationHandlingPeople,
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return PeopleOpinions(
          key: KeyKeepAlivePreview._keyPeopleOpinions,
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return CalendarWorkWidget(
          key: KeyKeepAlivePreview._keyWorkSchedule,
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return MeetingScheduleWidget(
          key: KeyKeepAlivePreview._keyMeetingSchedule,
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return PressSocialNetWork(
          key: KeyKeepAlivePreview._keyPressSocialNetWork,
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return WorkListWidget(
          key: KeyKeepAlivePreview._keyListWork,
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return const SizedBox();
      // return EventOfDayWidget(
      //   key: KeyKeepAlivePreview._keyEventOfDay,
      //   homeItemType: WidgetType.eventOfDay,
      // );
      case WidgetType.sinhNhat:
        return SinhNhatWidget(
          key: KeyKeepAlivePreview._keySinhNhat,
          homeItemType: WidgetType.sinhNhat,
        );
      case WidgetType.nhiemVu:
        return NhiemVuWidget(
          key: KeyKeepAlivePreview._keyNhiemVu,
          homeItemType: WidgetType.nhiemVu,
        );
      case WidgetType.vanBanDonVi:
        return VanBanDonViWidget(
          key: KeyKeepAlivePreview._keyVabBanDonVi,
          homeItemType: WidgetType.vanBanDonVi,
        );
      case WidgetType.phanAnhKienNghiDonVi:
        return PhanAnhKienNghiDonViWidget(
          key: KeyKeepAlivePreview._keyPhanAnhKienNghiDonVi,
          homeItemType: WidgetType.phanAnhKienNghiDonVi,
        );
    }
  }

  Widget getItemsTabletPreview() {
    switch (this) {
      case WidgetType.wordProcessState:
        return WordProcessingStateTabletWidget(
          homeItemType: WidgetType.wordProcessState,
          key: KeyKeepAlivePreview._keyWordProcessState,
        );
      case WidgetType.document:
        return DocumentTabletWidget(
          key: KeyKeepAlivePreview._keyDocument,
          homeItemType: WidgetType.document,
        );
      case WidgetType.summaryOfTask:
        return SummaryOfTaskTabletWidget(
          key: KeyKeepAlivePreview._keySummaryOfTask,
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return TinhHinhPAKNCuaCaNhanTabletWidget(
          key: KeyKeepAlivePreview._keySituationHandlingPeople,
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return PeopleOpinionsTabletWidget(
          key: KeyKeepAlivePreview._keyPeopleOpinions,
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return CalendarWorkTabletWidget(
          key: KeyKeepAlivePreview._keyWorkSchedule,
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return MeetingScheduleTabletWidget(
          key: KeyKeepAlivePreview._keyMeetingSchedule,
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return PressSocialNetWorkTabletWidget(
          key: KeyKeepAlivePreview._keyPressSocialNetWork,
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return WorkListTabletWidget(
          key: KeyKeepAlivePreview._keyListWork,
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return const SizedBox();
      // return EventOfDayTabletWidget(
      //   key: KeyKeepAlivePreview._keyEventOfDay,
      //   homeItemType: WidgetType.eventOfDay,
      // );

      case WidgetType.sinhNhat:
        return SinhNhatTabletWidget(
          key: KeyKeepAlivePreview._keySinhNhat,
          homeItemType: WidgetType.sinhNhat,
        );
      case WidgetType.nhiemVu:
        return NhiemVuTabletWidget(
          key: KeyKeepAlivePreview._keyNhiemVu,
          homeItemType: WidgetType.nhiemVu,
        );
      case WidgetType.vanBanDonVi:
        return VanBanDonViTablet(
          key: KeyKeepAlivePreview._keyVabBanDonVi,
          homeItemType: WidgetType.vanBanDonVi,
        );
      case WidgetType.phanAnhKienNghiDonVi:
        return PhanAnhKienNghiDonViTablet(
          key: KeyKeepAlivePreview._keyPhanAnhKienNghiDonVi,
          homeItemType: WidgetType.phanAnhKienNghiDonVi,
        );
    }
  }
}

class KeyKeepAlivePreview {
  static final _keyWordProcessState = GlobalKey();
  static final _keyDocument = GlobalKey();
  static final _keySummaryOfTask = GlobalKey();
  static final _keyNhiemVu = GlobalKey();
  static final _keySituationHandlingPeople = GlobalKey();
  static final _keyPeopleOpinions = GlobalKey();
  static final _keyWorkSchedule = GlobalKey();
  static final _keyMeetingSchedule = GlobalKey();
  static final _keyPressSocialNetWork = GlobalKey();
  static final _keyListWork = GlobalKey();
  static final _keyEventOfDay = GlobalKey();
  static final _keySinhNhat = GlobalKey();
  static final _keyVabBanDonVi = GlobalKey();
  static final _keyPhanAnhKienNghiDonVi = GlobalKey();
}
