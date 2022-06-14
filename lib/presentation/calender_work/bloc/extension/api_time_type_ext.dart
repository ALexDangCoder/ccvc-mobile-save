import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/common_api_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';

extension DayApi on CalenderCubit{
  void callApiNgay() {
    changeDateByClick = true;
    listDSLV.clear();
    page = 1;
    getListLichLV();
    dataLichLamViec(
      startDate: startDates.formatApi,
      endDate: endDates.formatApi,
    );
    dataLichLamViecRight(
      startDate: startDates.formatApi,
      endDate: endDates.formatApi,
      type: 0,
    );
    menuCalendar();
    postEventsCalendar();
    stateCalendarControllerDay.displayDate = selectDay;
    stateCalendarControllerWeek.displayDate = selectDay;
    stateCalendarControllerMonth.displayDate = selectDay;
    moveTimeSubject.add(selectDay);
    changeDateByClick = false;
  }

  Future<void> callApiDayCalendar() async {
    showLoading();
    startDates = selectDay;
    endDates = selectDay;
    initDataMenu();
    await callApiWithAsync();
    moveTimeSubject.add(selectDay);
    showContent();
  }


  Future<void> callApiWeekCalendar() async {
    showLoading();
    final day = selectDay;
    startDates = day.subtract(Duration(days: day.weekday - 1));
    endDates = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
    await callApiWithAsync();
    showContent();
  }

  Future<void> callApiMonthCalendar() async {
    showLoading();
    final day = selectDay;
    startDates = DateTime(day.year, day.month, 1);
    endDates = DateTime(day.year, day.month + 1, 0);
    await callApiWithAsync();
    showContent();
  }

}
