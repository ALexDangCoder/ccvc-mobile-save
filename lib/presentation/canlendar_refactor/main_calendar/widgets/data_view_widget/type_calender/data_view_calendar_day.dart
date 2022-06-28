import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataViewCalendarDay extends StatefulWidget {
  const DataViewCalendarDay({
    Key? key,
    required this.propertyChanged,
    required this.buildAppointment,
    required this.data,
    required this.fCalendarController,
    this.onMore,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final Widget Function(AppointmentWithDuplicate appointment) buildAppointment;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Function(DateTime)? onMore;

  @override
  State<DataViewCalendarDay> createState() => _DataViewCalendarDayState();
}

class _DataViewCalendarDayState extends State<DataViewCalendarDay> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate =
        getOnlyDate(widget.fCalendarController.displayDate ?? DateTime.now());
    setFCalendarListenerWeek();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DataViewCalendarDay oldWidget) {
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
      if (currentTimeTo - currentTimeFrom < 20 * 60 * 1000) {
        item.startTime = DateTime.fromMillisecondsSinceEpoch(
            item.endTime.millisecondsSinceEpoch - 20 * 60 * 1000);
        item.endTime = DateTime.fromMillisecondsSinceEpoch(
            item.endTime.millisecondsSinceEpoch);
      }
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
          listDuplicate.elementAt(i).isMore = i == 3;
          if (i > 3) {
            listRemove.add(listDuplicate.elementAt(i));
          }
        }
      }
    }
    for (final AppointmentWithDuplicate element in listRemove) {
      list.remove(element);
    }
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
      headerHeight: 0,
      viewHeaderHeight: 0,
      allowAppointmentResize: true,
      controller: widget.fCalendarController,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeIntervalHeight: 88,
      ),
      selectionDecoration: const BoxDecoration(color: Colors.transparent),
      appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
      todayHighlightColor: statusCalenderRed,
      appointmentTimeTextFormat: 'hh:mm:ss a',

      dataSource: widget.data,
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
                Icons.more_horiz,
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

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<AppointmentWithDuplicate> source) {
    appointments = source;
  }
  DataSourceFCalendar.empty() {
    appointments = [];
  }
}
