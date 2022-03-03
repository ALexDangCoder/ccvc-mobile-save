import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/calendar_work_menu_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/widget_select_option_header.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/tablet/tao_lich_lam_viec_chi_tiet_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CalenderWorkDayTablet extends StatefulWidget {
  const CalenderWorkDayTablet({Key? key}) : super(key: key);

  @override
  _CalenderWorkDayTabletState createState() => _CalenderWorkDayTabletState();
}

class _CalenderWorkDayTabletState extends State<CalenderWorkDayTablet> {
  final CalenderCubit cubit = CalenderCubit();

  @override
  void initState() {
    super.initState();
    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
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
              title: snapshot.data?.getTitle() ??
                  TypeCalendarMenu.LichCuaToi.getTitle(),
              leadingIcon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarWorkMenuTablet(
                        cubit: cubit,
                      ),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  ImageAssets.icMenuCalender,
                ),
              ),
            ),
            body: Column(
              children: [
                WidgetSelectOptionHeader(
                  createMeeting: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TaoLichLamViecChiTietTablet(),
                      ),
                    );
                  },
                  onTapDay: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.DAY);
                  },
                  onTapMonth: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.MONTH);
                  },
                  onTapWeek: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.WEEK);
                  },
                  cubit: cubit,
                ),
                BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return TableCandarTablet(
                      type: state.type,
                    );
                  },
                ),
                if (snapshot.data == TypeCalendarMenu.LichCuaToi)
                  BlocBuilder<CalenderCubit, CalenderState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 28.0,
                          ),
                          color: backgroundColorApp,
                          height: 116,
                          child: Row(
                            children: [
                              StreamBuilder<LichLamViecDashBroad>(
                                initialData: LichLamViecDashBroad(
                                  countScheduleCaNhan: 0,
                                ),
                                stream: cubit.streamLichLamViec,
                                builder: (context, snapshot) {
                                  return CustomItemCalenderWorkTablet(
                                    image: ImageAssets.icTongSoLichLamviec,
                                    typeName: S.current.tong_so_lich_lam_viec,
                                    numberOfCalendars: cubit
                                            .lichLamViecDashBroadSubject
                                            .value
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
                                        return CustomItemCalenderWorkTablet(
                                          image: cubit.img[index],
                                          typeName: data[index].typeName ?? '',
                                          numberOfCalendars:
                                              data[index].numberOfCalendars ??
                                                  0,
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
                      );
                    },
                  )
                else
                  Container(),
                spaceH28,
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  height: 1,
                  color: bgDropDown,
                ),
                Expanded(
                  child: BlocBuilder<CalenderCubit, CalenderState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return state.lichLamViec(cubit);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
