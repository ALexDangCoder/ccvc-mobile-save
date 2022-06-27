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

  // void checkDuplicate(Appointment list) {
  //   List<Appointment> listRemove =[];
  //   for (final item in list) {
  //     final currentTimeFrom  = getDate(item.dateTimeFrom ?? '').millisecondsSinceEpoch;
  //     final currentTimeTo  = getDate(item.dateTimeTo ?? '').millisecondsSinceEpoch;
  //     final listDuplicate = list.where((element) {
  //       final startTime = getDate(element.dateTimeFrom ?? '').millisecondsSinceEpoch;
  //       if (startTime >= currentTimeFrom && startTime < currentTimeTo){
  //         return true;
  //       }
  //       return false;
  //     });
  //     if (listDuplicate.length> 1){
  //       for (int i= 0; i < listDuplicate.length ; i++ ) {
  //         listDuplicate.elementAt(i).isTrung = true;
  //         if (i== 1 ){
  //           listDuplicate.elementAt(i).isMore = true;
  //         }
  //         if (i>1) {
  //           listRemove.add(listDuplicate.elementAt(i));
  //         }
  //       }
  //     }
  //   }
  //   for ( final ListLichLVModel element in listRemove) {list.remove(element);}
  // }

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
  DataSourceFCalendar(List<AppointmentWithDuplicate> source) {
    appointments = source;
  }
  DataSourceFCalendar.empty(){
    appointments= [];
  }
}
