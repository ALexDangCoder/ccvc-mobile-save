import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoThangTablet extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoThangTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _LichHopTheoThangTabletState createState() => _LichHopTheoThangTabletState();
}

class _LichHopTheoThangTabletState extends State<LichHopTheoThangTablet> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(right: 30, left: 30),
              height: 500,
              child: StreamBuilder<DanhSachLichHopModel>(
                  stream: widget.cubit.danhSachLichHopStream,
                  builder: (context, snapshot) {
                    return SfCalendar(
                      allowAppointmentResize: true,
                      controller: data,
                      headerHeight: 0.0,
                      view: CalendarView.month,
                      todayHighlightColor: AppTheme.getInstance().colorField(),
                      appointmentTimeTextFormat: 'hh:mm:ss a',
                      dataSource: widget.cubit.getCalenderDataSource(
                        snapshot.data ?? DanhSachLichHopModel.empty(),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle:
                            textNormalCustom(fontSize: 13, color: colorA2AEBD),
                      ),
                      monthViewSettings: MonthViewSettings(
                        showTrailingAndLeadingDates: false,
                        dayFormat: 'EEEE',
                        appointmentDisplayCount: 2,
                        monthCellStyle: MonthCellStyle(
                          backgroundColor: bgCalenderColor,
                          trailingDatesTextStyle: textNormalCustom(
                              fontSize: 14, color: iconColorDown),
                          textStyle: textNormalCustom(
                              fontSize: 14, color: fontColorTablet2),
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

                        if (calendarAppointmentDetails.appointments.length <=
                            1) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2, bottom: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: AppTheme.getInstance().colorField(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        appointment.subject,
                                        style: textNormalCustom(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {},
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
                  }),
            ),
          );
        });
  }
}
