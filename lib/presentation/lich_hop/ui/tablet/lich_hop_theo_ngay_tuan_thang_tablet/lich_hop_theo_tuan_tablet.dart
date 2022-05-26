import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoTuanTablet extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoTuanTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<LichHopTheoTuanTablet> createState() => _LichHopTheoTuanTabletState();
}

class _LichHopTheoTuanTabletState extends State<LichHopTheoTuanTablet> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();

          return Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            child: StreamBuilder<DanhSachLichHopModel>(
                stream: widget.cubit.danhSachLichHopStream,
                builder: (context, snapshot) {
                  return SfCalendar(
                    showDatePickerButton: true,
                    headerHeight: 0,
                    controller: data,
                    cellEndPadding: 5,
                    view: CalendarView.week,
                    timeSlotViewSettings: const TimeSlotViewSettings(
                      dayFormat: 'EEEE',
                      timeIntervalHeight: 60.0,
                      minimumAppointmentDuration: Duration(minutes: 30),
                    ),
                    viewHeaderStyle: ViewHeaderStyle(
                      dayTextStyle: textNormalCustom(
                          fontSize: 13, color: colorA2AEBD),
                    ),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                    ),
                    selectionDecoration:
                        const BoxDecoration(color: Colors.transparent),
                    appointmentTextStyle:
                        textNormalCustom(color: backgroundColorApp),
                    todayHighlightColor: Colors.black,
                    appointmentTimeTextFormat: 'hh:mm:ss a',
                    dataSource: widget.cubit.getCalenderDataSource(
                      snapshot.data ?? DanhSachLichHopModel.empty(),
                    ),
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
                              builder: (_) => DetailMeetCalenderTablet(
                                id: appointment.id.toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 2),
                          child: Container(
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: AppTheme.getInstance().colorField(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              child: Expanded(
                                child: Text(
                                  appointment.subject,
                                  style: textNormalCustom(fontSize: 12),
                                ),
                              ),
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
