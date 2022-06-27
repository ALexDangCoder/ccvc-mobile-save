import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/choose_day_week_month.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/menu/menu_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/menu/menu_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'lich_hop_extension.dart';

class MainLichHop extends StatefulWidget {
  const MainLichHop({Key? key}) : super(key: key);

  @override
  _MainLichHopState createState() => _MainLichHopState();
}

class _MainLichHopState extends State<MainLichHop> {
  final CalenderCubit calenderCubit = CalenderCubit();
  LichHopCubit cubit = LichHopCubit();
  final MenuCalendarCubit cubitMenu = MenuCalendarCubit();

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeList(Type_Choose_Option_List.DANG_LICH);
    cubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LichHopCubit, LichHopState>(
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          retry: () {},
          textEmpty: S.current.khong_co_du_lieu,
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.initData();
            },
            child: StreamBuilder<TypeCalendarMenu>(
              stream: cubit.changeItemMenuStream,
              builder: (context, snapshot) {
                final dataChangeScreen =
                    snapshot.data ?? TypeCalendarMenu.LichCuaToi;
                return Scaffold(
                  appBar: AppBarWithTwoLeading(
                    title: snapshot.data == TypeCalendarMenu.LichTheoLanhDao
                        ? cubit.titleAppbar
                        : dataChangeScreen.getTitleLichHop(),
                    leadingIcon: StreamBuilder<bool>(
                        stream: cubit.isListThongKeSubject.stream,
                        builder: (context, snapshot) {
                          final isVisible = snapshot.data ?? false;
                          return isVisible
                              ? Container()
                              : Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImageAssets.icBack,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        cubit.isCheckNgay = !cubit.isCheckNgay;
                                      },
                                      icon: BlocBuilder<LichHopCubit,
                                          LichHopState>(
                                        bloc: cubit,
                                        builder: (context, state) {
                                          return state.lichLamViecIconsMobile();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                        }),
                    actions: [
                      StreamBuilder<bool>(
                          stream: cubit.isListThongKeSubject.stream,
                          builder: (context, snapshot) {
                            final isVisible = snapshot.data ?? false;

                            return IconButton(
                              onPressed: () {
                                DrawerSlide.navigatorSlide(
                                  context: context,
                                  screen: MenuWidget(
                                    visible: isVisible,
                                    onTap: (value) {
                                      if (value == S.current.theo_dang_lich) {
                                        cubit.chooseTypeList(
                                          Type_Choose_Option_List.DANG_LICH,
                                        );
                                        cubit.typeLH =
                                            Type_Choose_Option_List.DANG_LICH;
                                        cubit.isListThongKeSubject.add(false);
                                      }

                                      if (value ==
                                          S.current.theo_dang_danh_sach) {
                                        cubit.chooseTypeList(
                                          Type_Choose_Option_List.DANG_LIST,
                                        );
                                        cubit.typeLH =
                                            Type_Choose_Option_List.DANG_LIST;
                                        cubit.isListThongKeSubject.add(false);
                                      }

                                      if (value == S.current.bao_cao_thong_ke) {
                                        cubit.chooseTypeList(
                                          Type_Choose_Option_List.DANG_THONG_KE,
                                        );
                                        cubit.typeLH = Type_Choose_Option_List
                                            .DANG_THONG_KE;
                                        cubit.isListThongKeSubject.add(false);
                                      }
                                    },
                                    listItem: cubit.dataMenu,
                                    onTapLanhDao: (value) {
                                      cubit.titleAppbar = value.tenDonVi ?? '';
                                      cubit.idDonViLanhDao = value.id ?? '';
                                    },
                                    streamDashBoard:
                                        cubit.dashBoardSubject.stream,
                                    title: S.current.hop,
                                    cubit: cubitMenu,
                                  ),
                                  thenValue: (value) {
                                    final data = value as TypeCalendarMenu;
                                    cubit.chooseTypeDay(
                                      cubit.stateOptionDay,
                                    );
                                    cubit.changeScreenMenu(data);
                                    if (data ==
                                        TypeCalendarMenu.LichTheoLanhDao) {}
                                    if (state.type ==
                                        Type_Choose_Option_Day.DAY) {
                                      cubit.postDSLHDay();
                                    } else if (state.type ==
                                        Type_Choose_Option_Day.WEEK) {
                                      cubit.postDSLHWeek();
                                    } else {
                                      cubit.postDSLHMonth();
                                    }
                                  },
                                );
                              },
                              icon:
                                  SvgPicture.asset(ImageAssets.icMenuCalender),
                            );
                          })
                    ],
                  ),
                  body: Container(
                    color: backgroundColorApp,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<bool>(
                              stream: cubit.isListThongKeSubject.stream,
                              builder: (context, snapshot) {
                                final isVisible = snapshot.data ?? false;
                                return BlocBuilder<LichHopCubit, LichHopState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state is LichHopStateDangDanhSach) {
                                      if (state.type ==
                                              Type_Choose_Option_Day.DAY ||
                                          state.type ==
                                              Type_Choose_Option_Day.WEEK) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: cubit.isCheckNgay ? 150 : 120,
                                          ),
                                          color: Colors.transparent,
                                        );
                                      } else {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: cubit.isCheckNgay ? 80 : 50,
                                          ),
                                          color: Colors.transparent,
                                        );
                                      }
                                    } else if (state.type ==
                                        Type_Choose_Option_Day.MONTH) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        child: state is LichHopStateDangThongKe
                                            ? StreamBuilder<
                                                List<DashBoardThongKeModel>>(
                                                stream: cubit
                                                    .listDashBoardThongKe
                                                    .stream,
                                                builder: (context, snapshot) {
                                                  final data =
                                                      snapshot.data ?? [];
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                      left: 16.0,
                                                      top: cubit.isCheckNgay
                                                          ? 150
                                                          : 120,
                                                    ),
                                                    height: 88,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CustomItemCalenderWork(
                                                          image: cubit
                                                                  .listImageLichHopThongKe[
                                                              index],
                                                          typeName: data[index]
                                                                  .name ??
                                                              '',
                                                          numberOfCalendars: data[
                                                                      index]
                                                                  .quantities ??
                                                              0,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              )
                                            : isVisible
                                                ? Container()
                                                : StreamBuilder<
                                                    DashBoardLichHopModel>(
                                                    stream:
                                                        cubit.dashBoardStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 16.0,
                                                            top: cubit
                                                                    .isCheckNgay
                                                                ? 150
                                                                : 120,
                                                          ),
                                                          height: 88,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                listItemSchedule
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return CustomItemCalenderWork(
                                                                image: cubit
                                                                        .listImageLichHopCuaToi[
                                                                    index],
                                                                typeName:
                                                                    listItemSchedule[
                                                                            index]
                                                                        .typeName,
                                                                numberOfCalendars:
                                                                    listItemSchedule[
                                                                            index]
                                                                        .numberOfSchedule,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16.0,
                                        ),
                                        child: state is LichHopStateDangThongKe
                                            ? StreamBuilder<
                                                List<DashBoardThongKeModel>>(
                                                stream: cubit
                                                    .listDashBoardThongKe
                                                    .stream,
                                                builder: (context, snapshot) {
                                                  final data =
                                                      snapshot.data ?? [];
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                      left: 16.0,
                                                      top: cubit.isCheckNgay
                                                          ? 150
                                                          : 120,
                                                    ),
                                                    height: 88,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CustomItemCalenderWork(
                                                          image: cubit
                                                                  .listImageLichHopThongKe[
                                                              index],
                                                          typeName: data[index]
                                                                  .name ??
                                                              '',
                                                          numberOfCalendars: data[
                                                                      index]
                                                                  .quantities ??
                                                              0,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              )
                                            : isVisible
                                                ? Container()
                                                : StreamBuilder<
                                                    DashBoardLichHopModel>(
                                                    stream:
                                                        cubit.dashBoardStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 16.0,
                                                            top: cubit
                                                                    .isCheckNgay
                                                                ? 150
                                                                : 120,
                                                          ),
                                                          height: 88,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                listItemSchedule
                                                                    .length,
                                                            itemBuilder: (
                                                              context,
                                                              index,
                                                            ) {
                                                              return CustomItemCalenderWork(
                                                                image: cubit
                                                                        .listImageLichHopCuaToi[
                                                                    index],
                                                                typeName:
                                                                    listItemSchedule[
                                                                            index]
                                                                        .typeName,
                                                                numberOfCalendars:
                                                                    listItemSchedule[
                                                                            index]
                                                                        .numberOfSchedule,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            StreamBuilder<bool>(
                                stream: cubit.isListThongKeSubject.stream,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: (snapshot.data ??
                                            true &&
                                                cubit.typeLH !=
                                                    Type_Choose_Option_List
                                                        .DANG_THONG_KE)
                                        ? 160
                                        : 16,
                                  );
                                }),
                            Expanded(
                              child: BlocBuilder<LichHopCubit, LichHopState>(
                                bloc: cubit,
                                builder: (context, state) {
                                  return state.lichHop(
                                    cubit: cubit,
                                    type: state.type,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (cubit.isCheckNgay)
                              BlocBuilder(
                                bloc: cubit,
                                builder: (context, state) {
                                  return ChooseDayWeedMonth(
                                    cubit: cubit,
                                    onTapDay: () {
                                      setState(() {});
                                      cubit.chooseTypeDay(
                                        Type_Choose_Option_Day.DAY,
                                      );
                                      cubit.stateOptionDay =
                                          Type_Choose_Option_Day.DAY;

                                      cubit.postDSLHDay();
                                    },
                                    onTapWeek: () {
                                      setState(() {});
                                      cubit.chooseTypeDay(
                                        Type_Choose_Option_Day.WEEK,
                                      );
                                      cubit.stateOptionDay =
                                          Type_Choose_Option_Day.WEEK;

                                      cubit.postDSLHWeek();
                                    },
                                    onTapmonth: () {
                                      setState(() {});
                                      cubit.chooseTypeDay(
                                        Type_Choose_Option_Day.MONTH,
                                      );
                                      cubit.stateOptionDay =
                                          Type_Choose_Option_Day.MONTH;

                                      cubit.postDSLHMonth();
                                    },
                                  );
                                },
                              )
                            else
                              const SizedBox(),
                            BlocBuilder<LichHopCubit, LichHopState>(
                              bloc: cubit,
                              builder: (context, state) {
                                if (state is LichHopStateDangLich ||
                                    state is LichHopStateDangList ||
                                    state is LichHopStateDangThongKe ||
                                    state is LichHopStateDangDanhSach) {
                                  return StreamBuilder<List<DateTime>>(
                                    stream: cubit.eventsStream,
                                    builder: (context, snapshot) {
                                      return TableCalendarWidget(
                                        type: state.type,
                                        eventsLoader: snapshot.data,
                                        onChange: (
                                          DateTime startDate,
                                          DateTime endDate,
                                          DateTime selectDay,
                                        ) {
                                          cubit.getDataCalendar(
                                            startDate,
                                            endDate,
                                            selectDay,
                                            state.type,
                                          );
                                        },
                                        onChangeRange: (
                                          DateTime? start,
                                          DateTime? end,
                                          DateTime? focusedDay,
                                        ) {},
                                        onChangeText: (String? value) {
                                          cubit.searchLichHop(value);
                                        },
                                      );
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: state is LichHopStateDangThongKe
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: FloatingActionButton(
                            elevation: 0.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      const TaoLichHopScreen(),
                                ),
                              ).then((value) async {
                                if(value == null){
                                  return;
                                }
                                if(value){
                                  await cubit.initData();
                                }
                              });
                            },
                            backgroundColor:
                                AppTheme.getInstance().colorField(),
                            child: SvgPicture.asset(
                              ImageAssets.icAddCalenderWhite,
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
