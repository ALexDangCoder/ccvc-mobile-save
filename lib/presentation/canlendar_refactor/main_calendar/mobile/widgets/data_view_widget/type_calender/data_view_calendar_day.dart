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

  @override
  void didUpdateWidget(covariant DataViewCalendarDay oldWidget) {
    (widget.data.appointments as List<AppointmentWithDuplicate>? ?? [])
        .minTime20();
    super.didUpdateWidget(oldWidget);
  }

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);


  void setFCalendarListenerWeek() {
    widget.fCalendarController
        .addPropertyChangedListener(widget.propertyChanged);
  }

  @override
  Widget build(BuildContext context) {
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
            onMoreDayClick: (date , _){
              widget.onMore?.call(date);
            },
            viewHeaderStyle: const ViewHeaderStyle(
              colorsIcon: colorA2AEBD,
            ),
            maxDayItemShow: 4,
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


  void minTime20() {
    for (final item in this) {
      final currentTimeFrom = item.startTime.millisecondsSinceEpoch;
      final currentTimeTo = item.endTime.millisecondsSinceEpoch;

      if (currentTimeTo - currentTimeFrom < 20 * 60 * 1000) { // check nếu thời gian cuộc họp ít hơn 20p
        final checkTimeEnd = DateTime(
          item.endTime.year,
          item.endTime.month,
          item.endTime.day,
        ).add(const Duration(minutes: 20));

        final checkTimeStart = DateTime(
          item.startTime.year,
          item.startTime.month,
          item.startTime.day+1,
        ).subtract(const Duration(minutes: 20));

        if(item.endTime.isBefore(checkTimeEnd)){ //check nếu thời gian kết thúc trước 00:20
          item.endTime = checkTimeEnd;
        }else if(item.startTime.isAfter(checkTimeStart)){ // check nếu thời gian bắt đầu 23:40
          item.startTime = checkTimeStart;
        }else{
          item.startTime = DateTime.fromMillisecondsSinceEpoch(
            currentTimeFrom - 600000,
          );
          item.endTime = DateTime.fromMillisecondsSinceEpoch(
            currentTimeTo + 600000,
          );
        }
      }
    }
  }
}
