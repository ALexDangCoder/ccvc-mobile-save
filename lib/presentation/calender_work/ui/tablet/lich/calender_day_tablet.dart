import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderDayTablet extends StatefulWidget {
  const CalenderDayTablet({Key? key}) : super(key: key);

  @override
  _CalenderDayTabletState createState() => _CalenderDayTabletState();
}

class _CalenderDayTabletState extends State<CalenderDayTablet> {
  final CalendarController _controller = CalendarController();
  final CalenderCubit _cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceH28,
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(
              border: Border.all(color: cellColorborder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SfCalendar(
              viewHeaderHeight: 0,
              showDatePickerButton: true,
              allowAppointmentResize: true,
              headerHeight: 0,
              controller: _controller,
              cellEndPadding: 5,
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 88,
              ),
              selectionDecoration:
                  const BoxDecoration(color: Colors.transparent),
              appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
              todayHighlightColor: statusCalenderRed,
              appointmentTimeTextFormat: 'hh:mm:ss a',
              dataSource: _cubit.getCalenderDataSource(),
              appointmentBuilder: (
                BuildContext context,
                CalendarAppointmentDetails calendarAppointmentDetails,
              ) {
                final Appointment appointment =
                    calendarAppointmentDetails.appointments.first;
                return Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.blue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                appointment.subject,
                                style: textNormalCustom(),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        right: 4.0,
                                      ),
                                      height: 18.0,
                                      width: 18.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            'https://lh3.googleusercontent.com/ogw/ADea4I7KuOHLBX4h7PqlUfbDpmYAuuvb9iBc5eaCvicoFg=s192-c-mo',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Flexible(
                          child: Text(
                            '${appointment.startTime.toStringWithAMPM} -'
                            ' ${appointment.endTime.toStringWithAMPM}',
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
          ),
        ),
      ],
    );
  }
}
