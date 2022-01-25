import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/calendar_work_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/document_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/event_of_day_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/items/meeting_schedule_widget.dart';
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
          homeItemType: WidgetType.wordProcessState,
        );
      case WidgetType.document:
        return const DocumentWidget(homeItemType: WidgetType.document);
      case WidgetType.summaryOfTask:
        return const SummaryOfTaskWidget(
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return const SituationOfHandlingPeopleWidget(
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return const PeopleOpinions(
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return const CalendarWorkWidget(
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return const MeetingScheduleWidget(
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return const PressSocialNetWork(
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return const WorkListWidget(
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return const EventOfDayWidget(
          homeItemType: WidgetType.eventOfDay,
        );
      case WidgetType.sinhNhat:
        return const SinhNhatWidget(homeItemType: WidgetType.sinhNhat);
    }
  }
  Widget getItemsTablet() {
    switch (this) {
      case WidgetType.wordProcessState:
        return  WordProcessingStateTabletWidget(
          homeItemType: WidgetType.wordProcessState,
        );
      case WidgetType.document:
        return const DocumentTabletWidget(homeItemType: WidgetType.document);
      case WidgetType.summaryOfTask:
        return const SummaryOfTaskTabletWidget(
          homeItemType: WidgetType.summaryOfTask,
        );
      case WidgetType.situationHandlingPeople:
        return const SituationOfHandlingPeopleTabletWidget(
          homeItemType: WidgetType.situationHandlingPeople,
        );
      case WidgetType.peopleOpinions:
        return const PeopleOpinionsTabletWidget(
          homeItemType: WidgetType.peopleOpinions,
        );
      case WidgetType.workSchedule:
        return const CalendarWorkTabletWidget(
          homeItemType: WidgetType.workSchedule,
        );
      case WidgetType.meetingSchedule:
        return const MeetingScheduleTabletWidget(
          homeItemType: WidgetType.meetingSchedule,
        );
      case WidgetType.pressSocialNetWork:
        return const PressSocialNetWorkTabletWidget(
          homeItemType: WidgetType.pressSocialNetWork,
        );
      case WidgetType.listWork:
        return const WorkListTabletWidget(
          homeItemType: WidgetType.listWork,
        );
      case WidgetType.eventOfDay:
        return const EventOfDayTabletWidget(
          homeItemType: WidgetType.eventOfDay,
        );

      case WidgetType.sinhNhat:
        return const SinhNhatTabletWidget(homeItemType: WidgetType.sinhNhat);
    }
  }
}
