import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/item_appoinment_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ViewDataMeeting extends StatefulWidget {
  const ViewDataMeeting({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CalendarMeetingCubit cubit;

  @override
  State<ViewDataMeeting> createState() => _ViewDataMeetingState();
}

class _ViewDataMeetingState extends State<ViewDataMeeting> {
  final List<Widget> _listScreen = [];
  late List<Widget> _listCalendarScreen;

  @override
  void initState() {
    _listCalendarScreen = [
      StreamBuilder<DataSourceFCalendar>(
        stream: widget.cubit.listCalendarWorkDayStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataSourceFCalendar.empty();
          return DataViewCalendarDay(
            data: data,
            fCalendarController: widget.cubit.fCalendarControllerDay,
            propertyChanged: (String property) {
              //widget.cubit.propertyChangedDay(property);
            },
            buildAppointment: itemAppointment,
          );
        },
      ),
      StreamBuilder<DataSourceFCalendar>(
        stream: widget.cubit.listCalendarWorkWeekStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataSourceFCalendar.empty();
          return DataViewCalendarWeek(
            buildAppointment: itemAppointment,
            propertyChanged: (String property) {
              // widget.cubit.propertyChangedWeek(property);
            },
            data: data,
            fCalendarController: widget.cubit.fCalendarControllerWeek,
          );
        },
      ),
      StreamBuilder<DataSourceFCalendar>(
        stream: widget.cubit.listCalendarWorkMonthStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataSourceFCalendar.empty();
          return DataViewCalendarMonth(
            buildAppointment: itemAppointment,
            propertyChanged: (String property) {
              //  widget.cubit.propertyChangedMonth(property);
            },
            data: data,
            fCalendarController: widget.cubit.fCalendarControllerMonth,
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder(
            bloc: widget.cubit,
            buildWhen: (prev, state) => prev != state,
            builder: (context, CalendarMeetingState state) {
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
                _listScreen.add(Container(child : Text('listView'))
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
    return GestureDetector(
      onTap: () {
        /// go to detail
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMeetCalenderScreen(
              id: appointment.id as String? ?? '',
            ),
          ),
        );
      },
      child: ItemAppointment(appointment: appointment),
    );
  }
}
