import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarChamCong extends StatefulWidget {
  const CalendarChamCong({Key? key}) : super(key: key);

  @override
  State<CalendarChamCong> createState() => _CalendarChamCongState();
}

class _CalendarChamCongState extends State<CalendarChamCong> {
  CalendarController controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCalendar(
        firstDayOfWeek: 1,
        allowAppointmentResize: true,
        controller: controller,
        headerHeight: 0.0,

        view: CalendarView.month,
        todayHighlightColor: color7966FF,
        appointmentTimeTextFormat: 'hh:mm:ss a',
        // dataSource: CalendarDataSourceAction.addResource([]),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: textNormalCustom(
            fontSize: 13,
            color: colorA2AEBD,
          ),
        ),
        viewHeaderHeight: 50,

        monthViewSettings: MonthViewSettings(
          agendaViewHeight: 50,
          appointmentDisplayCount: 3,
          monthCellStyle: MonthCellStyle(
            trailingDatesTextStyle: textNormalCustom(
              fontSize: 14,
              color: iconColorDown,
            ),
            textStyle: textNormalCustom(
              fontSize: 14,
              color: fontColorTablet2,

            ),
            // todayBackgroundColor: widget.isTablet ?  bgCalenderColor : null,
          ),
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        selectionDecoration: const BoxDecoration(color: Colors.transparent),
        appointmentBuilder: (_, appointmentDetail) {
          final Appointment appointment = appointmentDetail.appointments.first;
          return Container(
            height: 30,
          );
        },
      ),
    );
  }
}
