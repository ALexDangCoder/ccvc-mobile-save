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
    required this.fCalendarController, this.onMore,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Widget Function(AppointmentWithDuplicate appointment) buildAppointment;
  final Function(DateTime)? onMore;

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
    checkDuplicate(
      widget.data.appointments as List<AppointmentWithDuplicate>? ?? [],
    );
  }

  void checkDuplicate(List<AppointmentWithDuplicate> list) {
    final List<AppointmentWithDuplicate> listRemove = [];
    for (final item in list) {
      final currentTimeFrom = item.startTime.millisecondsSinceEpoch;
      final currentTimeTo = item.endTime.millisecondsSinceEpoch;
      final listDuplicate = list.where((element) {
        final startTime = element.startTime.millisecondsSinceEpoch;
        if (startTime >= currentTimeFrom && startTime < currentTimeTo) {
          return true;
        }
        return false;
      });
      if (listDuplicate.length > 1) {
        for (int i = 0; i < listDuplicate.length; i++) {
          listDuplicate.elementAt(i).isDuplicate = true;
          if (i == 1) {
            listDuplicate.elementAt(i).isMore = true;
          }
          if (i > 1) {
            listRemove.add(listDuplicate.elementAt(i));
          }
        }
      }
    }
    for (final AppointmentWithDuplicate element in listRemove) {
      list.remove(element);
    }
  }

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      firstDayOfWeek: 1,
      showCurrentTimeIndicator: false,
      viewHeaderHeight: 0,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeIntervalHeight: 100,
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
    );
  }
}
