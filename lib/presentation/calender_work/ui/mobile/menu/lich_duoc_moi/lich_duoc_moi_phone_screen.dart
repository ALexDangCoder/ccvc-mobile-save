import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/list/widget/custom_item_calender_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/calendar_work_menu_phone.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/select_option_header.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LichDuocMoiPhoneScreen extends StatefulWidget {
  final CalenderCubit cubit;

  const LichDuocMoiPhoneScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _LichDuocMoiPhoneScreenState createState() => _LichDuocMoiPhoneScreenState();
}

class _LichDuocMoiPhoneScreenState extends State<LichDuocMoiPhoneScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getDay();

    widget.cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_duoc_moi,
        leadingIcon: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: const CalendarWorkMenu(),
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
              const SizedBox(
                height: 130,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.cubit.textDay,
                            style: textNormalCustom(color: textBodyTime),
                          ),
                          stateLDM.ChoXacNhan.getState(3),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.cubit.listMeeting.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CustomItemCalenderMobile(
                                title: widget.cubit.listMeeting[index].title,
                                dateTimeFrom: DateTime.parse(widget
                                        .cubit.listMeeting[index].dateTimeFrom)
                                    .toStringWithAMPM,
                                dateTimeTo: DateTime.parse(widget
                                        .cubit.listMeeting[index].dateTimeTo)
                                    .toStringWithAMPM,
                                urlImage:
                                    'https://th.bing.com/th/id/R.91e66c15f578d577c2b40dcf097f6a98?rik=41oluNFG8wUvYA&pid=ImgRaw&r=0',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChiTietLichLamViecScreen(),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          Column(
            children: [
              if (widget.cubit.isCheck)
                BlocBuilder<CalenderCubit, CalenderState>(
                  bloc: widget.cubit,
                  builder: (context, state) {
                    return SelectOptionHeader(
                      onTapDay: () {
                        setState(() {});
                        widget.cubit
                            .chooseTypeCalender(Type_Choose_Option_Day.DAY);
                      },
                      onTapWeek: () {
                        setState(() {});
                        widget.cubit
                            .chooseTypeCalender(Type_Choose_Option_Day.WEEK);
                      },
                      onTapmonth: () {
                        setState(() {});
                        widget.cubit
                            .chooseTypeCalender(Type_Choose_Option_Day.MONTH);
                      },
                      cubit: widget.cubit,
                    );
                  },
                )
              else
                Container(),
              BlocBuilder<CalenderCubit, CalenderState>(
                bloc: widget.cubit,
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
              builder: (context) => const TaoLichLamViecChiTietScreen(),
            ),
          );
        },
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
