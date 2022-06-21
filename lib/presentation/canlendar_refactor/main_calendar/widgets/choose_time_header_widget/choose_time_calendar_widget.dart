import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/header_tablet_calendar_widget.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

import 'calendar_type_widget.dart';
import 'tablet_calendar_widget.dart';

class ChooseTimeCalendarWidget extends StatefulWidget {
  final List<DateTime> calendarDays;

  const ChooseTimeCalendarWidget({Key? key, this.calendarDays = const []})
      : super(key: key);

  @override
  _ChooseTimeCalendarWidgetState createState() =>
      _ChooseTimeCalendarWidgetState();
}

class _ChooseTimeCalendarWidgetState extends State<ChooseTimeCalendarWidget> {
  CalendarType calendarType = CalendarType.DAY;
  ValueNotifier<DateTime> selectDate = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgTabletColor,
      child: Column(
        children: [
          ChooseTypeCalendarWidget(
            onChange: (value) {
              calendarType = value;
              setState(() {});
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowContainerColor.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                )
              ],
            ),
            child: Column(
              children: [
                ValueListenableBuilder<DateTime>(
                  valueListenable: selectDate,
                  builder: (context, value, _) {
                    return HeaderTabletCalendarWidget(
                      time: dateFormat(value),
                    );
                  },
                ),
                TabletCalendarWidget(
                  calendarDays: [DateTime.now()],
                  onSelect: (value) {
                    selectDate.value = value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime dateTime) {
    switch (calendarType) {
      case CalendarType.DAY:
        return dateTime.formatDayCalendar;
      case CalendarType.WEEK:
        return dateTime.startEndWeek;
      case CalendarType.MONTH:
        final dateTimeFormRange =
            dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);

        final dataString =
            '${dateTimeFormRange[0].day} - ${dateTimeFormRange[1].formatDayCalendar}';
        return dataString;
    }
  }
}
