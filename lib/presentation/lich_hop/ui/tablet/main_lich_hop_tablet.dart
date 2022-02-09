import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/widget/wisget_choose_day_week_month.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/fake_drawer_lich_hop.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
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

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeList(Type_Choose_Option_List.DANG_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_hop_cua_toi,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
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
                      return FakeDrawerLichHop(
                        offsetAnimation: offsetAnimation,
                        title1: 'lich theo dang lich',
                        title2: 'lich theo dang list',
                        title3: 'lich theo danh sach',
                        image1: ImageAssets.icMenuCalender,
                        image2: ImageAssets.icMenuCalender,
                        image3: ImageAssets.icMenuCalender,
                        ontap1: () {
                          setState(() {
                            cubit.chooseTypeList(
                              Type_Choose_Option_List.DANG_LICH,
                            );
                            cubit.index.sink.add(0);
                            Navigator.pop(context);
                          });
                        },
                        ontap2: () {
                          setState(() {
                            cubit.chooseTypeList(
                              Type_Choose_Option_List.DANG_LIST,
                            );
                            cubit.index.sink.add(0);
                            Navigator.pop(context);
                          });
                        },
                        ontap3: () {
                          setState(() {
                            cubit.chooseTypeList(
                              Type_Choose_Option_List.DANH_SACH,
                            );
                            cubit.index.sink.add(0);
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                    opaque: false,
                  ),
                );
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
        color: backgroundColorApp,
        child: Column(
          children: [
            WidgetChooseDayWeekMonth(
              cubit: cubit,
              createMeeting: () {},
              onTapDay: () {
                setState(() {});
                cubit.chooseTypeDay(Type_Choose_Option_Day.DAY);
              },
              onTapWeek: () {
                setState(() {});
                cubit.chooseTypeDay(Type_Choose_Option_Day.WEEK);
              },
              onTapMonth: () {
                setState(() {});
                cubit.chooseTypeDay(Type_Choose_Option_Day.MONTH);
              },
            ),
            BlocBuilder<LichHopCubit, LichHopState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LichHopStateDangDanhSach) {
                    return const SizedBox();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        height: 116,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: listItemSchedule.length,
                          itemBuilder: (context, index) {
                            return CustomItemCalenderWorkTablet(
                              image: cubit.listImageLichHopCuaToi[index],
                              typeName: listItemSchedule[index].typeName,
                              numberOfCalendars:
                                  listItemSchedule[index].numberOfSchedule,
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
            BlocBuilder<LichHopCubit, LichHopState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LichHopStateDangDanhSach) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 28.0,
                      ),
                      child: Container(
                        height: 1,
                        color: bgDropDown,
                      ),
                    );
                  }
                }),
            Expanded(
              child: BlocBuilder<LichHopCubit, LichHopState>(
                bloc: cubit,
                builder: (context, state) {
                  return state.lichHopTablet();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
