import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/calendar_work_menu_phone.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/select_option_header.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/calender_provider.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
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
                IconButton(
                  onPressed: () {
                    DrawerSlide.navigatorSlide(
                      context: context,
                      screen: CalendarWorkMenu(
                        cubit: cubit,
                      ),
                    );
                  },
                  icon: SvgPicture.asset(ImageAssets.icMenuCalender),
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
                              height: 70,
                            );
                          } else {
                            return const SizedBox(
                              height: 120,
                            );
                          }
                        },
                      ),
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
                              cubit.listDSLV.clear();
                              cubit.page = 1;
                              cubit.callApi();
                            },
                            onTapWeek: () {
                              setState(() {});
                              cubit.chooseTypeCalender(
                                Type_Choose_Option_Day.WEEK,
                              );
                              cubit.listDSLV.clear();
                              cubit.page = 1;
                              cubit.callApiTuan();
                            },
                            onTapmonth: () {
                              setState(() {});
                              cubit.chooseTypeCalender(
                                Type_Choose_Option_Day.MONTH,
                              );
                              cubit.listDSLV.clear();
                              cubit.page = 1;
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
        margin: EdgeInsets.only(
          left: 16.0,
          top: cubit.isCheck ? 54 : 32,
        ),
        height: 88,
        child: Row(
          children: [
            StreamBuilder<LichLamViecDashBroad>(
              initialData: LichLamViecDashBroad.empty(),
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
              StreamBuilder<LichLamViecDashBroad>(
                initialData: LichLamViecDashBroad.empty(),
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
