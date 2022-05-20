import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoNgayTablet extends StatefulWidget {
  final LichHopCubit cubit;

  const LichHopTheoNgayTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<LichHopTheoNgayTablet> createState() => _LichHopTheoNgayTabletState();
}

class _LichHopTheoNgayTabletState extends State<LichHopTheoNgayTablet> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarController>(
        stream: widget.cubit.stateCalendarSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? CalendarController();

          return Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(
              border: Border.all(color: color05OpacityDBDFEF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10.0),
              child: StreamBuilder<DanhSachLichHopModel>(
                  stream: widget.cubit.danhSachLichHopStream,
                  builder: (context, snapshot) {
                    return SfCalendar(
                      viewHeaderHeight: 0,
                      showDatePickerButton: true,
                      allowAppointmentResize: true,
                      headerHeight: 0,
                      controller: data,
                      cellEndPadding: 5,
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeIntervalHeight: 88,
                      ),
                      selectionDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      appointmentTextStyle:
                          textNormalCustom(color: colorFFFFFF),
                      todayHighlightColor: colorEA5455,
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppTheme.getInstance().colorField(),
                            ),
                            child: GestureDetector(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          appointment.subject,
                                          style: textNormalCustom(),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                  right: 4.0,
                                                ),
                                                height: 18.0,
                                                width: 18.0,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      'https://th.bing.com/th/id/R.91e66c15f578d577c2b40dcf097f6a98?rik=41oluNFG8wUvYA&pid=ImgRaw&r=0',
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4.0),
                                  Flexible(
                                    child: Text(
                                      '${appointment.startTime.toStringWithAMPM} -'
                                      ' ${appointment.endTime.toStringWithAMPM}',
                                      style: textNormalCustom(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
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
                  }),
            ),
          );
        });
  }
}
