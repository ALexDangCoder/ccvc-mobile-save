import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InCalenderForm extends StatefulWidget {
  final CalenderCubit cubit;
  final Type_Choose_Option_Day type;

  const InCalenderForm({
    Key? key,
    required this.cubit,
    required this.type,
  }) : super(key: key);

  @override
  _InCalenderFormState createState() => _InCalenderFormState();
}

class _InCalenderFormState extends State<InCalenderForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.stateCalendarSubject.listen((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.cubit.changeItemMenuSubject.value.getHeader(
          cubit: widget.cubit,
          type: widget.type,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<CalendarController>(
              stream: widget.cubit.stateCalendarSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? CalendarController();

                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      spaceH16,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: StreamBuilder<DataLichLvModel>(
                            stream: widget.cubit.listLichSubject,
                            builder: (context, snapshot) {
                              return SfCalendar(
                                viewHeaderHeight: 0.0,
                                allowAppointmentResize: true,
                                headerHeight: 0.0,
                                controller: data,
                                appointmentTextStyle:
                                    textNormalCustom(color: backgroundColorApp),
                                todayHighlightColor: statusCalenderRed,
                                timeSlotViewSettings: const TimeSlotViewSettings(
                                  timeIntervalHeight: 54,
                                ),
                                selectionDecoration: const BoxDecoration(
                                    color: Colors.transparent),
                                appointmentTimeTextFormat: 'hh:mm:ss a',
                                dataSource: widget.cubit.getCalenderDataSource(
                                  snapshot.data ?? DataLichLvModel(),
                                ),
                                appointmentBuilder: (
                                  BuildContext context,
                                  CalendarAppointmentDetails
                                      calendarAppointmentDetails,
                                ) {
                                  final Appointment appointment =
                                      calendarAppointmentDetails
                                          .appointments.first;
                                  return GestureDetector(
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
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                        vertical: 2.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.0),
                                        color:
                                            AppTheme.getInstance().colorField(),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              appointment.subject,
                                              style: textNormalCustom(
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
