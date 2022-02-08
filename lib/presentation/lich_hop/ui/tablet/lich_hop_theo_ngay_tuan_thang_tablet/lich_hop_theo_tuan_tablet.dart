import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoTuanTablet extends StatefulWidget {
  const LichHopTheoTuanTablet({Key? key}) : super(key: key);

  @override
  State<LichHopTheoTuanTablet> createState() => _LichHopTheoTuanTabletState();
}

class _LichHopTheoTuanTabletState extends State<LichHopTheoTuanTablet> {
  final CalendarController _controller = CalendarController();
  LichHopCubit cubit = LichHopCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30),
      child: SfCalendar(
        showDatePickerButton: true,
        headerHeight: 0,
        controller: _controller,
        cellEndPadding: 5,

        view: CalendarView.week,
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
        selectionDecoration: const BoxDecoration(color: Colors.transparent),
        appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
        todayHighlightColor: Colors.black,
        appointmentTimeTextFormat: 'hh:mm:ss a',
        dataSource: cubit.getCalenderDataSource(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text(
                 appointment.subject,
                  style: textNormalCustom(fontSize: 12),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
