import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/calender_form_month.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/calender_week_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/in_calender_form.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/list/in_list_form.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_day_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_month_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/lich/calender_week_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/list/in_list_form_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

extension LichLVOpition on Type_Choose_Option_Day {
  Widget getLichLVDangList(CalenderCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
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
  Widget getLichLVDangListMobile(CalenderCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApi();
          },
        );
      case Type_Choose_Option_Day.WEEK:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApiTuan();
          },
        );
      case Type_Choose_Option_Day.MONTH:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApiMonth();
          },
        );
      default:
        return Container();
    }
  }

  Widget getCalendarLvStateDangLichMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const InCalenderForm();
      case Type_Choose_Option_Day.WEEK:
        return const CalenderWeekMobile();
      case Type_Choose_Option_Day.MONTH:
        return const CalenderFormMonth();
      default:
        return Container();
    }
  }

// icons
  Widget getCalendarIconsMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return SvgPicture.asset(
          ImageAssets.icCalenderDayBig,
        );
      case Type_Choose_Option_Day.WEEK:
        return SvgPicture.asset(
          ImageAssets.icCalenderWeekBig,
        );
      case Type_Choose_Option_Day.MONTH:
        return SvgPicture.asset(
          ImageAssets.icCalenderMonthBig,
        );
      default:
        return Container();
    }
  }
}

extension LichLv on CalenderState {
  Widget lichLamViec(CalenderCubit cubit) {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangList(cubit);
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLich();
    } else {
      return const SizedBox();
    }
  }

  Widget tableCalendar({
    required CalenderCubit cubit,
    Type_Choose_Option_Day type = Type_Choose_Option_Day.DAY,
  }) {
    if (this is LichLVStateDangLich || this is LichLVStateDangList) {
      return type.getTableCalendar(cubit: cubit, type: type);
    }
    return Container();
  }

  Widget itemCalendarWork(CalenderCubit cubit) {
    if (this is LichLVStateDangLich || this is LichLVStateDangList) {
      if (type == Type_Choose_Option_Day.MONTH) {
        return itemCalendarWorkIscheck(cubit);
      }
      return itemCalendarWorkDefault(cubit);
    }
    return Container();
  }

  Widget lichLamViecMobile(CalenderCubit cubit) {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangListMobile(cubit);
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLichMobile();
    } else {
      return const SizedBox();
    }
  }

  Widget lichLamViecIconsMobile() {
    if (this is LichLVStateDangList) {
      return type.getCalendarIconsMobile();
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarIconsMobile();
    } else {
      return const SizedBox();
    }
  }
}
