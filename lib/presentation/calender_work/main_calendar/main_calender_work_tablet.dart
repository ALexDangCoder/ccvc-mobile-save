import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/ultis_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/widget_select_option_header.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/tablet/tao_lich_lam_viec_chi_tiet_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet.dart';
import 'package:ccvc_mobile/widgets/menu/menu_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/menu/menu_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CalenderWorkDayTablet extends StatefulWidget {
  final bool isBack;

  const CalenderWorkDayTablet({Key? key, this.isBack = false})
      : super(key: key);

  @override
  _CalenderWorkDayTabletState createState() => _CalenderWorkDayTabletState();
}

class _CalenderWorkDayTabletState extends State<CalenderWorkDayTablet> {
  CalenderCubit cubit = CalenderCubit();
  final MenuCalendarCubit cubitMenu = MenuCalendarCubit();

  @override
  void initState() {
    super.initState();
    cubit.changeDateByClick = true;
    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LICH);
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeCalendarMenu>(
      stream: cubit.changeItemMenuStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBarWithTwoLeading(
            title: snapshot.data == TypeCalendarMenu.LichTheoLanhDao
                ? cubit.titleAppbar
                : snapshot.data?.getTitle() ??
                    TypeCalendarMenu.LichCuaToi.getTitle(),
            leadingIcon: Row(
              children: [
                if (widget.isBack)
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      ImageAssets.icBack,
                    ),
                  )
                else
                  const SizedBox(),
                BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuWidget(
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
                                }
                                cubit.modeLLV =
                                    Type_Choose_Option_List.DANG_LIST;
                              },
                              listItem: listThongBao,
                              onTapLanhDao: (value) {
                                cubit.titleAppbar = value.tenDonVi ?? '';
                                cubit.idDonViLanhDao = value.id ?? '';
                              },
                              streamDashBoard:
                                  cubit.lichLamViecDashBroadSubject.stream,
                              title: S.current.lich_lam_viec,
                              cubit: cubitMenu,
                            ),
                          ),
                        ).then((value) {
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
                        });
                      },
                      icon: SvgPicture.asset(
                        ImageAssets.icMenuCalender,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: StateStreamLayout(
            stream: cubit.stateStream,
            retry: () {},
            textEmpty: S.current.khong_co_du_lieu,
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            child: Column(
              children: [
                WidgetSelectOptionHeader(
                  createMeeting: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TaoLichLamViecChiTietTablet(),
                      ),
                    ).then((value) {
                      if (value == null) {}
                      if (value == true) {
                        cubit.callApi();
                      }
                    });
                  },
                  onTapDay: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.DAY);
                    cubit.stateOptionDay = Type_Choose_Option_Day.DAY;

                    cubit.callApi();
                  },
                  onTapWeek: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.WEEK);
                    cubit.stateOptionDay = Type_Choose_Option_Day.WEEK;

                    cubit.callApiTuan();
                  },
                  onTapMonth: () {
                    setState(() {});
                    cubit.chooseTypeCalender(Type_Choose_Option_Day.MONTH);
                    cubit.stateOptionDay = Type_Choose_Option_Day.MONTH;

                    cubit.callApiMonth();
                  },
                  cubit: cubit,
                ),
                BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return StreamBuilder<List<DateTime>>(
                      stream: cubit.eventsStream,
                      builder: (context, snapshot) {
                        return TableCandarTablet(
                          eventsLoader: snapshot.data,
                          type: state.type,
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
                            cubit.selectDay = selectDay;
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
                              StreamBuilder<DashBoardLichHopModel>(
                                initialData: DashBoardLichHopModel.empty(),
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
