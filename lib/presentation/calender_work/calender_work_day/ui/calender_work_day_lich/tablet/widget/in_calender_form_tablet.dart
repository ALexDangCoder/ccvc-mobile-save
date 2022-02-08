import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InCalenderFormTablet extends StatefulWidget {
  const InCalenderFormTablet({Key? key}) : super(key: key);

  @override
  _InCalenderFormTabletState createState() => _InCalenderFormTabletState();
}

class _InCalenderFormTabletState extends State<InCalenderFormTablet> {
  final CalendarController _controller = CalendarController();
  final CalenderCubit _cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 28),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: backgroundColorApp,
              height: 88,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _cubit.list.length,
                itemBuilder: (context, index) {
                  return CustomItemCalenderWorkTablet(
                    image: _cubit.img[index],
                    typeName: _cubit.list[index].typeName,
                    numberOfCalendars: _cubit.list[index].numberOfCalendars,
                  );
                },
              ),
            ),
          ),
        ),
        spaceH28,
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(
              border: Border.all(color: cellColorborder),
              borderRadius: BorderRadius.circular(14),
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
