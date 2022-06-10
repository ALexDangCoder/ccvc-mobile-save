import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderMonthTablet extends StatefulWidget {
  final CalenderCubit cubit;

  const CalenderMonthTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _CalenderMonthTabletState createState() => _CalenderMonthTabletState();
}

class _CalenderMonthTabletState extends State<CalenderMonthTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.stateCalendarDaySubject.listen((value) {});
    widget.cubit.stateCalendarDaySubject.value
        .addPropertyChangedListener((value) {
      widget.cubit.updateDataSlideCalendar(
        widget.cubit.stateCalendarDaySubject.value.displayDate ??
            widget.cubit.selectDay,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
      stream: widget.cubit.stateCalendarMonthSubject.stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? CalendarController();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 24),
            child: Container(
              height: 500,
              margin: const EdgeInsets.only(right: 30),
              child: StreamBuilder<DataLichLvModel>(
                stream: widget.cubit.streamListLich,
                builder: (context, snapshot) {
                  return SfCalendar(
                    firstDayOfWeek: 1,
                    allowAppointmentResize: true,
                    controller: data,
                    headerHeight: 0.0,
                    view: CalendarView.month,
                    todayHighlightColor: labelColor,
                    appointmentTimeTextFormat: 'hh:mm:ss a',
                    dataSource: widget.cubit.getCalenderDataSource(
                      snapshot.data ?? DataLichLvModel(),
                    ),
                    viewHeaderStyle: ViewHeaderStyle(
                      dayTextStyle: textNormalCustom(
                        fontSize: 13,
                        color: colorA2AEBD,
                      ),
                    ),
                    monthViewSettings: MonthViewSettings(
                      showTrailingAndLeadingDates: false,
                      appointmentDisplayCount: 2,
                      monthCellStyle: MonthCellStyle(
                        backgroundColor: bgCalenderColor,
                        trailingDatesTextStyle: textNormalCustom(
                          fontSize: 14,
                          color: iconColorDown,
                        ),
                        textStyle: textNormalCustom(
                          fontSize: 14,
                          color: fontColorTablet2,
                        ),
                      ),
                      // numberOfWeeksInView: 4,
                      //showAgenda: true,
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

                      if (calendarAppointmentDetails.appointments.length <= 1) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 2, bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: choTrinhKyColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ChiTietLamViecTablet(
                                              id: appointment.id.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        appointment.subject,
                                        style: textNormalCustom(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            widget.cubit.chooseTypeCalender(
                              Type_Choose_Option_Day.DAY,
                            );
                            widget.cubit.stateOptionDay =
                                Type_Choose_Option_Day.DAY;
                            widget.cubit.index.sink.add(0);
                            widget.cubit.callApi();
                          },
                          child: Column(
                            children: [
                              Text(
                                '...',
                                style: textNormalCustom(
                                  color: textBodyTime,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
