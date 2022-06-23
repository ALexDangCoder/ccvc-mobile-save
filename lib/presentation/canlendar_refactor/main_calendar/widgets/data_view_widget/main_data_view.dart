import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/dashbroad_count_row.dart';
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
        // DashBroadCountRow(
        //   cubit: widget.cubit,
        // ),
        Expanded(
          child: BlocBuilder(
            bloc: widget.cubit,
            builder: (context, CalendarWorkState state) {
              final typeState = state.typeView;
              return IndexedStack(
                index: state is CalendarViewState ? 0 : 1,
                children: [
                  IndexedStack(
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
                  ),
                  DataViewTypeList(
                    cubit: widget.cubit,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
