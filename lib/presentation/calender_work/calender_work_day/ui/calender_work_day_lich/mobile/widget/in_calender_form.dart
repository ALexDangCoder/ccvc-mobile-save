import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/calender_work_day_list/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InCalenderForm extends StatefulWidget {
  const InCalenderForm({Key? key}) : super(key: key);

  @override
  _InCalenderFormState createState() => _InCalenderFormState();
}

class _InCalenderFormState extends State<InCalenderForm> {
  final CalendarController _controller = CalendarController();
  final CalenderCubit _cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          spaceH16,
          SingleChildScrollView(
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
                  return CustomItemCalenderWork(
                    image: _cubit.img[index],
                    typeName: _cubit.list[index].typeName,
                    numberOfCalendars: _cubit.list[index].numberOfCalendars,
                  );
                },
              ),
            ),
          ),
          spaceH16,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SfCalendar(
                viewHeaderHeight: 0,
                allowViewNavigation: true,
                headerHeight: 0,
                controller: _controller,
                appointmentTextStyle:
                    textNormalCustom(color: backgroundColorApp),
                todayHighlightColor: statusCalenderRed,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 54,
                ),
                selectionDecoration:
                    const BoxDecoration(color: Colors.transparent),
                appointmentTimeTextFormat: 'hh:mm:ss a',
                dataSource: _cubit.getCalenderDataSource(),
                appointmentBuilder: (
                  BuildContext context,
                  CalendarAppointmentDetails calendarAppointmentDetails,
                ) {
                  final Appointment appointment =
                      calendarAppointmentDetails.appointments.first;
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 6, left: 8, bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: textColorMangXaHoi,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              appointment.subject,
                              style: textNormalCustom(fontSize: 12.0),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Flexible(
                            child: Text(
                              '${appointment.startTime.toStringWithAMPM} -'
                              ' ${appointment.endTime.toStringWithAMPM}',
                              style: textNormalCustom(
                                fontSize: 10.0,
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
      ),
    );
  }
}
