import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWeekMobile extends StatefulWidget {
  const CalenderWeekMobile({Key? key}) : super(key: key);

  @override
  State<CalenderWeekMobile> createState() => _CalenderWeekMobileState();
}

class _CalenderWeekMobileState extends State<CalenderWeekMobile> {
  final CalendarController _controller = CalendarController();
  CalenderCubit cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: SfCalendar(
        allowAppointmentResize: true,
        controller: _controller,
        viewHeaderHeight: 0.0,
        headerHeight: 0.0,
        appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
        view: CalendarView.week,
        todayHighlightColor: statusCalenderRed,
        appointmentTimeTextFormat: 'hh:mm:ss a',
        dataSource: cubit.getCalenderDataSource(),
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 54,
        ),
        selectionDecoration: const BoxDecoration(color: Colors.transparent),
        appointmentBuilder: (
          BuildContext context,
          CalendarAppointmentDetails calendarAppointmentDetails,
        ) {
          final Appointment appointment =
              calendarAppointmentDetails.appointments.first;
          // final distanceTime =
          //     appointment.startTime.difference(appointment.endTime);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: textColorMangXaHoi,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      appointment.subject,
                      style: textNormalCustom(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
