import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/calendar.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/appointment_engine/calendar_datasource.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/common/calendar_controller.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/settings/time_slot_view_settings.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/sfcalendar.dart';
import 'package:flutter/material.dart';

class DataViewCalendarDay extends StatefulWidget {
  const DataViewCalendarDay({
    Key? key,
    required this.propertyChanged,
    required this.buildAppointment,
    this.isTablet = false,
    required this.data,
    required this.fCalendarController,
    this.onMore,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final Widget Function(AppointmentWithDuplicate appointment) buildAppointment;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Function(DateTime)? onMore;
  final bool isTablet;

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

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  void didUpdateWidget(covariant DataViewCalendarDay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // (widget.data.appointments as List<AppointmentWithDuplicate>? ?? [])
    //     .checkMore( 4);
  }

  void setFCalendarListenerWeek() {
    widget.fCalendarController
        .addPropertyChangedListener(widget.propertyChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Container ();
    return Container(
      margin: widget.isTablet
          ? const EdgeInsets.only(
              left: 30,
              right: 30,
            )
          : null,
      decoration: widget.isTablet
          ? BoxDecoration(
              color: backgroundColorApp,
              border: Border.all(
                color: borderColor.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            )
          : null,
      child: Stack(
        children: [
          SfCalendar(
            headerHeight: 0,
            viewHeaderHeight: 0,
            controller: widget.fCalendarController,
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 100,
            ),
            selectionDecoration: const BoxDecoration(color: Colors.transparent),
            appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
            todayHighlightColor: statusCalenderRed,
            appointmentTimeTextFormat: 'hh:mm:ss a',
            dataSource: widget.data,
            viewHeaderStyle: const ViewHeaderStyle(
              colorsIcon: colorA2AEBD,
            ),
            appointmentBuilder: (_, appointmentDetail) {
              final AppointmentWithDuplicate appointment =
                  appointmentDetail.appointments.first;
              if (appointmentDetail.appointments.length > 1) {
                return Center(
                  child: Text('+${appointmentDetail.more}', style: textNormalCustom(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: colorA2AEBD,
                  ),),
                );
              }
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
          ),
          if (widget.isTablet)
            Container(
              height: 1,
              color: backgroundColorApp,
            ),
        ],
      ),
    );
  }

  String expandText(int sum) {
    return '${sum - 3}+';
  }
}

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<AppointmentWithDuplicate> source) {
    appointments = source;
  }

  DataSourceFCalendar.empty() {
    appointments = <AppointmentWithDuplicate>[];
  }
}

extension CheckDuplicate on List<AppointmentWithDuplicate> {
  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);


  void checkMore(int maxShow) {
    final List<AppointmentWithDuplicate> rootListTmp = [];
    final List<AppointmentWithDuplicate> resultList = [];
    final List<List<AppointmentWithDuplicate>> checkDuplicate = [];
    final List<DateTime> endTimeDataTmp = [];

    // remove Appointment full day
    for (final AppointmentWithDuplicate e in this) {
      if (getOnlyDate(e.startTime) != getOnlyDate(e.endTime)) {
        resultList.add(e);
      } else {
        rootListTmp.add(e);
      }
    }
    // sort
    rootListTmp.sort((item1, item2) {
      return item1.startTime.compareTo(item2.startTime);
    });

    // group lists no duplicate
    while (rootListTmp.isNotEmpty) {
      int? indexAdd;
      for (int i = 0; i < endTimeDataTmp.length; i++) {
        if (endTimeDataTmp[i].millisecondsSinceEpoch <=
            rootListTmp.first.startTime.millisecondsSinceEpoch) {
          indexAdd = i;
          break;
        }
      }
      if (indexAdd == null) {
        checkDuplicate.add([rootListTmp.first]);
        endTimeDataTmp.add(rootListTmp.first.endTime);
      } else {
        endTimeDataTmp[indexAdd] = rootListTmp.first.endTime;
        checkDuplicate[indexAdd].add(rootListTmp.first);
      }
      rootListTmp.remove(rootListTmp.first);
    }

    for (int i = 0; i < checkDuplicate.length && i < maxShow - 1; i++) {
      resultList.addAll(checkDuplicate[i]);
    }
    for (final e in checkDuplicate[maxShow  -1 ]) {
      e.isMore = true;
      e.endTime = DateTime.fromMillisecondsSinceEpoch(
        e.startTime.millisecondsSinceEpoch + 1800000,
      );
      resultList.add(e);
    }
    for (final item in this) {
      final currentTimeFrom = item.startTime.millisecondsSinceEpoch;
      final currentTimeTo = item.endTime.millisecondsSinceEpoch;
      if (currentTimeTo - currentTimeFrom < 20 * 60 * 1000) {
        item.startTime = DateTime.fromMillisecondsSinceEpoch(
          currentTimeFrom - 600000,
        );
        item.endTime = DateTime.fromMillisecondsSinceEpoch(
          currentTimeTo + 600000,
        );
      }
    }
    clear();
    addAll(resultList);
  }
}
