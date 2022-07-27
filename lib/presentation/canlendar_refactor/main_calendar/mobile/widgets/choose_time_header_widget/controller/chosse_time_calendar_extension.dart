import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension ChooseTimeControllerExtension on ChooseTimeController {
  Widget getIcon() {
    return IconButton(
      onPressed: () {
        isShowCalendarType.value = !isShowCalendarType.value;
      },
      icon: ValueListenableBuilder<CalendarType>(
        valueListenable: calendarType,
        builder: (context, value, _) => SvgPicture.asset(
          value.getIcon().icon,
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  String dateFormat(DateTime dateTime) {
    switch (calendarType.value) {
      case CalendarType.DAY:
        return dateTime.formatDayCalendar;
      case CalendarType.WEEK:
        return dateTime.startEndWeek;
      case CalendarType.MONTH:
        final dateTimeFormRange =
            dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
        final dataString =
            '${dateTimeFormRange.first.day} - ${dateTimeFormRange.last.formatDayCalendar}';
        return dataString;
      case CalendarType.YEAR:
        return dateTime.year.toString();
    }
  }

  List<DateTime> dateTimeRange(DateTime dateTime) {
    switch (calendarType.value) {
      case CalendarType.DAY:
        return [dateTime, dateTime];
      case CalendarType.WEEK:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      case CalendarType.MONTH:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
      case CalendarType.YEAR:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.NAM_NAY);
    }
  }
}
