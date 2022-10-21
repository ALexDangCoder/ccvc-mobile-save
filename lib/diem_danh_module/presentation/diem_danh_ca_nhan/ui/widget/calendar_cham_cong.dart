import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/view_day_calendar_widget.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_diem_danh_ca_nhan.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
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
      height: 700,
      child: StreamBuilder<List<BangDiemDanhCaNhanModel>>(
        stream: widget.cubit.listBangDiemDanh,
        builder: (context, snapshot) {
          return SfCalendar(
            firstDayOfWeek: 7,
            allowAppointmentResize: true,
            controller: widget.controller,
            headerHeight: 0.0,
            dataSource:
            DataSource(source: widget.cubit.toDataFCalenderSource()),
            view: CalendarView.month,
            todayHighlightColor: AppTheme.getInstance().colorField(),
            appointmentTimeTextFormat: 'hh:mm:ss a',
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: textNormalCustom(
                fontSize: 13,
                color: colorA2AEBD,
              ),
            ),
            monthViewSettings: MonthViewSettings(
              agendaViewHeight: 120,
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
              dayFormat: isMobile()?'EE':'EEEE',
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            selectionDecoration: const BoxDecoration(color: Colors.transparent),
            appointmentBuilder: (_, appointmentDetail) {
              final AppointmentWithDuplicate appointment =
                  appointmentDetail.appointments.first;

              final dataTime = DateTime.parse(
                timeFormat(
                  appointment.model.date ?? '',
                  DateTimeFormat.DAY_MONTH_YEAR,
                  DateTimeFormat.FORMAT_REQUEST,
                ),
              );

              return ViewDayCalendarWidget(
                isShowDateAndDayWage: dataTime.isBefore(DateTime.now()) ,
                state: widget.cubit.getStateDiemDanh(appointment.model),
                dayWage: appointment.model.dayWage ?? 0.0,
                timeIn: appointment.model.timeIn ?? '',
                timeOut: appointment.model.timeOut ?? '',
                type: appointment.model.type??'',
                leaveRequestReasonCode: appointment.model.leaveRequestReasonCode??'',
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
