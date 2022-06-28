import 'dart:developer';

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
  final Function(DateTime, DateTime, CalendarType, String) onChange;
  final ChooseTimeController? controller;
  final Function(DateTime, DateTime, String)? onChangeYear;
  const ChooseTimeCalendarWidget(
      {Key? key,
      this.calendarDays = const [],
      required this.onChange,
      this.controller,
      this.onChangeYear})
      : super(key: key);

  @override
  _ChooseTimeCalendarWidgetState createState() =>
      _ChooseTimeCalendarWidgetState();
}

class _ChooseTimeCalendarWidgetState extends State<ChooseTimeCalendarWidget> {
  late ChooseTimeController controller;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller == null) {
      controller = ChooseTimeController();
    } else {
      controller = widget.controller!;
    }
    final timePage = controller.pageTableCalendar
        .dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    widget.onChangeYear
        ?.call(timePage.first, timePage.last, textEditingController.text);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final times = dateTimeRange(controller.selectDate.value);
      widget.onChange(times[0], times[1], controller.calendarType.value,
          textEditingController.text);
      controller.selectDate.addListener(() {
        final times = dateTimeRange(controller.selectDate.value);
        widget.onChange(times[0], times[1], controller.calendarType.value,
            textEditingController.text);
      });
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
                controller: controller,
                onChange: (value) {
                  controller.calendarType.value = value;
                  final times = dateTimeRange(controller.selectDate.value);
                  widget.onChange(
                      times[0],
                      times[1],
                      controller.calendarType.value,
                      textEditingController.text);
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
                ValueListenableBuilder<CalendarType>(
                  valueListenable: controller.calendarType,
                  builder: (context, value, _) =>
                      ValueListenableBuilder<DateTime>(
                    valueListenable: controller.selectDate,
                    builder: (context, value, _) {
                      return HeaderTabletCalendarWidget(
                        onSearch: (value) {
                          final times =
                              dateTimeRange(controller.selectDate.value);
                          widget.onChange(times[0], times[1],
                              controller.calendarType.value, value);
                          final timePage = controller.pageTableCalendar
                              .dateTimeFormRange(
                                  timeRange: TimeRange.THANG_NAY);
                          widget.onChangeYear?.call(timePage.first,
                              timePage.last, textEditingController.text);
                        },
                        time: dateFormat(value),
                        onTap: () {
                          controller.onExpandCalendar();
                        },
                        controller: textEditingController,
                      );
                    },
                  ),
                ),
                TabletCalendarWidget(
                  initDate: controller.selectDate.value,
                  calendarDays: widget.calendarDays,
                  onSelect: (value) {
                    controller.selectDate.value = value;
                  },
                  controller: controller,
                  onPageCalendar: (value) {
                    final times =
                        value.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
                    widget.onChangeYear?.call(
                        times.first, times.last, textEditingController.text);
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
    switch (controller.calendarType.value) {
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
    switch (controller.calendarType.value) {
      case CalendarType.DAY:
        return [dateTime, dateTime];
      case CalendarType.WEEK:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      case CalendarType.MONTH:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    }
  }
}
