import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/widget/wisget_choose_day_week_month.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet.dart';
import 'package:ccvc_mobile/widgets/menu/menu_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/menu/menu_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainLichHopTabLet extends StatefulWidget {
  const MainLichHopTabLet({Key? key}) : super(key: key);

  @override
  _MainLichHopTabLetState createState() => _MainLichHopTabLetState();
}

class _MainLichHopTabLetState extends State<MainLichHopTabLet> {
  LichHopCubit cubit = LichHopCubit();
  final MenuCalendarCubit cubitMenu = MenuCalendarCubit();

  @override
  void dispose() {
    super.dispose();
  }

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
          child: StreamBuilder<TypeCalendarMenu>(
            stream: cubit.changeItemMenuStream,
            builder: (context, snapshot) {
              final dataChangeScreen =
                  snapshot.data ?? TypeCalendarMenu.LichCuaToi;
              return Scaffold(
                appBar: BaseAppBar(
                  backGroundColor: state is LichHopStateDangThongKe
                      ? colorF5F8FD
                      : colorF9FAFF,
                  title: snapshot.data == TypeCalendarMenu.LichTheoLanhDao
                      ? cubit.titleAppbar
                      : dataChangeScreen.getTitleLichHop(),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuWidget(
                                cubit: cubitMenu,
                                onTap: (value) {
                                  if (value == S.current.theo_dang_lich) {
                                    cubit.chooseTypeList(
                                      Type_Choose_Option_List.DANG_LICH,
                                    );
                                    cubit.typeLH =
                                        Type_Choose_Option_List.DANG_LICH;
                                    cubit.isListThongKeSubject.add(true);
                                  }

                                  if (value == S.current.theo_dang_danh_sach) {
                                    cubit.chooseTypeList(
                                      Type_Choose_Option_List.DANG_LIST,
                                    );
                                    cubit.typeLH =
                                        Type_Choose_Option_List.DANG_LIST;
                                    cubit.isListThongKeSubject.add(true);
                                  }

                                  if (value == S.current.bao_cao_thong_ke) {
                                    cubit.chooseTypeList(
                                      Type_Choose_Option_List.DANG_THONG_KE,
                                    );
                                    cubit.typeLH =
                                        Type_Choose_Option_List.DANG_THONG_KE;
                                    cubit.isListThongKeSubject.add(false);
                                  }

                                  cubit.index.sink.add(0);
                                },
                                listItem: cubit.dataMenu,
                                onTapLanhDao: (value) {
                                  cubit.titleAppbar = value.tenDonVi ?? '';
                                  cubit.idDonViLanhDao = value.id ?? '';
                                },
                                streamDashBoard: cubit.dashBoardSubject.stream,
                                title: S.current.hop,
                              ),
                            ),
                          ).then((value) {
                            final data = value as TypeCalendarMenu;
                            cubit.chooseTypeDay(
                              cubit.stateOptionDay,
                            );
                            cubit.changeScreenMenu(data);
                            if (data == TypeCalendarMenu.LichTheoLanhDao) {}
                            if (state.type == Type_Choose_Option_Day.DAY) {
                              cubit.postDSLHDay();
                            } else if (state.type ==
                                Type_Choose_Option_Day.WEEK) {
                              cubit.postDSLHWeek();
                            } else {
                              cubit.postDSLHMonth();
                            }
                          });
                        },
                        icon: SvgPicture.asset(
                          ImageAssets.icMenuLichHopTablet,
                        ),
                      ),
                    ),
                  ],
                  leadingIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      ImageAssets.icBack,
                    ),
                  ),
                ),
                body: Container(
                  color: state is LichHopStateDangThongKe
                      ? colorE5E5E5
                      : colorFFFFFF,
                  child: Column(
                    children: [
                      WidgetChooseDayWeekMonth(
                        cubit: cubit,
                        createMeeting: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const TaoLichHopScreen(),
                            ),
                          );
                        },
                        onTapDay: () {
                          setState(() {});
                          cubit.chooseTypeDay(Type_Choose_Option_Day.DAY);
                          cubit.stateOptionDay = Type_Choose_Option_Day.DAY;

                          cubit.postDSLHDay();
                        },
                        onTapWeek: () {
                          setState(() {});
                          cubit.chooseTypeDay(Type_Choose_Option_Day.WEEK);
                          cubit.stateOptionDay = Type_Choose_Option_Day.WEEK;

                          cubit.postDSLHWeek();
                        },
                        onTapMonth: () {
                          setState(() {});
                          cubit.chooseTypeDay(Type_Choose_Option_Day.MONTH);
                          cubit.stateOptionDay = Type_Choose_Option_Day.MONTH;

                          cubit.postDSLHMonth();
                        }, onChangeText: (String? value) {
                          cubit.searchLichHop(value);
                      },
                      ),
                      BlocBuilder<LichHopCubit, LichHopState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return StreamBuilder<List<DateTime>>(
                            stream: cubit.eventsStream,
                            builder: (context, snapshot) {
                              return TableCandarTablet(
                                type: state.type,
                                eventsLoader: snapshot.data,
                                onChangeRange: (
                                  DateTime? start,
                                  DateTime? end,
                                  DateTime? focusedDay,
                                ) {},
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
                              );
                            },
                          );
                        },
                      ),
                      StreamBuilder<bool>(
                        stream: cubit.isListThongKeSubject.stream,
                        builder: (context, snapshot) {
                          final isVisible = snapshot.data ?? true;
                          return BlocBuilder<LichHopCubit, LichHopState>(
                            bloc: cubit,
                            builder: (context, state) {
                              if (state is LichHopStateDangDanhSach) {
                                return const SizedBox();
                              } else {
                                if (state is LichHopStateDangThongKe) {
                                  return StreamBuilder<
                                      List<DashBoardThongKeModel>>(
                                    stream: cubit.listDashBoardThongKe.stream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data ?? [];

                                      return Container(
                                        margin: const EdgeInsets.only(
                                          left: 30.0,
                                          top: 15,
                                        ),
                                        height: 116,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data.length,
                                          itemBuilder: (context, index) {
                                            return CustomItemCalenderWorkTablet(
                                              image:
                                                  cubit.listImageLichHopThongKe[
                                                      index],
                                              typeName: data[index].name ?? '',
                                              numberOfCalendars:
                                                  data[index].quantities ?? 0,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return isVisible
                                      ? StreamBuilder<DashBoardLichHopModel>(
                                          stream: cubit.dashBoardStream,
                                          builder: (context, snapshot) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  left: 30.0),
                                              height: 116,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    listItemSchedule.length,
                                                itemBuilder: (context, index) {
                                                  return CustomItemCalenderWorkTablet(
                                                    image: cubit
                                                            .listImageLichHopCuaToi[
                                                        index],
                                                    typeName:
                                                        listItemSchedule[index]
                                                            .typeName,
                                                    numberOfCalendars:
                                                        listItemSchedule[index]
                                                            .numberOfSchedule,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        )
                                      : Container();
                                }
                              }
                            },
                          );
                        },
                      ),
                      BlocBuilder<LichHopCubit, LichHopState>(
                        bloc: cubit,
                        builder: (context, state) {
                          if (state is LichHopStateDangDanhSach) {
                            return const SizedBox();
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 30.0,
                                right: 30,
                                top: 28,
                                bottom:
                                    state is LichHopStateDangThongKe ? 0 : 28,
                              ),
                              child: Container(
                                height: 1,
                                color: colorE2E8F0,
                              ),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: BlocBuilder<LichHopCubit, LichHopState>(
                          bloc: cubit,
                          builder: (context, state) {
                            return state.lichHopTablet(cubit, state.type);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
