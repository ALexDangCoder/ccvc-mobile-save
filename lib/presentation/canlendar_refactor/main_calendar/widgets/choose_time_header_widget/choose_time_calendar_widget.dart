import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/header_tablet_calendar_widget.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

import 'calendar_type_widget.dart';
import 'controller/choose_time_calendar_controller.dart';
import 'tablet_calendar_widget.dart';

class ChooseTimeCalendarWidget extends StatefulWidget {
  final List<DateTime> calendarDays;
  final Function(DateTime, DateTime, CalendarType) onChange;
  final ChooseTimeController? controller;
  const ChooseTimeCalendarWidget(
      {Key? key,
      this.calendarDays = const [],
      required this.onChange,
      this.controller})
      : super(key: key);

  @override
  _ChooseTimeCalendarWidgetState createState() =>
      _ChooseTimeCalendarWidgetState();
}

class _ChooseTimeCalendarWidgetState extends State<ChooseTimeCalendarWidget> {
  late ChooseTimeController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller == null) {
      controller = ChooseTimeController();
    } else {
      controller = widget.controller!;
    }
    controller.selectDate.addListener(() {
      final times = dateTimeRange(controller.selectDate.value);
      widget.onChange(times[0], times[1], controller.calendarType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgTabletColor,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: controller.isShowCalendarType,
            builder: (context, value, _) => Visibility(
              maintainState: true,
              visible: value,
              child: ChooseTypeCalendarWidget(
                onChange: (value) {
                  controller.calendarType = value;
                  final times = dateTimeRange(controller.selectDate.value);
                  widget.onChange(times[0], times[1], controller.calendarType);
                  setState(() {});
                },
              ),
            ),
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
                  valueListenable: controller.selectDate,
                  builder: (context, value, _) {
                    return HeaderTabletCalendarWidget(
                      time: dateFormat(value),
                      onTap: () {
                        controller.onExpandCalendar();
                      },
                    );
                  },
                ),
                TabletCalendarWidget(
                  initDate: controller.selectDate.value,
                  calendarDays: widget.calendarDays,
                  onSelect: (value) {
                    controller.selectDate.value = value;
                  },

                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime dateTime) {
    switch (controller.calendarType) {
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

  List<DateTime> dateTimeRange(DateTime dateTime) {
    switch (controller.calendarType) {
      case CalendarType.DAY:
        return [dateTime, dateTime];
      case CalendarType.WEEK:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      case CalendarType.MONTH:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    }
  }
}
