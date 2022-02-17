import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/select_option_header.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/fake_drawer_lich_hop.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
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
  GlobalKey globalKey = GlobalKey();
  double hegihtCalendar = 120;
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_cua_toi,
        leadingIcon: IconButton(
          onPressed: () {
            setState(() {
              cubit.isCheck = !cubit.isCheck;
            });
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  reverseTransitionDuration: const Duration(milliseconds: 250),
                  transitionDuration: const Duration(milliseconds: 250),
                  pageBuilder: (_, animation, ___) {
                    const begin = Offset(-1.0, 0.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation.drive(tween);
                    return FakeDrawerLichHop(
                      offsetAnimation: offsetAnimation,
                      title1: 'lich theo dang lich',
                      title2: 'lich theo dang list',
                      title3: '',
                      image1: ImageAssets.icMenuCalender,
                      image2: ImageAssets.icMenuCalender,
                      image3: ImageAssets.icMenuCalender,
                      ontap1: () {
                        setState(() {
                          cubit.chooseTypeListLv(
                            Type_Choose_Option_List.DANG_LICH,
                          );
                          cubit.index.sink.add(0);
                          Navigator.pop(context);
                        });
                      },
                      ontap2: () {
                        setState(() {
                          cubit.chooseTypeListLv(
                            Type_Choose_Option_List.DANG_LIST,
                          );
                          cubit.index.sink.add(0);
                          Navigator.pop(context);
                        });
                      },
                      ontap3: () {},
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
      body: Stack(
        children: [
          Column(
            children: [
              BlocBuilder<CalenderCubit, CalenderState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LichLVStateDangLich ||
                      state is LichLVStateDangList) {
                    if (state.type == Type_Choose_Option_Day.MONTH) {
                      return Padding(
                        padding: EdgeInsets.only(top: cubit.isCheck ? 44 : 34),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 16.0,
                              top: cubit.isCheck ? 54 : 32,
                            ),
                            height: 88,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.list.length,
                              itemBuilder: (context, index) {
                                return CustomItemCalenderWork(
                                  image: cubit.img[index],
                                  typeName: cubit.list[index].typeName,
                                  numberOfCalendars:
                                      cubit.list[index].numberOfCalendars,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 16.0,
                            top: cubit.isCheck ? 150 : 120,
                          ),
                          height: 88,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.list.length,
                            itemBuilder: (context, index) {
                              return CustomItemCalenderWork(
                                image: cubit.img[index],
                                typeName: cubit.list[index].typeName,
                                numberOfCalendars:
                                    cubit.list[index].numberOfCalendars,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return state.lichLamViecMobile();
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
                        cubit.chooseTypeCalender(Type_Choose_Option_Day.DAY);
                      },
                      onTapWeek: () {
                        setState(() {});
                        cubit.chooseTypeCalender(Type_Choose_Option_Day.WEEK);
                      },
                      onTapmonth: () {
                        setState(() {});
                        cubit.chooseTypeCalender(Type_Choose_Option_Day.MONTH);
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
                  if (state is LichLVStateDangLich ||
                      state is LichLVStateDangList) {
                    if (state.type == Type_Choose_Option_Day.MONTH) {
                      return const TableCalendarWidget(isCalendar: false);
                    }
                    return const TableCalendarWidget();
                  }
                  return Container();
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
              builder: (context) =>
              const TaoLichLamViecChiTietScreen(),
            ),
          );
        },
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
