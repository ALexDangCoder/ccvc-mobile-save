import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWeekMobile extends StatefulWidget {
  final CalenderCubit cubit;

  const CalenderWeekMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CalenderWeekMobile> createState() => _CalenderWeekMobileState();
}

class _CalenderWeekMobileState extends State<CalenderWeekMobile> {
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

          return Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: StreamBuilder<DataLichLvModel>(
              stream: widget.cubit.streamListLich,
              builder: (context, snapshot) {
                return SfCalendar(
                  allowAppointmentResize: true,
                  controller: data,
                  viewHeaderHeight: 0.0,
                  headerHeight: 0.0,
                  appointmentTextStyle:
                      textNormalCustom(color: backgroundColorApp),
                  view: CalendarView.week,
                  todayHighlightColor: statusCalenderRed,
                  appointmentTimeTextFormat: 'hh:mm:ss a',
                  dataSource: widget.cubit.getCalenderDataSource(
                    snapshot.data ?? DataLichLvModel(),
                  ),
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeIntervalHeight: 54,
                  ),
                  selectionDecoration:
                      const BoxDecoration(color: Colors.transparent),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 2.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChiTietLichLamViecScreen(
                                        id: appointment.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  appointment.subject,
                                  style: textNormalCustom(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
