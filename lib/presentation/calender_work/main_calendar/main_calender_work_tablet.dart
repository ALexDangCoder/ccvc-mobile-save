import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/calendar_work_menu_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/lich_lv_extension.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/widget_select_option_header.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/fake_drawer_lich_hop.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalenderWorkDayTablet extends StatefulWidget {
  const CalenderWorkDayTablet({Key? key}) : super(key: key);

  @override
  _CalenderWorkDayTabletState createState() => _CalenderWorkDayTabletState();
}

class _CalenderWorkDayTabletState extends State<CalenderWorkDayTablet> {
  final CalenderCubit _cubit = CalenderCubit();

  @override
  void initState() {
    super.initState();
    _cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_cua_toi,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CalendarWorkMenuTablet(),
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
            createMeeting: () {},
            onTapDay: () {
              setState(() {});
              _cubit.chooseTypeCalender(Type_Choose_Option_Day.DAY);
            },
            onTapMonth: () {
              setState(() {});
              _cubit.chooseTypeCalender(Type_Choose_Option_Day.MONTH);
            },
            onTapWeek: () {
              setState(() {});
              _cubit.chooseTypeCalender(Type_Choose_Option_Day.WEEK);
            },
            cubit: _cubit,
          ),
          BlocBuilder<CalenderCubit, CalenderState>(
            bloc: _cubit,
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: backgroundColorApp,
                  height: 116,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _cubit.list.length,
                    itemBuilder: (context, index) {
                      return CustomItemCalenderWorkTablet(
                        image: _cubit.img[index],
                        typeName: _cubit.list[index].typeName,
                        numberOfCalendars: _cubit.list[index].numberOfCalendars,
                      );
                    },
                  ),
                ),
              );
            },
          ),
          spaceH28,
          Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            height: 1,
            color: bgDropDown,
          ),
          Expanded(
            child: BlocBuilder<CalenderCubit, CalenderState>(
              bloc: _cubit,
              builder: (context, state) {
                return state.lichLamViec();
              },
            ),
          ),
        ],
      ),
    );
  }
}
