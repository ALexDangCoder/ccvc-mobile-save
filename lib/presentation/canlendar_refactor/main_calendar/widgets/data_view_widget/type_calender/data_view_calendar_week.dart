import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataViewCalendarWeek extends StatefulWidget {
  const DataViewCalendarWeek({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<DataViewCalendarWeek> createState() => _DataViewCalendarWeekState();
}

class _DataViewCalendarWeekState extends State<DataViewCalendarWeek> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataLichLvModel>(
      stream: widget.cubit.listCalendarWorkStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? DataLichLvModel();
        return SfCalendar(
          showCurrentTimeIndicator: false,
          showDatePickerButton: true,
          headerHeight: 0,
          controller: widget.cubit.calendarControllerWeek,
          cellEndPadding: 5,
          view: CalendarView.week,
          selectionDecoration: const BoxDecoration(color: Colors.transparent),
          timeSlotViewSettings: const TimeSlotViewSettings(
            dayFormat: 'EEEE',
            timeIntervalHeight: 60.0,
            minimumAppointmentDuration: Duration(minutes: 30),
          ),
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: textNormalCustom(fontSize: 13, color: colorA2AEBD),
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
          appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
          todayHighlightColor: AppTheme.getInstance().colorField(),
          appointmentTimeTextFormat: 'hh:mm:ss a',
          dataSource: data.toDataFCalenderSource(),
          appointmentBuilder: (_, calendarAppointmentDetails) {
            return GestureDetector(
              onTap: () {},
              child: Container(),
            );
          },
        );
      },
    );
  }
}
