import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/widget/wisget_choose_day_week_month.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/menu_my_calendar/calendar_work_menu_tablet.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
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
  final CalenderCubit calenderCubit = CalenderCubit();
  LichHopCubit cubit = LichHopCubit();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cubit.page = 1;
    cubit.chooseTypeList(Type_Choose_Option_List.DANG_LIST);
    cubit.getDashboard();
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
        appBar: BaseAppBar(
          title: S.current.lich_hop_cua_toi,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  DrawerSlide.navigatorSlide(
                    context: context,
                    screen: MyCalendarMenuTablet(
                      cubit: calenderCubit,
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
                createMeeting: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const TaoLichHopScreen(),
                    ),
                  );
                },
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
                  return TableCandarTablet(
                    type: state.type,
                  );
                },
              ),
              BlocBuilder<LichHopCubit, LichHopState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LichHopStateDangDanhSach) {
                    return const SizedBox();
                  } else {
                    return StreamBuilder<DashBoardLichHopModel>(
                      stream: cubit.dashBoardStream,
                      builder: (context, snapshot) {
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
                    );
                  }
                },
              ),
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
                },
              ),
              Expanded(
                child: BlocBuilder<LichHopCubit, LichHopState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return state.lichHopTablet(cubit);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
