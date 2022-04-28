import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoTuan extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoTuan({Key? key, required this.cubit}) : super(key: key);

  @override
  State<LichHopTheoTuan> createState() => _LichHopTheoTuanState();
}

class _LichHopTheoTuanState extends State<LichHopTheoTuan> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StreamBuilder<DanhSachLichHopModel>(
                stream: widget.cubit.danhSachLichHopStream,
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
                      snapshot.data ?? DanhSachLichHopModel.empty(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailMeetCalenderScreen(
                                id: appointment.id.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: textColorMangXaHoi,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    appointment.subject,
                                    style: textNormalCustom(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          );
        });
  }
}
