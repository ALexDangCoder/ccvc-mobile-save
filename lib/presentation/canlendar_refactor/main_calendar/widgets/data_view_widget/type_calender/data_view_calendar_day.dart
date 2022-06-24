import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'item_appoinment_widget.dart';

class DataViewCalendarDay extends StatefulWidget {
  const DataViewCalendarDay({
    Key? key,
    required this.propertyChanged,
    required this.buildAppointment,
    required this.data,
    required this.fCalendarController,
  }) : super(key: key);

  final Function(String property) propertyChanged;
  final Widget Function(Appointment appointment) buildAppointment;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;

  @override
  State<DataViewCalendarDay> createState() => _DataViewCalendarDayState();
}

class _DataViewCalendarDayState extends State<DataViewCalendarDay> {

  late DateTime currentDate;

  @override
  void initState() {
    currentDate = getOnlyDate( widget.fCalendarController.displayDate ?? DateTime.now());
    setFCalendarListenerWeek();
    super.initState();
  }


  void setFCalendarListenerWeek() {
    widget.fCalendarController.addPropertyChangedListener(widget.propertyChanged);
  }

  DateTime getOnlyDate (DateTime date)=> DateTime (date.year, date.month, date.day);

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
        final Appointment appointment =
            appointmentDetail.appointments.first;
        return widget.buildAppointment(appointment);
      },
    );
  }

}

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<Appointment> source) {
    appointments = source;
  }
  DataSourceFCalendar.empty(){
    appointments= [];
  }
}
