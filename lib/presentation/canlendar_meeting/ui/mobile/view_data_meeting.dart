import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/calendar_chart_tablet.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/canlendar_chart_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_listview/canlendar_meeting_listview.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/dash_board_meeting.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/item_appoinment_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ViewDataMeeting extends StatefulWidget {
  const ViewDataMeeting({
    Key? key,
    required this.cubit,
    this.isTablet = false,
  }) : super(key: key);

  final CalendarMeetingCubit cubit;
  final bool isTablet;

  @override
  State<ViewDataMeeting> createState() => _ViewDataMeetingState();
}

class _ViewDataMeetingState extends State<ViewDataMeeting> {
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
              widget.cubit.propertyChanged(
                property: property,
                typeChoose: Type_Choose_Option_Day.DAY,
              );
            },
            buildAppointment:
                widget.isTablet ? itemAppointmentDayTablet : itemAppointmentDay,
            isTablet: widget.isTablet,
            onMore: (value) {
              widget.cubit.emitListViewState();
            },
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
              widget.cubit.propertyChanged(
                property: property,
                typeChoose: Type_Choose_Option_Day.WEEK,
              );
            },
            data: data,
            isTablet: widget.isTablet,
            fCalendarController: widget.cubit.fCalendarControllerWeek,
            onMore: (value) {
              widget.cubit.controller.calendarType.value = CalendarType.DAY;
              widget.cubit.controller.selectDate.value = value;
              widget.cubit.controller.selectDate.notifyListeners();
            },
          );
        },
      ),
      StreamBuilder<DataSourceFCalendar>(
        stream: widget.cubit.listCalendarWorkMonthStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataSourceFCalendar.empty();
          return DataViewCalendarMonth(
            buildAppointment: itemAppointmentMonth,
            propertyChanged: (String property) {
              widget.cubit.propertyChanged(
                property: property,
                typeChoose: Type_Choose_Option_Day.MONTH,
              );
            },
            data: data,
            isTablet: widget.isTablet,
            fCalendarController: widget.cubit.fCalendarControllerMonth,
            onMore: (value) {
              widget.cubit.controller.calendarType.value = CalendarType.DAY;
              widget.cubit.controller.selectDate.value = value;
              widget.cubit.controller.selectDate.notifyListeners();
            },
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
        BlocBuilder(
          bloc: widget.cubit,
          buildWhen: (prev, state) => prev != state,
          builder: (context, CalendarMeetingState state) {
            return StreamBuilder<StatusWorkCalendar?>(
              stream: widget.cubit.statusWorkSubjectStream,
              initialData: StatusWorkCalendar.LICH_CUA_TOI,
              builder: (context, snapshot) {
                if (widget.cubit.typeCalender ==
                        StatusWorkCalendar.LICH_CUA_TOI ||
                    state is ChartViewState) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DashBroadMeeting(
                      isTablet: widget.isTablet,
                      cubit: widget.cubit,
                      isChartView: widget.cubit.state is ChartViewState,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
        StreamBuilder<StatusWorkCalendar?>(
          stream: widget.cubit.statusWorkSubjectStream,
          builder: (context, snapshot) {
            final isLichDuocMoi =
                snapshot.data == StatusWorkCalendar.LICH_DUOC_MOI;
            if (isLichDuocMoi) {
              return Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: StreamBuilder<DashBoardLichHopModel>(
                    stream: widget.cubit.totalWorkStream,
                    builder: (context, snapshot) {
                      final data =
                          snapshot.data ?? DashBoardLichHopModel.empty();
                      return PopUpMenu(
                        initData: ItemMenuData(
                          StateType.CHO_XAC_NHAN,
                          data.soLichChoXacNhan ?? 0,
                        ),
                        data: [
                          ItemMenuData(
                            StateType.CHO_XAC_NHAN,
                            data.soLichChoXacNhan ?? 0,
                          ),
                          ItemMenuData(
                            StateType.THAM_GIA,
                            data.soLichThamGia ?? 0,
                          ),
                          ItemMenuData(
                            StateType.TU_CHOI,
                            data.soLichTuChoi ?? 0,
                          ),
                        ],
                        onChange: (type) {
                          widget.cubit.stateType = type;
                          widget.cubit.getDanhSachLichHop();
                        },
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Expanded(
          child: BlocBuilder(
            bloc: widget.cubit,
            buildWhen: (prev, state) => prev != state,
            builder: (
              context,
              CalendarMeetingState state,
            ) {
              final typeState = state.typeView;
              int index = 0;
              if (state is CalendarViewState) index = 0;
              if (state is ListViewState) index = 1;
              if (state is ChartViewState) index = 2;
              return IndexedStack(
                index: index,
                children: [
                  IndexedStack(
                    index: typeState.index,
                    children: _listCalendarScreen,
                  ),
                  DataViewTypeList(
                    cubit: widget.cubit,
                    isTablet: widget.isTablet,
                  ),
                  if (widget.isTablet)
                    ThongKeLichHopTablet(
                      cubit: widget.cubit,
                    )
                  else
                    ThongKeLichHopScreen(
                      cubit: widget.cubit,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget itemAppointmentDayTablet(Appointment appointment) {
    final lessThan1Hour = appointment.endTime.millisecondsSinceEpoch -
            appointment.startTime.millisecondsSinceEpoch <
        60 * 60 * 1000;
    return GestureDetector(
      onTap: () {
        pushToDetail(appointment);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: appointment.isAllDay ? 1 : 6,
        ),
        decoration: const BoxDecoration(
          color: textDefault,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Text(
                appointment.subject.trim(),
                maxLines: appointment.isAllDay ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: textNormalCustom(
                  color: Colors.white,
                  fontSize: appointment.isAllDay ? 12 : 16,
                ),
              ),
            ),
            if (!appointment.isAllDay && !lessThan1Hour) spaceH4,
            if (!appointment.isAllDay && !lessThan1Hour)
              Text(
                '${DateFormat.jm('en').format(
                  appointment.startTime,
                )} - ${DateFormat.jm('en').format(
                  appointment.endTime,
                )}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textNormalCustom(
                  fontSize: 16,
                  color: backgroundColorApp.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget itemAppointment(AppointmentWithDuplicate appointment) {
    return GestureDetector(
      onTap: () {
        pushToDetail(appointment);
      },
      child: ItemAppointment(appointment: appointment),
    );
  }

  Widget itemAppointmentDay(AppointmentWithDuplicate appointment) {
    final lessThan1Hour = appointment.endTime.millisecondsSinceEpoch -
            appointment.startTime.millisecondsSinceEpoch <
        60 * 60 * 1000;
    return GestureDetector(
      onTap: () {
        pushToDetail(appointment);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: appointment.isAllDay ? 1 : 6,
            ),
            decoration: const BoxDecoration(
              color: textDefault,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    appointment.subject.trim(),
                    maxLines: appointment.isAllDay ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: textNormalCustom(
                      color: Colors.white,
                      fontSize: appointment.isAllDay ? 11 : 14,
                    ),
                  ),
                ),
                if (!appointment.isAllDay && !lessThan1Hour) spaceH4,
                if (!appointment.isAllDay && !lessThan1Hour)
                  Text(
                    '${DateFormat.jm('en').format(
                      appointment.startTime,
                    )} - ${DateFormat.jm('en').format(
                      appointment.endTime,
                    )}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textNormalCustom(
                      fontSize: 12,
                      color: backgroundColorApp.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  )
              ],
            ),
          ),
          Visibility(
            visible: appointment.isDuplicate,
            child: Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: redChart,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAppointmentMonth(Appointment appointment) {
    final data = appointment as AppointmentWithDuplicate;
    return Align(
      child: GestureDetector(
        onTap: () {
          pushToDetail(data);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          height: 20,
          decoration: const BoxDecoration(
            color: textDefault,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Text(
                  appointment.subject.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textNormalCustom(color: Colors.white, fontSize: 9),
                ),
              ),
              Visibility(
                visible: data.isDuplicate,
                child: Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: redChart,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushToDetail(Appointment appointment) {
    if (isMobile()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMeetCalenderScreen(
            id: appointment.id as String? ?? '',
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMeetCalenderTablet(
            id: appointment.id as String? ?? '',
          ),
        ),
      );
    }
  }
}
