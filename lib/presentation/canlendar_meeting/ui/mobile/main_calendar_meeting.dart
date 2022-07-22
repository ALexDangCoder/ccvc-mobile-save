import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/ui/mobile/view_data_meeting.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_calendar_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/chosse_time_calendar_extension.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainCalendarMeeting extends StatefulWidget {
  const MainCalendarMeeting({Key? key}) : super(key: key);

  @override
  _MainCalendarMeetingState createState() => _MainCalendarMeetingState();
}

class _MainCalendarMeetingState extends State<MainCalendarMeeting> {
  final CalendarMeetingCubit cubit = CalendarMeetingCubit();


  @override
  void initState() {
    cubit.initData();
    _handleEventBus();
    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<RefreshCalendar>().listen((event) {
      if (cubit.state is CalendarViewState || cubit.state is ListViewState) {
        cubit.refreshDataDangLich();
      } else {
        cubit.getDataDangChart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        if (cubit.state is CalendarViewState || cubit.state is ListViewState) {
          cubit.refreshDataDangLich();
        } else {
          cubit.getDataDangChart();
        }
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: Scaffold(
        appBar: AppBarWithTwoLeading(
          backGroundColorTablet: bgTabletColor,
          widgetTitle: StreamBuilder<String>(
            stream: cubit.titleStream,
            builder: (context, snapshot) {
              final title = snapshot.data ?? S.current.lich_cua_toi;
              return Text(
                title,
                style: titleAppbar(fontSize: 18.0.textScale(space: 6)),
              );
            },
          ),
          title: S.current.lich_cua_toi,
          leadingIcon: Row(
            children: [
              spaceW16,
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageAssets.svgAssets(ImageAssets.icBack),
                ),
              ),
              spaceW12,
              cubit.controller.getIcon(),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showMenu();
              },
              icon: SvgPicture.asset(ImageAssets.icMenuCalender),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            if (cubit.state is CalendarViewState ||
                cubit.state is ListViewState) {
              cubit.refreshDataDangLich();
            }else {
              cubit.getDataDangChart();
            }
          },
          child: Column(
            children: [
              StreamBuilder<List<DateTime>>(
                  stream: cubit.listNgayCoLichStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <DateTime>[];
                    return ChooseTimeCalendarWidget(
                      calendarDays: data,
                    onChange: (startDate, endDate, type, keySearch) {
                      cubit.handleDatePicked(
                        keySearch: keySearch,
                        endDate: endDate,
                        startDate: startDate,
                      );
                      if (type != cubit.state.typeView) {
                        if (cubit.state is CalendarViewState) {
                          cubit.emitCalendarViewState(type: type);
                          cubit.refreshDataDangLich();
                        } else if (cubit.state is ListViewState) {
                          cubit.emitListViewState(type: type);
                          cubit.refreshDataDangLich();
                        } else {
                          cubit.emitChartViewState(type: type);
                          cubit.getDataDangChart();
                        }
                      } else {
                        if (cubit.state is CalendarViewState ||
                            cubit.state is ListViewState) {
                          cubit.refreshDataDangLich();
                        } else {
                          cubit.getDataDangChart();
                        }
                      }
                    },
                    controller: cubit.controller,
                    onChangeYear: (startDate, endDate, keySearch) {
                      cubit.getDaysHaveEvent(
                        startDate: startDate,
                        endDate: endDate,
                      );
                    },
                  );
                },
              ),
              Expanded(
                child: MouseRegion(
                  onHover: (_) {
                    cubit.controller.onCloseCalendar();
                  },
                  child: ViewDataMeeting(cubit: cubit),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const TaoLichHopScreen(),
              ),
            ).then((value) async {
              if (value == null) {
                return;
              }
              if (cubit.state is CalendarViewState ||
                  cubit.state is ListViewState) {
                cubit.refreshDataDangLich();
              } else {
                cubit.getDataDangChart();
              }
            });
          },
          backgroundColor: AppTheme.getInstance().colorField(),
          child: SvgPicture.asset(ImageAssets.icVectorCalender),
        ),
      ),
    );
  }

  void showMenu() {
    DrawerSlide.navigatorSlide(
      context: context,
      screen: StreamBuilder<List<MenuModel>>(
        stream: cubit.menuDataStream,
        builder: (_, snap) {
          final leaderMenuData = snap.data ?? [];
          return StreamBuilder<DashBoardLichHopModel>(
            stream: cubit.totalWorkStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? DashBoardLichHopModel.empty();
              return MenuWidget(
                isLichHop: true,
                dataMenu: [
                  ParentMenu(
                    count: data.countScheduleCaNhan ?? 0,
                    iconAsset: ImageAssets.icPerson,
                    title: S.current.lich_cua_toi,
                    value: StatusDataItem(StatusWorkCalendar.LICH_CUA_TOI),
                  ),
                  ParentMenu(
                    childData: cubit.getMenuLichTheoTrangThai(data),
                    count: 0,
                    iconAsset: ImageAssets.icLichTheoTrangThai,
                    title: S.current.lich_theo_trang_thai,
                  ),
                  ParentMenu(
                    childData: leaderMenuData
                        .map(
                          (e) => ChildMenu(
                        value: LeaderDataItem(e.id ?? '', e.tenDonVi ?? ''),
                        title: e.tenDonVi ?? '',
                        count: e.count ?? 0,
                      ),
                    )
                        .toList(),
                    count: 0,
                    iconAsset: ImageAssets.icLichLanhDao,
                    title: S.current.lich_theo_lanh_dao,
                  ),
                ],
                stateMenu: [
                  StateMenu(
                    icon: ImageAssets.icTheoDangLich,
                    title: S.current.theo_dang_lich,
                    state: CalendarViewState(typeView: cubit.state.typeView) ,
                  ),
                  StateMenu(
                    icon: ImageAssets.icTheoDangDanhSachGrey,
                    title: S.current.theo_dang_danh_sach,
                    state: ListViewState(typeView: cubit.state.typeView),
                  ),
                  StateMenu(
                    icon: ImageAssets.icTheoDangLich,
                    title: S.current.bao_cao_thong_ke,
                    state: ChartViewState(typeView: cubit.state.typeView),
                  ),
                ],
                onChoose: (value, state) {
                  cubit.handleMenuSelect(
                    itemMenu: value,
                    state: state,
                  );
                },
                state: cubit.state,
              );
            },
          );
        },
      ),
    );
  }
}
