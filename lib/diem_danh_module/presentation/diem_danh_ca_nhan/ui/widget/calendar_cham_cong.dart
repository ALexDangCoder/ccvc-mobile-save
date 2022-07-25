import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/view_day_calendar_widget.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_diem_danh_ca_nhan.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CalendarChamCong extends StatefulWidget {
  final DiemDanhCubit cubit;
  final CalendarController? controller;

  const CalendarChamCong({Key? key, required this.cubit, this.controller})
      : super(key: key);

  @override
  State<CalendarChamCong> createState() => _CalendarChamCongState();
}

class _CalendarChamCongState extends State<CalendarChamCong> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: StreamBuilder<List<BangDiemDanhCaNhanModel>>(
        stream: widget.cubit.listBangDiemDanh,
        builder: (context, snapshot) {
          return SfCalendar(
            firstDayOfWeek: 1,
            allowAppointmentResize: true,
            controller: widget.controller,
            headerHeight: 0.0,
            dataSource:
            DataSource(source: widget.cubit.toDataFCalenderSource()),
            view: CalendarView.month,
            todayHighlightColor: color7966FF,
            appointmentTimeTextFormat: 'hh:mm:ss a',
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: textNormalCustom(
                fontSize: 13,
                color: colorA2AEBD,
              ),
            ),
            monthViewSettings: MonthViewSettings(
              agendaViewHeight: 100,
              appointmentDisplayCount: 1,
              monthCellStyle: MonthCellStyle(
                trailingDatesTextStyle: textNormalCustom(
                  fontSize: 14,
                  color: iconColorDown,
                ),
                textStyle: textNormalCustom(
                  fontSize: 14,
                  color: fontColorTablet2,
                ),
                // todayBackgroundColor: widget.isTablet ?  bgCalenderColor : null,
              ),
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            selectionDecoration: const BoxDecoration(color: Colors.transparent),
            appointmentBuilder: (_, appointmentDetail) {
              final AppointmentWithDuplicate appointment =
                  appointmentDetail.appointments.first;
              return ViewDayCalendarWidget(
                state: widget.cubit.getStateDiemDanh(appointment.model),
                dayWage: appointment.model.dayWage ?? 0.0,
                timeIn: appointment.model.timeIn ?? '',
                timeOut: appointment.model.timeOut ?? '',
              );
            },
          );
        },
      ),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource({required List<AppointmentWithDuplicate> source}) {
    appointments = source;
  }

  DataSource.empty() {
    appointments = <AppointmentWithDuplicate>[];
  }
}
