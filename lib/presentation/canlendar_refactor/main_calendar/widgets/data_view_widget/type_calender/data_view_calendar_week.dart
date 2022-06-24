import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'data_view_calendar_day.dart';

class DataViewCalendarWeek extends StatefulWidget {
  const DataViewCalendarWeek({
    Key? key,
    required this.propertyChanged,
    required this.buildAppointment,
    required this.data,
    required this.fCalendarController,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Widget Function(Appointment appointment) buildAppointment;

  @override
  State<DataViewCalendarWeek> createState() => _DataViewCalendarWeekState();
}

class _DataViewCalendarWeekState extends State<DataViewCalendarWeek> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate =
        getOnlyDate(widget.fCalendarController.displayDate ?? DateTime.now());
    setFCalendarListenerWeek();
    super.initState();
  }

  void setFCalendarListenerWeek() {
    widget.fCalendarController
        .addPropertyChangedListener(widget.propertyChanged);
  }

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      firstDayOfWeek: 1,
      scheduleViewSettings: ScheduleViewSettings(
        appointmentItemHeight: 40,
        dayHeaderSettings: DayHeaderSettings(),
      ),
      resourceViewSettings: ResourceViewSettings(
      ),
      weekNumberStyle: WeekNumberStyle(
      ),
      showCurrentTimeIndicator: false,
      viewHeaderHeight: 0,
      // monthCellBuilder: (_, detailMonth ){
      //   final appointment  = detailMonth.appointments.first;
      //   return Container ();
      // },
      timeSlotViewSettings: TimeSlotViewSettings(
        timelineAppointmentHeight: 100,
      ),
      allowAppointmentResize: true,
      controller: widget.fCalendarController,
      headerHeight: 0,
      view: CalendarView.week,

      todayHighlightColor: labelColor,
      appointmentTimeTextFormat: 'hh:mm:ss',
      dataSource: widget.data,
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle: textNormalCustom(
          fontSize: 13,
          color: colorA2AEBD,
        ),
      ),

      monthViewSettings: MonthViewSettings(
        appointmentDisplayCount: 2,
        monthCellStyle: MonthCellStyle(
          backgroundColor: bgCalenderColor,
          trailingDatesTextStyle: textNormalCustom(
            fontSize: 14,
            color: iconColorDown,
          ),
          textStyle: textNormalCustom(
            fontSize: 14,
            color: fontColorTablet2,
          ),
        ),

        agendaViewHeight: 50,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),

      selectionDecoration: const BoxDecoration(color: Colors.transparent),
      // appointmentBuilder: (_, appointmentDetail) {
      //   final Appointment appointment = appointmentDetail.appointments.first;
      //   return widget.buildAppointment(appointment);
      // },
    );
  }
}
