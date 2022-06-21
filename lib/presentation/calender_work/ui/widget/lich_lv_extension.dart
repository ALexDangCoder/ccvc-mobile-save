import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
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
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

extension LichLVOpition on Type_Choose_Option_Day {
  Widget getLichLVDangList(CalenderCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
          onTap: () {
            cubit.callApi();
          },
        );
      case Type_Choose_Option_Day.WEEK:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
          onTap: () {
            cubit.callApiTuan();
          },
        );
      case Type_Choose_Option_Day.MONTH:
        return InListFormTablet(
          isHindText: true,
          cubit: cubit,
          onTap: () {
            cubit.callApiMonth();
          },
        );
      default:
        return Container();
    }
  }

  Widget getCalendarLvStateDangLich(CalenderCubit cubit,
      Type_Choose_Option_Day type,) {
    switch (type) {
      case Type_Choose_Option_Day.DAY:
        return CalenderDayTablet(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return CalenderWeekTablet(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return CalenderMonthTablet(
          cubit: cubit,
        );
      default:
        return Container();
    }
  }

//mobile
  Widget getLichLVDangListMobile(CalenderCubit cubit,
      Type_Choose_Option_Day type,) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApi();
          },
          type: type,
        );
      case Type_Choose_Option_Day.WEEK:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApiTuan();
          },
          type: type,
        );
      case Type_Choose_Option_Day.MONTH:
        return InListForm(
          cubit: cubit,
          onTap: () {
            cubit.callApiMonth();
          },
          type: type,
        );
      default:
        return Container();
    }
  }

  Widget getCalendarLvStateDangLichMobile(CalenderCubit cubit,
      Type_Choose_Option_Day type,) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return InCalenderForm(
          cubit: cubit,
          type: type,
        );
      case Type_Choose_Option_Day.WEEK:
        return CalenderWeekMobile(
          cubit: cubit,
          type: type,
        );
      case Type_Choose_Option_Day.MONTH:
        return CalenderFormMonth(
          cubit: cubit,
          type: type,
        );
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
  Widget lichLamViec(CalenderCubit cubit, Type_Choose_Option_Day type) {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangList(cubit,);
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLich(cubit, type);
    } else {
      return const SizedBox ();
    }
  }

  Widget tableCalendar({
    required CalenderCubit cubit,
    Type_Choose_Option_Day type = Type_Choose_Option_Day.DAY,
  }) {
    return StreamBuilder<DateTime>(
      stream: cubit.streamInitTime,
      builder: (context, _) {
        return StreamBuilder<List<DateTime>>(
          stream: cubit.eventsStream,
          builder: (context, snapshot) {
            return StreamBuilder<bool>(
                stream: cubit.isSearchBar.stream,
                builder: (context, isSearch) {
                  return TableCalendarWidget(
                    key:  UniqueKey(),
                    isSearchBar: isSearch.data ?? true,
                    initTime: cubit.selectDay,
                    eventsLoader: snapshot.data,
                    type: type,
                    onChange: (DateTime start, DateTime end, selectDay) {
                      cubit.selectDay = selectDay;
                      if (type == Type_Choose_Option_Day.DAY) {
                        cubit.callApi();
                      } else if (type == Type_Choose_Option_Day.WEEK) {
                        cubit.callApiTuan();
                      } else {
                        cubit.callApiMonth();
                      }
                    },
                    onChangeRange: (DateTime? start, DateTime? end,
                        DateTime? focusedDay) {},
                    onChangeText: (String? value) {
                      cubit.searchLichHop(value);
                    },
                  );
                });
          },
        );
      },
    );
  }

  Widget itemCalendarWork(CalenderCubit cubit) {
    if (this is LichLVStateDangLich || this is LichLVStateDangList) {
      if (type == Type_Choose_Option_Day.MONTH &&
          this is LichLVStateDangList &&
          cubit.changeItemMenuSubject.value == TypeCalendarMenu.LichCuaToi) {
        return itemCalendarWorkDefault(cubit);
      } else if (type == Type_Choose_Option_Day.MONTH) {
        return itemCalendarWorkIscheck(cubit);
      }
      return itemCalendarWorkDefault(cubit);
    }
    return Container();
  }

  Widget lichLamViecMobile(CalenderCubit cubit, Type_Choose_Option_Day type) {
    if (this is LichLVStateDangList) {
      return type.getLichLVDangListMobile(cubit, type);
    } else if (this is LichLVStateDangLich) {
      return type.getCalendarLvStateDangLichMobile(cubit, type);
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
