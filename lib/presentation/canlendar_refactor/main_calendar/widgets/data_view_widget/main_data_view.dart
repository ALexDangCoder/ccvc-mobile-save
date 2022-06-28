import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';


import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/dashbroad_count_row.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/item_appoinment_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/data_view_type_list.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
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
        stream: widget.cubit.listCalendarWorkDayStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? DataSourceFCalendar.empty();
          return DataViewCalendarDay(
            data: data,
            fCalendarController: widget.cubit.fCalendarControllerDay,
            propertyChanged: (String property) {
              widget.cubit.propertyChangedDay(property);
            },
            onMore: (value) {
              widget.cubit.emitList();
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
              widget.cubit.propertyChangedWeek(property);
            },
            onMore: (value) {
              widget.cubit.controller.calendarType.value = CalendarType.DAY;
              widget.cubit.controller.selectDate.value = value;
              widget.cubit.controller.selectDate.notifyListeners();
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
              buildAppointment: itemAppointmentMonth,
              propertyChanged: (String property) {
                widget.cubit.propertyChangedMonth(property);
              },
              onMore: (value) {
                widget.cubit.controller.calendarType.value = CalendarType.DAY;
                widget.cubit.controller.selectDate.value = value;
                widget.cubit.controller.selectDate.notifyListeners();
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
        StreamBuilder<StatusWorkCalendar?>(
          stream: widget.cubit.statusWorkSubjectStream,
          builder: (context, snapshot) {
            final isLichCuaToi =
                snapshot.data == StatusWorkCalendar.LICH_CUA_TOI;
            if (isLichCuaToi) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DashBroadCountRow(
                  cubit: widget.cubit,
                ),
              );
            }
            return const SizedBox.shrink();
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
                          widget.cubit.updateList();
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

  Widget itemAppointmentMonth(Appointment appointment) {
    final data = appointment as AppointmentWithDuplicate;
    return Align(
      child: GestureDetector(
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
                        color: redChart, shape: BoxShape.circle),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemAppointment(Appointment appointment) {
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
      child: ItemAppointment(appointment: appointment),
    );
  }
}
