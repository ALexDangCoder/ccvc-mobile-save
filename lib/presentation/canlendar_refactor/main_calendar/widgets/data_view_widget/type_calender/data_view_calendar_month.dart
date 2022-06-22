import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataViewCalendarMonth extends StatefulWidget {
  const DataViewCalendarMonth({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<DataViewCalendarMonth> createState() => _DataViewCalendarMonthState();
}

class _DataViewCalendarMonthState extends State<DataViewCalendarMonth> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataLichLvModel>(
      stream: widget.cubit.listCalendarWorkStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? DataLichLvModel();
        return SfCalendar(
          firstDayOfWeek: 1,
          allowAppointmentResize: true,
          controller: widget.cubit.fCalendarController,
          headerHeight: 0.0,
          view: CalendarView.month,
          todayHighlightColor: labelColor,
          appointmentTimeTextFormat: 'hh:mm:ss a',
          dataSource: data.toDataFCalenderSource(),
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
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
          selectionDecoration: const BoxDecoration(color: Colors.transparent),
          appointmentBuilder: (_, calendarAppointment) {
            return Container(
              color: Colors.red,
            );
          },
        );
      },
    );
  }
}
