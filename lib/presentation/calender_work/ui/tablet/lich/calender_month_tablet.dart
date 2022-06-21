import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/ultis_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/type_calendar.dart';
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
    widget.cubit.stateCalendarControllerMonth
        .addPropertyChangedListener((value) {
      if (value == 'displayDate'){
        widget.cubit.updateDataSlideCalendar(
          widget.cubit.stateCalendarControllerMonth.displayDate ??
              widget.cubit.selectDay,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
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
                controller: widget.cubit.stateCalendarControllerMonth,
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
                        final String typeCalendar = widget.cubit
                            .getElementFromId(
                          appointment.id.toString(),
                        ).typeSchedule ??
                            'Schedule';
                        final element =  widget.cubit.getElementFromId(
                          appointment.id.toString(),
                        );
                        typeCalendar.getTypeCalendar.navigatorDetail(
                          context,
                          widget.cubit,
                          (widget.cubit.dataLichLvModel.listLichLVModel ??
                              [])
                              .indexOf(element),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppTheme.getInstance().colorField(),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      appointment.subject,
                                      style: textNormalCustom(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                ],
                              ),
                            ),
                            if (widget.cubit
                                .getElementFromId(
                              appointment.id.toString(),
                            ).isTrung ?? false)
                              const Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 10,
                              )
                            else
                              Container()
                          ],
                        ),
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
  }
}
