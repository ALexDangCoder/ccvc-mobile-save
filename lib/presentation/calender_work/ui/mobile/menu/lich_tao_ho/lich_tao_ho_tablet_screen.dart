import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/list/widget/custom_item_calender_list.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/widget_select_option_header.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/tablet/tao_lich_lam_viec_chi_tiet_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../calendar_work_menu_tablet.dart';

class LichTaoHoTabletScreen extends StatefulWidget {
  final CalenderCubit cubit;
  final bool isHindText;

  const LichTaoHoTabletScreen({
    Key? key,
    required this.cubit,
    this.isHindText = false,
  }) : super(key: key);

  @override
  _LichTaoHoTabletScreenState createState() => _LichTaoHoTabletScreenState();
}

class _LichTaoHoTabletScreenState extends State<LichTaoHoTabletScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_tao_ho,
        actions: [
          IconButton(
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
        ],
        leadingIcon: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Column(
        children: [
          WidgetSelectOptionHeader(
            createMeeting: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaoLichLamViecChiTietTablet(),
                  ));
            },
            onTapDay: () {
              setState(() {});
              widget.cubit.chooseTypeCalender(Type_Choose_Option_Day.DAY);
            },
            onTapMonth: () {
              setState(() {});
              widget.cubit.chooseTypeCalender(Type_Choose_Option_Day.MONTH);
            },
            onTapWeek: () {
              setState(() {});
              widget.cubit.chooseTypeCalender(Type_Choose_Option_Day.WEEK);
            },
            cubit: widget.cubit,
          ),
          BlocBuilder<CalenderCubit, CalenderState>(
            bloc: widget.cubit,
            builder: (context, state) {
              return TableCandarTablet(
                type: state.type,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH28,
                  if (widget.isHindText)
                    Container()
                  else
                    Container(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: Text(
                        widget.cubit.textDay,
                        style: textNormalCustom(color: textBodyTime),
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.cubit.listMeeting.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CustomItemCalenderTablet(
                              title: widget.cubit.listMeeting[index].title,
                              dateTimeFrom: DateTime.parse(
                                widget.cubit.listMeeting[index].dateTimeFrom,
                              ).toStringWithAMPM,
                              dateTimeTo: DateTime.parse(widget
                                      .cubit.listMeeting[index].dateTimeTo)
                                  .toStringWithAMPM,
                              urlImage:
                                  'https://lh3.googleusercontent.com/ogw/ADea4I7KuOHLBX4h7PqlUfbDpmYAuuvb9iBc5eaCvicoFg=s192-c-mo',
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
