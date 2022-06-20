import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/type_calendar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWeekTablet extends StatefulWidget {
  final CalenderCubit cubit;

  const CalenderWeekTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CalenderWeekTablet> createState() => _CalenderWeekTabletState();
}

class _CalenderWeekTabletState extends State<CalenderWeekTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.stateCalendarControllerDay.
        addPropertyChangedListener((value) {
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
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30),
      child: StreamBuilder<DataLichLvModel>(
        stream: widget.cubit.streamListLich,
        builder: (context, snapshot) {
          return SfCalendar(
            showCurrentTimeIndicator: false,
            showDatePickerButton: true,
            headerHeight: 0,
            controller: widget.cubit.stateCalendarControllerWeek,
            cellEndPadding: 5,
            view: CalendarView.week,
            selectionDecoration:
            const BoxDecoration(color: Colors.transparent),
            timeSlotViewSettings: const TimeSlotViewSettings(
              dayFormat: 'EEEE',
              timeIntervalHeight: 60.0,
              minimumAppointmentDuration: Duration(minutes: 30),
            ),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle:
              textNormalCustom(fontSize: 13, color: colorA2AEBD),
            ),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode:
              MonthAppointmentDisplayMode.appointment,
            ),
            appointmentTextStyle:
            textNormalCustom(color: backgroundColorApp),
            todayHighlightColor: AppTheme.getInstance().colorField(),
            appointmentTimeTextFormat: 'hh:mm:ss a',
            dataSource: widget.cubit.getCalenderDataSource(
              snapshot.data ?? DataLichLvModel(),
            ),
            appointmentBuilder: (
                BuildContext context,
                CalendarAppointmentDetails calendarAppointmentDetails,
                ) {
              final Appointment appointment =
                  calendarAppointmentDetails.appointments.first;
              return GestureDetector(
                onTap: () {
                  final String typeCalendar = widget.cubit
                      .getElementFromId(
                    appointment.id.toString(),
                  )
                      .typeSchedule ??
                      'Schedule';

                  typeCalendar.getTypeCalendar.navigatorDetail(
                    context,
                    widget.cubit,
                    (widget.cubit.dataLichLvModel
                        .listLichLVModel ??
                        [])
                        .indexOf(
                      widget.cubit.getElementFromId(
                        appointment.id.toString(),
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
                      )
                          .isTrung)
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
            },
          );
        },
      ),
    );
  }
}
