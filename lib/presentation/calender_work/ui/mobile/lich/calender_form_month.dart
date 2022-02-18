import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderFormMonth extends StatefulWidget {
  const CalenderFormMonth({Key? key}) : super(key: key);

  @override
  _CalenderFormMonthState createState() => _CalenderFormMonthState();
}

class _CalenderFormMonthState extends State<CalenderFormMonth> {
  final CalendarController _controller = CalendarController();
  final CalenderCubit _cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceH20,
        Expanded(
          child: SfCalendar(
            allowAppointmentResize: true,
            controller: _controller,
            headerHeight: 0.0,
            appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
            view: CalendarView.month,
            todayHighlightColor: labelColor,
            appointmentTimeTextFormat: 'hh:mm:ss a',
            dataSource: _cubit.getCalenderDataSource(),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle:
                  textNormalCustom(fontSize: 13, color: unselectLabelColor),
            ),
            monthViewSettings: MonthViewSettings(
              appointmentDisplayCount: 2,
              monthCellStyle: MonthCellStyle(
                trailingDatesTextStyle:
                    textNormalCustom(fontSize: 14, color: iconColorDown),
                textStyle:
                    textNormalCustom(fontSize: 14, color: fontColorTablet2),
              ),
              // numberOfWeeksInView: 4,
              //showTrailingAndLeadingDates: false,
              //showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
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
              return Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: textColorMangXaHoi,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 2.0,
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: Text(
                            appointment.subject,
                            style: textNormalCustom(fontSize: 8),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
