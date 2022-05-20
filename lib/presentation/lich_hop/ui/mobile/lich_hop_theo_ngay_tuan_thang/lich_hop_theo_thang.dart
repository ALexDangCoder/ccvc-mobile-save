import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoThang extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoThang({Key? key, required this.cubit}) : super(key: key);

  @override
  _LichHopTheoThangState createState() => _LichHopTheoThangState();
}

class _LichHopTheoThangState extends State<LichHopTheoThang> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();
          return SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: StreamBuilder<DanhSachLichHopModel>(
                  stream: widget.cubit.danhSachLichHopStream,
                  builder: (context, snapshot) {
                    return SfCalendar(
                      firstDayOfWeek: 1,
                      allowAppointmentResize: true,
                      controller: data,
                      headerHeight: 0.0,
                      appointmentTextStyle:
                          textNormalCustom(color: colorFFFFFF),
                      view: CalendarView.month,
                      todayHighlightColor: AppTheme.getInstance().colorField(),
                      appointmentTimeTextFormat: 'hh:mm:ss a',
                      dataSource: widget.cubit.getCalenderDataSource(
                        snapshot.data ?? DanhSachLichHopModel.empty(),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: textNormalCustom(
                            fontSize: 13, color: colorA2AEBD),
                      ),
                      monthViewSettings: MonthViewSettings(
                        showTrailingAndLeadingDates: false,
                        appointmentDisplayCount: 2,
                        monthCellStyle: MonthCellStyle(
                          trailingDatesTextStyle: textNormalCustom(
                              fontSize: 14, color: color3D5586),
                          textStyle: textNormalCustom(
                              fontSize: 14, color: color3D5586),
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

                        if (calendarAppointmentDetails.appointments.length <=
                            1) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 2),
                            child: GestureDetector(
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
                                height: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: AppTheme.getInstance().colorField(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                    vertical: 2.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              // widget.cubit.chooseTypeCalender(
                              //   Type_Choose_Option_Day.DAY,
                              // );
                              // widget.cubit.stateOptionDay =
                              //     Type_Choose_Option_Day.DAY;
                              // widget.cubit.index.sink.add(0);
                              // widget.cubit.callApi();
                            },
                            child: Column(
                              children: [
                                Text(
                                  '...',
                                  style: textNormalCustom(
                                    color: colorA2AEBD,
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
