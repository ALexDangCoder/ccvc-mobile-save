import 'dart:async';

import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/common_api_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:queue/queue.dart';

extension DayApi on CalenderCubit {
  Future<void> callApiNgay() async {
    final Queue queue = Queue();
    showLoading();
    changeDateByClick = true;
    listDSLV.clear();
    page = 1;
    unawaited(queue.add(() => postEventsCalendar()));
    unawaited(queue.add(() => getListLichLV()));
    unawaited(
      queue.add(
        () => dataLichLamViec(
          startDate: startDates.formatApi,
          endDate: endDates.formatApi,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => dataLichLamViecRight(
          startDate: startDates.formatApi,
          endDate: endDates.formatApi,
          type: 0,
        ),
      ),
    );
    unawaited(queue.add(() => menuCalendar()));
    stateCalendarControllerDay.displayDate = selectDay;
    stateCalendarControllerWeek.displayDate = selectDay;
    stateCalendarControllerMonth.displayDate = selectDay;
    moveTimeSubject.add(selectDay);
    await queue.onComplete;
    showContent();
    changeDateByClick = false;
  }

  Future<void> callApiDayCalendar() async {
    startDates = selectDay;
    endDates = selectDay;
    initDataMenu();
    await callApiWithAsync();
    moveTimeSubject.add(selectDay);
  }

  Future<void> callApiWeekCalendar() async {
    final day = selectDay;
    startDates = day.subtract(Duration(days: day.weekday - 1));
    endDates = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
    await callApiWithAsync();
  }

  Future<void> callApiMonthCalendar() async {
    final day = selectDay;
    startDates = DateTime(day.year, day.month, 1);
    endDates = DateTime(day.year, day.month + 1, 0);
    await callApiWithAsync();
  }
}
