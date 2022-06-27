import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataViewCalendarMonth extends StatefulWidget {
  const DataViewCalendarMonth({
    Key? key,
    required this.propertyChanged,
    required this.buildAppointment,
    required this.data,
    required this.fCalendarController,
    this.onMore,
  }) : super(key: key);
  final Function(DateTime)? onMore;
  final Function(String property) propertyChanged;
  final DataSourceFCalendar data;
  final CalendarController fCalendarController;
  final Widget Function(Appointment appointment) buildAppointment;

  @override
  State<DataViewCalendarMonth> createState() => _DataViewCalendarMonthState();
}

class _DataViewCalendarMonthState extends State<DataViewCalendarMonth> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate =
        getOnlyDate(widget.fCalendarController.displayDate ?? DateTime.now());
    setFCalendarListenerWeek();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DataViewCalendarMonth oldWidget) {
    super.didUpdateWidget(oldWidget);
    checkDuplicate(
      widget.data.appointments as List<AppointmentWithDuplicate>? ?? [],
    );
  }

  void checkDuplicate(List<AppointmentWithDuplicate> list) {
    for (final item in list) {
      final currentTimeFrom = item.startTime.millisecondsSinceEpoch;
      final currentTimeTo = item.endTime.millisecondsSinceEpoch;
      final listDuplicate = list.where((element) {
        final startTime = element.startTime.millisecondsSinceEpoch;
        if (startTime >= currentTimeFrom && startTime < currentTimeTo) {
          return true;
        }
        return false;
      });
      if (listDuplicate.length > 1) {
        for (int i = 0; i < listDuplicate.length; i++) {
          listDuplicate.elementAt(i).isDuplicate = true;
        }
      }
    }

  }


  void setFCalendarListenerWeek() {
    widget.fCalendarController
        .addPropertyChangedListener(widget.propertyChanged);
  }

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 650,
        ),
        height: 650,
        child: SfCalendar(
          firstDayOfWeek: 1,
          allowAppointmentResize: true,
          controller: widget.fCalendarController,
          headerHeight: 0.0,
          view: CalendarView.month,
          todayHighlightColor: labelColor,
          appointmentTimeTextFormat: 'hh:mm:ss a',
          dataSource: widget.data,
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: textNormalCustom(
              fontSize: 13,
              color: colorA2AEBD,
            ),
          ),
          monthViewSettings: MonthViewSettings(
            appointmentDisplayCount: 3,
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
          appointmentBuilder: (_, appointmentDetail) {
            final Appointment appointment =
                appointmentDetail.appointments.first;
            return appointmentDetail.appointments.length > 2
                ? GestureDetector(
                    onTap: () {
                      widget.onMore?.call(appointmentDetail.date);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.more_horiz,
                        color: textBodyTime,
                      ),
                    ),
                  )
                : widget.buildAppointment(appointment);
          },
        ),
      ),
    );
  }


}
