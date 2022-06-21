import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';

import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/days_of_week_style_phone.dart';

import 'controller/choose_time_calendar_controller.dart';

class TabletCalendarWidget extends StatefulWidget {
  final List<DateTime> calendarDays;
  final Function(DateTime) onSelect;
  final DateTime initDate;
  final ChooseTimeController controller;
  const TabletCalendarWidget(
      {Key? key,
      required this.calendarDays,
      required this.onSelect,
      required this.initDate,
      required this.controller})
      : super(key: key);

  @override
  _TabletCalendarWidgetState createState() => _TabletCalendarWidgetState();
}

class _TabletCalendarWidgetState extends State<TabletCalendarWidget> {
  DateTime selectDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.selectDate.addListener(() {
      selectDay = widget.controller.selectDate.value;
      setState(() {});
    });
    widget.controller.calendarFormat.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendarPhone(
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: textNormalCustom(fontSize: 13, color: textBodyTime),
          weekendStyle: textNormalCustom(fontSize: 13, color: textBodyTime)),
      eventLoader: (day) => widget.calendarDays
          .where((element) => isSameDay(element, day))
          .toList(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: (selectDay, focusDay) {
        this.selectDay = selectDay;
        widget.onSelect(selectDay);
        setState(() {});
      },
      daysOfWeekVisible: true,
      selectedDayPredicate: (day) {
        return isSameDay(selectDay, day);
      },
      calendarStyle: CalendarStyle(
        // cellPadding: const EdgeInsets.all(8),
        weekendTextStyle: textNormalCustom(
          color: titleCalenderWork,
          fontSize: 14.0.textScale(),
          fontWeight: FontWeight.w500,
        ),
        defaultTextStyle: textNormalCustom(
          color: color3D5586,
          fontSize: 14.0.textScale(),
          fontWeight: FontWeight.w500,
        ),
        selectedTextStyle: textNormalCustom(
          fontWeight: FontWeight.w500,
          fontSize: 14.0.textScale(),
          color: Colors.white,
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: AppTheme.getInstance().colorField(),
        ),
        todayDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: AppTheme.getInstance().colorField().withOpacity(0.2),
        ),
        todayTextStyle: textNormalCustom(
          fontSize: 14.0.textScale(),
          color: Colors.white,
        ),
      ),
      headerVisible: false,
      calendarFormat: widget.controller.calendarFormat.value,
      firstDay: DateTime.utc(2021, 8, 20),
      lastDay: DateTime.utc(2030, 8, 20),
      focusedDay: selectDay,
    );
  }
}
