import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
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
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/item_appoinment_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/item_appoinment_month.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/item_appoinment_week.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/appointment_engine/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            buildAppointment: (e) => ItemAppointmentDay(
              appointment: e,
              onClick: () {
                pushToDetail(e);
              },
            ),
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
            buildAppointment:  (e) => ItemAppointmentWeek(
              appointment: e,
              onClick: () {
                pushToDetail(e);
              },
            ),
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
              widget.cubit.emitListViewState();
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
            buildAppointment:  (e) => ItemAppointmentMonth(
              appointment: e,
              onClick: () {
                pushToDetail(e);
              },
            ),
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
              widget.cubit.emitListViewState();
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
        BlocBuilder(
          bloc: widget.cubit,
          buildWhen: (prev, state) => state is ChartViewState && prev != state,
          builder: (context, state) {
            return StreamBuilder<StatusWorkCalendar?>(
              stream: widget.cubit.statusWorkSubjectStream,
              builder: (context, snapshot) {
                final typeCalendar =
                    snapshot.data ?? StatusWorkCalendar.LICH_CUA_TOI;
                return Align(
                  alignment: Alignment.centerRight,
                  child: StreamBuilder<DashBoardLichHopModel>(
                    stream: widget.cubit.totalWorkStream,
                    builder: (context, snapshot) {
                      final data =
                          snapshot.data ?? DashBoardLichHopModel.empty();
                      return getActionMenu(
                        typeCalendar: typeCalendar,
                        data: data,
                      );
                    },
                  ),
                );
              },
            );
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
                    index: typeState == CalendarType.YEAR? 0: typeState.index,
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


  void pushToDetail(Appointment appointment) {
    if (isMobile()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMeetCalenderScreen(
            id: appointment.id as String? ?? '',
          ),
        ),
      ).then((value) {
        if (value != null && value) {
          widget.cubit.refreshDataDangLich();
        }
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMeetCalenderTablet(
            id: appointment.id as String? ?? '',
          ),
        ),
      ).then((value) {
        if (value != null && value) {
          widget.cubit.refreshDataDangLich();
        }
      });
    }
  }

  Widget getActionMenu({
    required StatusWorkCalendar typeCalendar,
    required DashBoardLichHopModel data,
  }) {
    if (widget.cubit.state is ChartViewState) {
      return const SizedBox.shrink();
    }
    final List<int> listCount = [];
    switch (typeCalendar) {
      case StatusWorkCalendar.CHO_DUYET:
        listCount.add(data.soLichCanChuTriDuyetCho ?? 0);
        listCount.add(data.soLichChuTriDaDuyet ?? 0);
        listCount.add(data.soLichChuTriTuChoi ?? 0);
        break;
      case StatusWorkCalendar.LICH_DUYET_PHONG:
        listCount.add(data.soLichDuyetPhongCho ?? 0);
        listCount.add(data.soLichDuyetPhongXacNhan ?? 0);
        listCount.add(data.soLichDuyetPhongTuChoi ?? 0);
        break;
      case StatusWorkCalendar.LICH_DUYET_THIET_BI:
        listCount.add(data.soLichDuyetThietBiCho ?? 0);
        listCount.add(data.soLichDuyetThietBiXacNhan ?? 0);
        listCount.add(data.soLichDuyetThietBiTuChoi ?? 0);
        break;
      case StatusWorkCalendar.LICH_DUYET_KY_THUAT:
        listCount.add(data.soLichChoDuyetKyThuat ?? 0);
        listCount.add(data.soLichDaDuyetKyThuat ?? 0);
        listCount.add(data.soLichTuChoiDuyetKyThuat ?? 0);
        break;
      case StatusWorkCalendar.LICH_DA_KLCH:
        listCount.add(data.soLichCoBaoCaoChoDuyet ?? 0);
        listCount.add(data.soLichCoBaoCaoDaDuyet ?? 0);
        listCount.add(data.soLichCoBaoCaoTuChoi ?? 0);
        break;
      case StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI:
        listCount.add(data.soLichChuaThucHienYC ?? 0);
        listCount.add(data.soLichDaThucHienYC ?? 0);
        break;
      default:
        break;
    }

    if (typeCalendar == StatusWorkCalendar.LICH_DUOC_MOI) {
      return actionLichDuocMoi(data);
    } else if (typeCalendar == StatusWorkCalendar.CHO_DUYET ||
        typeCalendar == StatusWorkCalendar.LICH_DUYET_PHONG ||
        typeCalendar == StatusWorkCalendar.LICH_DUYET_THIET_BI ||
        typeCalendar == StatusWorkCalendar.LICH_DUYET_KY_THUAT ||
        typeCalendar == StatusWorkCalendar.LICH_DA_KLCH) {
      return actionLichCanDuyet(listCount);
    } else if (typeCalendar == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI) {
      return actionDuyetYeuCauChuanBi(listCount);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget actionLichDuocMoi(DashBoardLichHopModel data) {
    final itemData = [
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
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: PopUpMenu(
        initData: itemData.firstWhere(
          (element) => element.type == widget.cubit.stateType,
          orElse: () => itemData.first,
        ),
        data: itemData,
        onChange: (type) {
          widget.cubit.stateType = type;
          widget.cubit.getDanhSachLichHop();
        },
      ),
    );
  }

  Widget actionLichCanDuyet(List<int> listCount) {
    final itemData  = [
      ItemMenuData(
        StateType.CHO_DUYET,
        listCount.isNotEmpty ? listCount.first : 0,
      ),
      ItemMenuData(
        StateType.DA_DUYET,
        listCount.length >= 2 ? listCount[1] : 0,
      ),
      ItemMenuData(
        StateType.TU_CHOI,
        listCount.length >= 3 ? listCount[2] : 0,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: PopUpMenu(
        initData: itemData.firstWhere(
              (element) => element.type == widget.cubit.stateType,
          orElse: () => itemData.first,
        ),
        data: itemData,
        onChange: (type) {
          widget.cubit.stateType = type;
          widget.cubit.getDanhSachLichHop();
        },
      ),
    );
  }

  Widget actionDuyetYeuCauChuanBi(List<int> listCount) {
    final itemData = [
      ItemMenuData(
        StateType.CHUA_THUC_HIEN,
        listCount.isNotEmpty ? listCount.first : 0,
      ),
      ItemMenuData(
        StateType.DA_THUC_HIEN,
        listCount.length >= 2 ? listCount[1] : 0,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: PopUpMenu(
        initData: itemData.firstWhere(
              (element) => element.type == widget.cubit.stateType,
          orElse: () => itemData.first,
        ),
        data: itemData,
        onChange: (type) {
          widget.cubit.stateType = type;
          widget.cubit.getDanhSachLichHop();
        },
      ),
    );
  }
}
