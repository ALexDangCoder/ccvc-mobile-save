import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/select_option_header.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/calender_provider.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/menu/menu_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/menu/menu_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalenderWorkDayMobile extends StatefulWidget {
  const CalenderWorkDayMobile({Key? key}) : super(key: key);

  @override
  _CalenderWorkDayMobileState createState() => _CalenderWorkDayMobileState();
}

class _CalenderWorkDayMobileState extends State<CalenderWorkDayMobile> {
  MenuCalendarCubit cubitMenu = MenuCalendarCubit();
  CalenderCubit cubit = CalenderCubit();
  double hegihtCalendar = 120;

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LICH);
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeCalendarMenu>(
      stream: cubit.changeItemMenuStream,
      builder: (context, snapshot) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          retry: () {},
          textEmpty: S.current.khong_co_du_lieu,
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          child: Scaffold(
            appBar: BaseAppBar(
              title: snapshot.data == TypeCalendarMenu.LichTheoLanhDao
                  ? cubit.titleAppbar
                  : snapshot.data?.getTitle() ??
                      TypeCalendarMenu.LichCuaToi.getTitle(),
              leadingIcon: IconButton(
                onPressed: () {
                  setState(() {});
                  cubit.isCheck = !cubit.isCheck;
                },
                icon: BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return state.lichLamViecIconsMobile();
                  },
                ),
              ),
              actions: [
                BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        DrawerSlide.navigatorSlide(
                          context: context,
                          screen: MenuWidget(
                            isBaoCaoThongKe: false,
                            onTap: (value) {
                              if (value == S.current.theo_dang_lich) {
                                cubit.chooseTypeListLv(
                                  Type_Choose_Option_List.DANG_LICH,
                                );
                                cubit.modeLLV =
                                    Type_Choose_Option_List.DANG_LICH;
                              }

                              if (value == S.current.theo_dang_danh_sach) {
                                cubit.chooseTypeListLv(
                                  Type_Choose_Option_List.DANG_LIST,
                                );
                                cubit.modeLLV =
                                    Type_Choose_Option_List.DANG_LIST;
                              }
                            },
                            listItem: listThongBao,
                            onTapLanhDao: (value) {
                              cubit.titleAppbar = value.tenDonVi ?? '';
                              cubit.idDonViLanhDao = value.id ?? '';
                            },
                            cubit: cubitMenu,
                            streamDashBoard:
                                cubit.lichLamViecDashBroadSubject.stream,
                            title: S.current.lich_lam_viec,
                          ),
                          thenValue: (value) {
                            final data = value as TypeCalendarMenu;
                            cubit.chooseTypeCalender(
                              cubit.stateOptionDay,
                            );
                            cubit.changeScreenMenu(data);
                            if (data == TypeCalendarMenu.LichTheoLanhDao) {}
                            if (state.type == Type_Choose_Option_Day.DAY) {
                              cubit.callApi();
                            } else if (state.type ==
                                Type_Choose_Option_Day.WEEK) {
                              cubit.callApiTuan();
                            } else {
                              cubit.callApiMonth();
                            }
                          },
                        );
                      },
                      icon: SvgPicture.asset(ImageAssets.icMenuCalender),
                    );
                  },
                )
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    if (snapshot.data == TypeCalendarMenu.LichCuaToi)
                      BlocBuilder<CalenderCubit, CalenderState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return state.itemCalendarWork(cubit);
                        },
                      )
                    else
                      BlocBuilder<CalenderCubit, CalenderState>(
                        bloc: cubit,
                        builder: (context, state) {
                          if (state.type == Type_Choose_Option_Day.MONTH &&
                              cubit.selectTypeCalendarSubject.value[0]) {
                            return const SizedBox(
                              height: 150,
                            );
                          } else {
                            return const SizedBox(
                              height: 120,
                            );
                          }
                        },
                      ),
                    if (cubit.isCheck &&
                        cubit.stateOptionDay == Type_Choose_Option_Day.WEEK)
                      const SizedBox(
                        height: 15,
                      )
                    else
                      Container(),
                    Expanded(
                      child: BlocBuilder<CalenderCubit, CalenderState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return state.lichLamViecMobile(cubit, state.type);
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    if (cubit.isCheck)
                      BlocBuilder(
                        bloc: cubit,
                        builder: (context, state) {
                          return SelectOptionHeader(
                            onTapDay: () {
                              setState(() {});
                              cubit.chooseTypeCalender(
                                Type_Choose_Option_Day.DAY,
                              );
                              cubit.stateOptionDay = Type_Choose_Option_Day.DAY;
                              cubit.callApi();
                            },
                            onTapWeek: () {
                              setState(() {});
                              cubit.chooseTypeCalender(
                                Type_Choose_Option_Day.WEEK,
                              );
                              cubit.stateOptionDay =
                                  Type_Choose_Option_Day.WEEK;

                              cubit.callApiTuan();
                            },
                            onTapmonth: () {
                              setState(() {});
                              cubit.chooseTypeCalender(
                                Type_Choose_Option_Day.MONTH,
                              );
                              cubit.stateOptionDay =
                                  Type_Choose_Option_Day.MONTH;

                              cubit.callApiMonth();
                            },
                            cubit: cubit,
                          );
                        },
                      )
                    else
                      Container(),
                    BlocBuilder<CalenderCubit, CalenderState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return state.tableCalendar(
                          cubit: cubit,
                          type: state.type,
                        );
                      },
                    ),
                  ],
                ),
                spaceH16,
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaoLichLamViecChiTietScreen(),
                  ),
                ).then((value) {
                  if (value) {
                    cubit.callApi();
                  }
                });
              },
              backgroundColor: labelColor,
              child: SvgPicture.asset(ImageAssets.icVectorCalender),
            ),
          ),
        );
      },
    );
  }
}

Widget itemCalendarWorkIscheck(CalenderCubit cubit) {
  return Padding(
    padding: EdgeInsets.only(
      top: cubit.isCheck ? 44 : 34,
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, top: 120),
        height: 88,
        child: Row(
          children: [
            StreamBuilder<DashBoardLichHopModel>(
              initialData: DashBoardLichHopModel.empty(),
              stream: cubit.streamLichLamViec,
              builder: (context, snapshot) {
                return CustomItemCalenderWork(
                  image: ImageAssets.icTongSoLichLamviec,
                  typeName: S.current.tong_so_lich_lam_viec,
                  numberOfCalendars: cubit.lichLamViecDashBroadSubject.value
                          .countScheduleCaNhan ??
                      0,
                );
              },
            ),
            StreamBuilder<List<LichLamViecDashBroadItem>>(
              stream: cubit.streamLichLamViecRight,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CustomItemCalenderWork(
                        image: cubit.img[index],
                        typeName: data[index].typeName ?? '',
                        numberOfCalendars: data[index].numberOfCalendars ?? 0,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget itemCalendarWorkDefault(CalenderCubit cubit) {
  return CalenderProvider(
    cubit: cubit,
    child: Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.only(
            left: 16.0,
            top: cubit.isCheck ? 150 : 120,
          ),
          height: 88,
          child: Row(
            children: [
              StreamBuilder<DashBoardLichHopModel>(
                initialData: DashBoardLichHopModel.empty(),
                stream: cubit.streamLichLamViec,
                builder: (context, snapshot) {
                  return CustomItemCalenderWork(
                    image: ImageAssets.icTongSoLichLamviec,
                    typeName: S.current.tong_so_lich_lam_viec,
                    numberOfCalendars: cubit.lichLamViecDashBroadSubject.value
                            .countScheduleCaNhan ??
                        0,
                  );
                },
              ),
              StreamBuilder<List<LichLamViecDashBroadItem>>(
                stream: cubit.streamLichLamViecRight,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  if (data.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CustomItemCalenderWork(
                          image: cubit.img[index],
                          typeName: data[index].typeName ?? '',
                          numberOfCalendars: data[index].numberOfCalendars ?? 0,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
