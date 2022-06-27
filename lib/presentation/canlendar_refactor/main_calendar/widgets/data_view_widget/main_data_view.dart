import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/dashbroad_count_row.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/data_view_type_list.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainDataView extends StatefulWidget {
  const MainDataView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<MainDataView> createState() => _MainDataViewState();
}

class _MainDataViewState extends State<MainDataView> {
  final List<Widget> _listScreen = [];
  late List<Widget> _listCalendarScreen;

  @override
  void initState() {
    _listCalendarScreen = [
      StreamBuilder<DataSourceFCalendar>(
          stream: widget.cubit.listCalendarWorkStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? DataSourceFCalendar.empty();
            return DataViewCalendarDay(
              data: data,
              fCalendarController: widget.cubit.fCalendarControllerDay,
              propertyChanged: (String property) {
                widget.cubit.propertyChangedDay(property);
              },
              buildAppointment: itemAppointment,
            );
          }),
      StreamBuilder<DataSourceFCalendar>(
          stream: widget.cubit.listCalendarWorkStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? DataSourceFCalendar.empty();
            return DataViewCalendarWeek(
              buildAppointment: (data ){
                if (data is  AppointmentWithDuplicate){
                  if (data.isMore) {
                    return const  Icon(Icons.more_vert) ;
                  }
                }
                return itemAppointment(data);
              },
              propertyChanged: (String property) {
                widget.cubit.propertyChangedWeek(property);
              },
              data: data,
              fCalendarController: widget.cubit.fCalendarControllerWeek,
            );
          }),
      StreamBuilder<DataSourceFCalendar>(
          stream: widget.cubit.listCalendarWorkStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? DataSourceFCalendar.empty();
            return DataViewCalendarMonth(
              buildAppointment: itemAppointment,
              propertyChanged: (String property) {
                widget.cubit.propertyChangedMonth(property);
              },
              data: data,
              fCalendarController: widget.cubit.fCalendarControllerMonth,
            );
          }),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DashBroadCountRow(
            cubit: widget.cubit,
          ),
        ),
        Expanded(
          child: BlocBuilder(
            bloc: widget.cubit,
            buildWhen: (prev, state) => prev != state,
            builder: (context, CalendarWorkState state) {
              final typeState = state.typeView;
              if (_listScreen.isEmpty) {
                _listScreen.add(
                  IndexedStack(
                    index: typeState.index,
                    children: _listCalendarScreen,
                  ),
                );
              }
              if (_listScreen.isNotEmpty && state is CalendarViewState) {
                _listScreen[0] = IndexedStack(
                  index: typeState.index,
                  children: _listCalendarScreen,
                );
              }
              if (_listScreen.length == 1 && state is ListViewState) {
                _listScreen.add(
                  DataViewTypeList(
                    cubit: widget.cubit,
                  ),
                );
              }
              return IndexedStack(
                index: state is CalendarViewState ? 0 : 1,
                children: _listScreen,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget itemAppointment (Appointment appointment){
    if ( appointment is AppointmentWithDuplicate ){
      return GestureDetector(
        onTap: () {
          final TypeCalendar typeAppointment =
          getType(appointment.notes ?? 'Schedule');
          if (typeAppointment == TypeCalendar.Schedule) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChiTietLichLamViecScreen(
                  id: appointment.id as String? ?? '',
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMeetCalenderScreen(
                  id: appointment.id as String? ?? '',
                ),
              ),
            );
          }
        },
        child:  Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: AppTheme.getInstance().colorField(),
          ),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      appointment.subject,
                      style: textNormalCustom(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // const Icon(
                  //   Icons.circle,
                  //   color: Colors.red,
                  //   size: 10,
                  // ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    else {
      return const SizedBox.shrink();
    }
  }
}
