import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/calender_form_month.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/calender_week_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/in_calender_form.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/list/in_list_form.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_day_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_month_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_week_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/list/in_list_form_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/cupertino.dart';

extension LichLVOpition on Type_Choose_Option_Day {
  Widget getLichLVDangList() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InListFormTablet(
          isHindText: true,
        );
      case Type_Choose_Option_Day.WEEK:
        return InListFormTablet(
          isHindText: true,
        );
      case Type_Choose_Option_Day.MONTH:
        return InListFormTablet(
          isHindText: true,
        );
      default:
        return Container();
    }
  }

  Widget getCalendarLvStateDangLich() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const CalenderDayTablet();
      case Type_Choose_Option_Day.WEEK:
        return const CalenderWeekTablet();
      case Type_Choose_Option_Day.MONTH:
        return const CalenderMonthTablet();
      default:
        return Container();
    }
  }

//mobile
  Widget getLichLVDangListMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const InListForm();
      case Type_Choose_Option_Day.WEEK:
        return const InListForm();
      case Type_Choose_Option_Day.MONTH:
        return const InListForm();
      default:
        return Container();
    }
  }

  Widget getCalendarLvStateDangLichMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return  const InCalenderForm();
      case Type_Choose_Option_Day.WEEK:
        return const CalenderWeekMobile();
      case Type_Choose_Option_Day.MONTH:
        return const CalenderFormMonth();
      default:
        return Container();
    }
  }
}

extension LichLv on CalenderState {
  Widget lichLamViec() {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangList();
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLich();
    } else {
      return const SizedBox();
    }
  }
  Widget lichLamViecMobile() {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangListMobile();
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLichMobile();
    } else {
      return const SizedBox();
    }
  }
}
