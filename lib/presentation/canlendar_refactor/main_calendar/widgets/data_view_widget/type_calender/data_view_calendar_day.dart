import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataViewCalendarDay extends StatefulWidget {
  const DataViewCalendarDay({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<DataViewCalendarDay> createState() => _DataViewCalendarDayState();
}

class _DataViewCalendarDayState extends State<DataViewCalendarDay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataLichLvModel>(
      stream: widget.cubit.listCalendarWorkStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? DataLichLvModel();
        return SfCalendar(
          viewHeaderHeight: 0.0,
          headerHeight: 0.0,
          controller: widget.cubit.calendarControllerDay,
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeIntervalHeight: 88,
          ),
          selectionDecoration: const BoxDecoration(color: Colors.transparent),
          appointmentTextStyle: textNormalCustom(color: backgroundColorApp),
          todayHighlightColor: statusCalenderRed,
          appointmentTimeTextFormat: 'hh:mm:ss a',
          dataSource: data.toDataFCalenderSource(),
          appointmentBuilder: (_, appointmentDetail) {
            final Appointment appointment =
                appointmentDetail.appointments.first;
            return GestureDetector(
              onTap: () {},
              child: itemEvent(appointment),
            );
          },
        );
      },
    );
  }

  Widget itemEvent(Appointment appointment) {
    return Container(
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
          const Icon(
            Icons.circle,
            color: Colors.red,
            size: 10,
          ),
        ],
      ),
    );
  }
}
