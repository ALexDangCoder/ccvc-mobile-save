import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
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
  final CalenderCubit cubit = CalenderCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.callApiMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceH20,
        Expanded(
          child: StreamBuilder<DataLichLvModel>(
            stream: cubit.streamListLich,
            builder: (context, snapshot) {
              return SfCalendar(
                firstDayOfWeek: 1,
                allowAppointmentResize: true,
                controller: _controller,
                headerHeight: 0.0,
                appointmentTextStyle:
                    textNormalCustom(color: backgroundColorApp),
                view: CalendarView.month,
                todayHighlightColor: labelColor,
                appointmentTimeTextFormat: 'hh:mm:ss a',
                dataSource: cubit.getCalenderDataSource(
                  snapshot.data ?? DataLichLvModel(),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: textNormalCustom(
                    fontSize: 13,
                    color: unselectLabelColor,
                  ),
                ),
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: 2,
                  monthCellStyle: MonthCellStyle(
                    trailingDatesTextStyle:
                        textNormalCustom(fontSize: 14, color: iconColorDown),
                    textStyle: textNormalCustom(
                      fontSize: 14,
                      color: fontColorTablet2,
                    ),
                  ),
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
                selectionDecoration:
                    const BoxDecoration(color: Colors.transparent),
                appointmentBuilder: (
                  BuildContext context,
                  CalendarAppointmentDetails calendarAppointmentDetails,
                ) {
                  final Appointment appointment =
                      calendarAppointmentDetails.appointments.first;
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
              );
            },
          ),
        ),
      ],
    );
  }
}
