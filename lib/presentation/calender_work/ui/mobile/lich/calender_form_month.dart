import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderFormMonth extends StatefulWidget {
  final CalenderCubit cubit;

  const CalenderFormMonth({Key? key, required this.cubit}) : super(key: key);

  @override
  _CalenderFormMonthState createState() => _CalenderFormMonthState();
}

class _CalenderFormMonthState extends State<CalenderFormMonth> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();

          return Column(
            children: [
              spaceH20,
              Expanded(
                child: StreamBuilder<DataLichLvModel>(
                  stream: widget.cubit.streamListLich,
                  builder: (context, snapshot) {
                    return SfCalendar(
                      firstDayOfWeek: 1,
                      allowAppointmentResize: true,
                      controller: data,
                      headerHeight: 0.0,
                      appointmentTextStyle:
                          textNormalCustom(color: backgroundColorApp),
                      view: CalendarView.month,
                      todayHighlightColor: labelColor,
                      appointmentTimeTextFormat: 'hh:mm:ss a',
                      dataSource: widget.cubit.getCalenderDataSource(
                        snapshot.data ?? DataLichLvModel(),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: textNormalCustom(
                          fontSize: 13,
                          color: unselectLabelColor,
                        ),
                      ),
                      monthViewSettings: MonthViewSettings(
                        showTrailingAndLeadingDates: false,
                       // appointmentDisplayCount: 2,
                        monthCellStyle: MonthCellStyle(
                          trailingDatesTextStyle: textNormalCustom(
                            fontSize: 14,
                            color: iconColorDown,
                          ),
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
                        print("aaa${calendarAppointmentDetails.appointments.length}");

                        return Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 2),
                          child: Container(
                            // height: 500,
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ChiTietLichLamViecScreen(
                                              id: appointment.id.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        appointment.subject,
                                        style: textNormalCustom(fontSize: 8),
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
        });
  }
}
