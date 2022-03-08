import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.callApi();
  }

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
            child: StreamBuilder<DataLichLvModel>(
              stream: _cubit.streamListLich,
              builder: (context, snapshot) {
                return SfCalendar(
                  viewHeaderHeight: 0.0,
                  headerHeight: 0.0,
                  controller: _controller,
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeIntervalHeight: 88,
                  ),
                  selectionDecoration:
                      const BoxDecoration(color: Colors.transparent),
                  appointmentTextStyle:
                      textNormalCustom(color: backgroundColorApp),
                  todayHighlightColor: statusCalenderRed,
                  appointmentTimeTextFormat: 'hh:mm:ss a',
                  dataSource: _cubit.getCalenderDataSource(
                    snapshot.data ?? DataLichLvModel(),
                  ),
                  appointmentBuilder: (
                    BuildContext context,
                    CalendarAppointmentDetails calendarAppointmentDetails,
                  ) {
                    final Appointment appointment =
                        calendarAppointmentDetails.appointments.first;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: choTrinhKyColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              appointment.subject,
                              style: textNormalCustom(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
