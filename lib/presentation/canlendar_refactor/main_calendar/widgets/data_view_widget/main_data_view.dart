import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
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
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.cubit.setFCalendarListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.cubit,
      builder: (context, CalendarWorkState state) {
        final typeState = state.typeView;
        if (state is CalendarViewState) {
          return IndexedStack(
            index: typeState.index,
            children: [
              DataViewCalendarDay(
                cubit: widget.cubit,
              ),
              DataViewCalendarWeek(
                cubit: widget.cubit,
              ),
              DataViewCalendarMonth(
                cubit: widget.cubit,
              )
            ],
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
