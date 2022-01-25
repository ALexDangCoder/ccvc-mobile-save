import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/calendar_work_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/document_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/event_of_day_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/meeting_schedule_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/nhiem_vu_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/people_opinions_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/press_social_net_word_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/sinh_nhat_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/situation_of_handling_people_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/summary_of_task_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/word_processing_state_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/work_list_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/calendar_work_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/document__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/event_of_day_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/meeting_schedule__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/nhiem_vu_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/people_opinions__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/press_social_net_word__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/sinh_nhat__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/situation_of_handling_people__tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/summary_of_task_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/word_processing_state_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/items/work_list_tablet_widget.dart';
import 'package:flutter/cupertino.dart';

extension ItemExtension on WidgetType {
  Widget getItemsMobile() {
    switch (this) {
      case WidgetType.wordProcessState:
        return const WordProcessingStateWidget(
          key: ValueKey(WidgetType.wordProcessState),
          homeItemType: WidgetType.wordProcessState,
        );
      case WidgetType.document:
        return const DocumentWidget(
          key: ValueKey(WidgetType.document),
          homeItemType: WidgetType.document,
        );
      case WidgetType.summaryOfTask:
        return const SummaryOfTaskWidget(
          key: ValueKey(WidgetType.summaryOfTask),
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return const SituationOfHandlingPeopleWidget(
          key: ValueKey(WidgetType.situationHandlingPeople),
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return const PeopleOpinions(
          key: ValueKey(WidgetType.peopleOpinions),
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return const CalendarWorkWidget(
          key: ValueKey(WidgetType.workSchedule),
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return const MeetingScheduleWidget(
          key: ValueKey(WidgetType.meetingSchedule),
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return const PressSocialNetWork(
          key: ValueKey(WidgetType.pressSocialNetWork),
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return const WorkListWidget(
          key: ValueKey(WidgetType.listWork),
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return const EventOfDayWidget(
          key: ValueKey(WidgetType.eventOfDay),
          homeItemType: WidgetType.eventOfDay,
        );
      case WidgetType.sinhNhat:
        return const SinhNhatWidget(
          key: ValueKey(WidgetType.sinhNhat),
          homeItemType: WidgetType.sinhNhat,
        );
      case WidgetType.nhiemVu:
        return const NhiemVuWidget(
          key: ValueKey(WidgetType.nhiemVu),
          homeItemType: WidgetType.nhiemVu,
        );
    }
  }

  Widget getItemsTablet() {
    switch (this) {
      case WidgetType.wordProcessState:
        return WordProcessingStateTabletWidget(
          homeItemType: WidgetType.wordProcessState,
          key: KeyKeepAlive._keyWordProcessState,
        );
      case WidgetType.document:
        return DocumentTabletWidget(
          key: KeyKeepAlive._keyDocument,
          homeItemType: WidgetType.document,
        );
      case WidgetType.summaryOfTask:
        return SummaryOfTaskTabletWidget(
          key: KeyKeepAlive._keySummaryOfTask,
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return SituationOfHandlingPeopleTabletWidget(
          key: KeyKeepAlive._keySituationHandlingPeople,
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return PeopleOpinionsTabletWidget(
          key: KeyKeepAlive._keyPeopleOpinions,
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return CalendarWorkTabletWidget(
          key: KeyKeepAlive._keyWorkSchedule,
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return MeetingScheduleTabletWidget(
          key: KeyKeepAlive._keyMeetingSchedule,
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return PressSocialNetWorkTabletWidget(
          key: KeyKeepAlive._keyPressSocialNetWork,
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return WorkListTabletWidget(
          key: KeyKeepAlive._keyListWork,
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return EventOfDayTabletWidget(
          key: KeyKeepAlive._keyEventOfDay,
          homeItemType: WidgetType.eventOfDay,
        );

      case WidgetType.sinhNhat:
        return SinhNhatTabletWidget(
          key: KeyKeepAlive._keySinhNhat,
          homeItemType: WidgetType.sinhNhat,
        );
      case WidgetType.nhiemVu:
        return NhiemVuTabletWidget(
          key: KeyKeepAlive._keyNhiemVu,
          homeItemType: WidgetType.nhiemVu,
        );
    }
  }
}

class KeyKeepAlive {
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
}
