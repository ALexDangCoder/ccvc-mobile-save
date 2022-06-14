import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/ultis_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderFormMonth extends StatefulWidget {
  final CalenderCubit cubit;
  final Type_Choose_Option_Day type;

  const CalenderFormMonth({
    Key? key,
    required this.cubit,
    required this.type,
  }) : super(key: key);

  @override
  _CalenderFormMonthState createState() => _CalenderFormMonthState();
}

class _CalenderFormMonthState extends State<CalenderFormMonth> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.stateCalendarControllerDay
        .addPropertyChangedListener((value) {
      if (value == 'displayDate'){
        widget.cubit.updateDataSlideCalendar(
          widget.cubit.stateCalendarControllerDay.displayDate ??
              widget.cubit.selectDay,
        );
      }
    });
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
          child: SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: StreamBuilder<DataLichLvModel>(
                stream: widget.cubit.streamListLich,
                builder: (context, snapshot) {
                  return SfCalendar(
                    firstDayOfWeek: 1,
                    allowAppointmentResize: true,
                    controller: widget.cubit.stateCalendarControllerMonth,
                    headerHeight: 0.0,
                    appointmentTextStyle:
                        textNormalCustom(color: backgroundColorApp),
                    view: CalendarView.month,
                    todayHighlightColor: AppTheme.getInstance().colorField(),
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
                      if (calendarAppointmentDetails.appointments.length <= 1) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 2),
                          child: Container(
                            // height: 500,
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
                      } else {
                        return GestureDetector(
                          onTap: () {
                            widget.cubit.chooseTypeCalender(
                              Type_Choose_Option_Day.DAY,
                            );
                            widget.cubit.stateOptionDay =
                                Type_Choose_Option_Day.DAY;
                            widget.cubit.index.sink.add(0);
                            widget.cubit.initTimeSubject.sink
                                .add(calendarAppointmentDetails.date);
                            widget.cubit.selectDay =
                                calendarAppointmentDetails.date;
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
        ),
      ],
    );
  }
}
