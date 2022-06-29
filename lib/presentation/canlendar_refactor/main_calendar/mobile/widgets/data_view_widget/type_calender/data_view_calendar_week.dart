import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
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
    this.isTablet = false,
    this.onMore,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Widget Function(AppointmentWithDuplicate appointment) buildAppointment;
  final Function(DateTime)? onMore;
  final bool isTablet;

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

  @override
  void didUpdateWidget(covariant DataViewCalendarWeek oldWidget) {
    super.didUpdateWidget(oldWidget);
    (widget.data.appointments as List<AppointmentWithDuplicate>? ?? [])
        .checkDuplicate();
    (widget.data.appointments as List<AppointmentWithDuplicate>? ?? [])
        .checkMore(2);
  }

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isTablet ?  const EdgeInsets.only(
        left: 30,
        right: 30,
      ) : null ,
      decoration: widget.isTablet ?  BoxDecoration(
        color: backgroundColorApp,
        border:  Border.all(
          color: borderColor.withOpacity(0.5),
        )  ,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ) : null ,
      child: SfCalendar(
        firstDayOfWeek: 1,
        showCurrentTimeIndicator: false,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 100,
          dayFormat: 'EEEE',
        ),
        headerHeight: 0,
        viewHeaderHeight: widget.isTablet ? -1 : 0,
        allowAppointmentResize: true,
        controller: widget.fCalendarController,
        view: CalendarView.week,
        todayHighlightColor: labelColor,
        appointmentTimeTextFormat: 'hh:mm:ss',
        resourceViewSettings: ResourceViewSettings(
          displayNameTextStyle: textNormalCustom(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        headerDateFormat: 'MMMM,yyy',
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
        appointmentBuilder: (_, appointmentDetail) {
          final AppointmentWithDuplicate appointment =
              appointmentDetail.appointments.first;
          if (appointment.isMore) {
            return GestureDetector(
              onTap: () {
                widget.onMore?.call(appointmentDetail.date);
              },
              child: Container(
                color: Colors.transparent,
                child: const Icon(
                  Icons.more_vert,
                  color: textBodyTime,
                ),
              ),
            );
          }
          return widget.buildAppointment(appointment);
        },
      ),
    );
  }
}
