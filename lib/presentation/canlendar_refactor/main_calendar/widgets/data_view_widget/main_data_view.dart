
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/data_view_type_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.cubit,
      builder: (context, state) {
        if (state is CalendarViewState) {
          final typeState = state.typeView;
          switch (typeState) {
            case TypeCalendarList.WEEK:
              return DataViewCalendarWeek(
                cubit: widget.cubit,
              );
              case TypeCalendarList.MONTH:
              return DataViewCalendarMonth(
                cubit: widget.cubit,
              );
            default :
              return DataViewCalendarDay(
                cubit: widget.cubit,
              );
          }
          return DataViewTypeList(
            cubit: widget.cubit,
          );
        } else {
          return DataViewTypeList(
            cubit: widget.cubit,
          );
        }
      },
    );
  }
}
