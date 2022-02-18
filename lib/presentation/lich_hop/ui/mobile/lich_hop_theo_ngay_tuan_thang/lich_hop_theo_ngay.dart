import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoNgay extends StatefulWidget {
  const LichHopTheoNgay({Key? key}) : super(key: key);

  @override
  _LichHopTheoNgayState createState() => _LichHopTheoNgayState();
}

class _LichHopTheoNgayState extends State<LichHopTheoNgay> {
  final CalendarController _controller = CalendarController();
  LichHopCubit cubit = LichHopCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: SfCalendar(
        allowAppointmentResize: true,
        controller: _controller,
        viewHeaderHeight: 0.0,
        headerHeight: 0.0,
        appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
        view: CalendarView.day,
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
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: textColorMangXaHoi,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      appointment.subject,
                      style: textNormalCustom(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Flexible(
                    child: Text(
                      '${appointment.startTime.toStringWithAMPM} - ${appointment.endTime.toStringWithAMPM}',
                      style: textNormalCustom(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
