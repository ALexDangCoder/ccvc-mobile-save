import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/type_calendar.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWeekMobile extends StatefulWidget {
  final CalenderCubit cubit;
  final Type_Choose_Option_Day type;

  const CalenderWeekMobile({
    Key? key,
    required this.cubit,
    required this.type,
  }) : super(key: key);

  @override
  State<CalenderWeekMobile> createState() => _CalenderWeekMobileState();
}

class _CalenderWeekMobileState extends State<CalenderWeekMobile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.stateCalendarControllerWeek
        .addPropertyChangedListener((value) {
      if (value == 'displayDate') {
        widget.cubit.updateDataSlideCalendar(
          widget.cubit.stateCalendarControllerWeek.displayDate ??
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
        // widget.cubit.changeItemMenuSubject.value.getHeader(
        //   cubit: widget.cubit,
        //   type: widget.type,
        // ),
        const SizedBox(
          height: 10,
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: StreamBuilder<DataLichLvModel>(
              stream: widget.cubit.streamListLich,
              builder: (context, snapshot) {
                return SfCalendar(
                  allowAppointmentResize: true,
                  controller: widget.cubit.stateCalendarControllerWeek,
                  viewHeaderHeight: 0.0,
                  headerHeight: 0.0,
                  appointmentTextStyle:
                      textNormalCustom(color: backgroundColorApp),
                  view: CalendarView.week,
                  todayHighlightColor: statusCalenderRed,
                  appointmentTimeTextFormat: 'hh:mm:ss a',
                  dataSource: widget.cubit.getCalenderDataSource(
                    snapshot.data ?? DataLichLvModel(),
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
                        final String typeCalendar = widget.cubit
                                .getElementFromId(
                                  appointment.id.toString(),
                                )
                                .typeSchedule ??
                            'Schedule';
                        final element =  widget.cubit.getElementFromId(
                          appointment.id.toString(),
                        );
                        if (element != null){
                          typeCalendar.getTypeCalendar.navigatorDetail(
                            context,
                            widget.cubit,
                            (widget.cubit.dataLichLvModel.listLichLVModel ??
                                [])
                                .indexOf(element),
                          );
                        }
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                ).isTrung)
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
          ),
        ),
      ],
    );
  }
}
