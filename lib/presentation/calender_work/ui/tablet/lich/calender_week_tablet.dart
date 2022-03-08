import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWeekTablet extends StatefulWidget {
  const CalenderWeekTablet({Key? key}) : super(key: key);

  @override
  State<CalenderWeekTablet> createState() => _CalenderWeekTabletState();
}

class _CalenderWeekTabletState extends State<CalenderWeekTablet> {
  final CalendarController _controller = CalendarController();
  final CalenderCubit cubit = CalenderCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.callApiTuan();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30),
      child: StreamBuilder<DataLichLvModel>(
        stream: cubit.streamListLich,
        builder: (context, snapshot) {
          return SfCalendar(
            showCurrentTimeIndicator: false,
            showDatePickerButton: true,
            headerHeight: 0,
            controller: _controller,
            cellEndPadding: 5,
            view: CalendarView.week,
            selectionDecoration: const BoxDecoration(color: Colors.transparent),
            timeSlotViewSettings: const TimeSlotViewSettings(
              dayFormat: 'EEEE',
              timeIntervalHeight: 60.0,
              minimumAppointmentDuration: Duration(minutes: 30),
            ),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle:
                  textNormalCustom(fontSize: 13, color: unselectLabelColor),
            ),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
            todayHighlightColor: labelColor,
            appointmentTimeTextFormat: 'hh:mm:ss a',
            dataSource: cubit.getCalenderDataSource(
              snapshot.data ?? DataLichLvModel(),
            ),
            appointmentBuilder: (
              BuildContext context,
              CalendarAppointmentDetails calendarAppointmentDetails,
            ) {
              final Appointment appointment =
                  calendarAppointmentDetails.appointments.first;
              return Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: choTrinhKyColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      appointment.subject,
                      style: textNormalCustom(fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
