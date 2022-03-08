import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/calendar_work_menu_phone.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/choose_day_week_month.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
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

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeList(Type_Choose_Option_List.DANG_LIST);
    cubit.page = 1;
    cubit.getDashboard();
    cubit.postDanhSachLichHop();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: cubit.stateStream,
      retry: () {},
      textEmpty: S.current.khong_co_du_lieu,
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      child: Scaffold(
        appBar: AppBarWithTwoLeading(
          title: S.current.lich_hop_cua_toi,
          leadingIcon: Row(
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
                icon: BlocBuilder<LichHopCubit, LichHopState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return state.lichLamViecIconsMobile();
                  },
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    reverseTransitionDuration:
                        const Duration(milliseconds: 250),
                    transitionDuration: const Duration(milliseconds: 250),
                    pageBuilder: (_, animation, ___) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);
                      return CalendarWorkMenu(
                        cubit: calenderCubit,
                      );
                    },
                    opaque: false,
                  ),
                );
              },
              icon: SvgPicture.asset(ImageAssets.icMenuCalender),
            )
          ],
        ),
        body: Container(
          color: backgroundColorApp,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<LichHopCubit, LichHopState>(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is LichHopStateDangDanhSach) {
                        if (state.type == Type_Choose_Option_Day.DAY ||
                            state.type == Type_Choose_Option_Day.WEEK) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: cubit.isCheckNgay ? 150 : 120),
                            color: Colors.transparent,
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(
                                top: cubit.isCheckNgay ? 80 : 50),
                            color: Colors.transparent,
                          );
                        }
                      } else if (state.type == Type_Choose_Option_Day.MONTH) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: StreamBuilder<DashBoardLichHopModel>(
                            stream: cubit.dashBoardStream,
                            builder: (context, snapshot) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 16.0,
                                    top: cubit.isCheckNgay ? 82 : 50,
                                  ),
                                  height: 88,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listItemSchedule.length,
                                    itemBuilder: (context, index) {
                                      return CustomItemCalenderWork(
                                        image:
                                            cubit.listImageLichHopCuaToi[index],
                                        typeName:
                                            listItemSchedule[index].typeName,
                                        numberOfCalendars:
                                            listItemSchedule[index]
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
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: StreamBuilder<DashBoardLichHopModel>(
                            stream: cubit.dashBoardStream,
                            builder: (context, snapshot) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 16.0,
                                    top: cubit.isCheckNgay ? 150 : 120,
                                  ),
                                  height: 88,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listItemSchedule.length,
                                    itemBuilder: (context, index) {
                                      return CustomItemCalenderWork(
                                        image:
                                            cubit.listImageLichHopCuaToi[index],
                                        typeName:
                                            listItemSchedule[index].typeName,
                                        numberOfCalendars:
                                            listItemSchedule[index]
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
                  ),
                  Expanded(
                    child: BlocBuilder<LichHopCubit, LichHopState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return state.lichHop(cubit: cubit);
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
                            cubit.chooseTypeDay(Type_Choose_Option_Day.DAY);
                          },
                          onTapWeek: () {
                            setState(() {});
                            cubit.chooseTypeDay(Type_Choose_Option_Day.WEEK);
                            cubit.postDanhSachLichHop();
                          },
                          onTapmonth: () {
                            setState(() {});
                            cubit.chooseTypeDay(Type_Choose_Option_Day.MONTH);
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
                          state is LichHopStateDangDanhSach) {
                        if (state.type == Type_Choose_Option_Day.MONTH) {
                          return TableCalendarWidget(
                            isCalendar: false,
                            onChange:
                                (DateTime startDate, DateTime endDate) {
                              cubit.startDate = startDate;
                              cubit.endDate = endDate;
                              cubit.getDashboard();

                              cubit.postDanhSachLichHop();
                            },
                            onChangeRange: (
                              DateTime? start,
                              DateTime? end,
                              DateTime? focusedDay,
                            ) {},
                          );
                        }
                        return TableCalendarWidget(
                          onChange:
                              (DateTime startDate, DateTime endDate) {
                            cubit.startDate = startDate;
                            cubit.endDate = endDate;

                            cubit.postDanhSachLichHop();
                            cubit.getDashboard();
                          },
                          onChangeRange: (DateTime? start, DateTime? end,
                              DateTime? focusedDay) {},
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
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const TaoLichHopScreen(),
                ),
              );
            },
            backgroundColor: labelColor,
            child: SvgPicture.asset(ImageAssets.icAddCalenderWhite),
          ),
        ),
      ),
    );
  }
}
