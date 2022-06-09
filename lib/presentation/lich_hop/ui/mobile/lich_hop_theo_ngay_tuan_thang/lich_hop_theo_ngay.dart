import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopTheoNgay extends StatefulWidget {
  final LichHopCubit cubit;
  final Type_Choose_Option_Day type;

  const LichHopTheoNgay({
    Key? key,
    required this.cubit,
    required this.type,
  }) : super(key: key);

  @override
  _LichHopTheoNgayState createState() => _LichHopTheoNgayState();
}

class _LichHopTheoNgayState extends State<LichHopTheoNgay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.cubit.changeItemMenuSubject.value.getHeaderLichHop(
          cubit: widget.cubit,
          type: widget.type,
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: StreamBuilder<CalendarController>(
              stream: widget.cubit.stateCalendarSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? CalendarController();
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
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
                            CalendarAppointmentDetails
                                calendarAppointmentDetails,
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
                                  color: AppTheme.getInstance().colorField(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 4.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          appointment.subject,
                                          style: textNormalCustom(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Flexible(
                                        child: Text(
                                          '${appointment.startTime.toStringWithAMPM} - ${appointment.endTime.toStringWithAMPM}',
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
                );
              }),
        ),
      ],
    );
  }
}
