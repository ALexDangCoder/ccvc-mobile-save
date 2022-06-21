import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';

import 'choose_time_item.dart';
import 'choose_type_calendar_widget.dart';

class ChooseTimeCalendarWidget extends StatefulWidget {
  final List<DateTime> calendarDays;
  const ChooseTimeCalendarWidget({Key? key, this.calendarDays = const []})
      : super(key: key);

  @override
  _ChooseTimeCalendarWidgetState createState() =>
      _ChooseTimeCalendarWidgetState();
}

class _ChooseTimeCalendarWidgetState extends State<ChooseTimeCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgTabletColor,
      child: Column(
        children: [
          const ChooseTypeCalendarWidget(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: borderColor)),
            child: TableCalendarPhone(
              eventLoader: (day) => widget.calendarDays
                  .where((element) => isSameDay(element, day))
                  .toList(),
              startingDayOfWeek: StartingDayOfWeek.monday,

              daysOfWeekVisible: true,
              onFormatChanged: (CalendarFormat _format) {
                // setState(() {
                //   isFomat
                //       ? _calendarFormatWeek = _format
                //       : _calendarFormatMonth = _format;
                // });
              },
              // selectedDayPredicate: (day) {
              //   return isSameDay(_selectedDay, day);
              // },
              // calendarStyle: CalendarStyle(
              //   weekendTextStyle: textNormalCustom(
              //     color: titleCalenderWork,
              //     fontSize: 14.0.textScale(),
              //     fontWeight: FontWeight.w500,
              //   ),
              //   defaultTextStyle: textNormalCustom(
              //     color: color3D5586,
              //     fontSize: 14.0.textScale(),
              //     fontWeight: FontWeight.w500,
              //   ),
              //   selectedTextStyle: textNormalCustom(
              //     fontWeight: FontWeight.w500,
              //     fontSize: 14.0.textScale(),
              //     color: Colors.white,
              //   ),
              //   selectedDecoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppTheme.getInstance().colorField(),
              //   ),
              //   todayDecoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppTheme.getInstance().colorField().withOpacity(0.2),
              //   ),
              //   todayTextStyle: textNormalCustom(
              //     fontSize: 14.0.textScale(),
              //     fontWeight: FontWeight.w500,
              //     color: buttonColor,
              //   ),
              // ),
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              // calendarFormat:
              //     isFomat ? _calendarFormatWeek : _calendarFormatMonth,
              firstDay: DateTime.utc(2021, 8, 20),
              lastDay: DateTime.utc(2030, 8, 20),
              focusedDay: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
