import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_base_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';

import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/days_of_week_style_phone.dart';

class TableCalendarTabletWidget extends StatefulWidget {
  final ChooseTimeController controller;
  const TableCalendarTabletWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _TableCalendarTabletWidgetState createState() =>
      _TableCalendarTabletWidgetState();
}

class _TableCalendarTabletWidgetState extends State<TableCalendarTabletWidget> {
  DateTime selectDay = DateTime.now();
  ValueNotifier<DateTime> pageDateTime = ValueNotifier(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ValueListenableBuilder<DateTime>(
              valueListenable: pageDateTime,
              builder: (context, value, _) {
                return coverTime(value);
              },
            ),
          ],
        ),
        TableCalendarPhone(
          locale: 'vi',
          isDowTop: false,
          onPageChanged: (value) {
            if (value.month != widget.controller.pageTableCalendar.month) {
              widget.controller.pageTableCalendar = value;
              pageDateTime.value = value;
              // widget.onPageCalendar(value);
            }
          },
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: textNormalCustom(fontSize: 18, color: color667793),
              weekendStyle: textNormalCustom(fontSize: 18, color: colorA2AEBD)),
          eventLoader: (day) => [DateTime.now()]
              .where((element) => isSameDay(element, day))
              .toList(),
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: (selectDay, focusDay) {
            this.selectDay = selectDay;
            // widget.onSelect(selectDay);
            setState(() {});
          },
          daysOfWeekVisible: true,
          selectedDayPredicate: (day) {
            return isSameDay(selectDay, day);
          },
          calendarStyle: CalendarStyle(
            weekendTextStyle: textNormalCustom(
              color: colorA2AEBD,
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
              shape: BoxShape.circle,
              color: AppTheme.getInstance().colorField(),
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().colorField().withOpacity(0.2),
            ),
            todayTextStyle: textNormalCustom(
              fontSize: 14.0.textScale(),
              color: Colors.white,
            ),
          ),
          headerVisible: false,
          calendarFormat: CalendarFormat.week,
          firstDay: DateTime.utc(DateTime.now().year - 10, 8, 20),
          lastDay: DateTime.utc(DateTime.now().year + 10, 8, 20),
          focusedDay: selectDay,
        ),
      ],
    );
  }

  Widget coverTime(DateTime dateTime) {
    return RichText(
      text: TextSpan(
        text: '${S.current.thang} ${dateTime.month} - ',
        style: textNormalCustom(
            color: color3D5586, fontSize: 32, fontWeight: FontWeight.w700),
        children: <TextSpan>[
          TextSpan(
              text: '${dateTime.year}',
              style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 32,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
