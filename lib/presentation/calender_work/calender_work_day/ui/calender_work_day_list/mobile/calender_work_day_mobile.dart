import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/calender_work_day_lich/mobile/calender_work_day_lich_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/calender_work_day_list/mobile/widget/in_list_form.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/drawer_menu.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/drawer_menu_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/base_choose_date/base_choose_date.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/material.dart';
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
  Offset? a;

  @override
  void initState() {
    super.initState();
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
          icon: SvgPicture.asset(ImageAssets.icCalenderWorkDay),
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
                    return screenDevice(
                      mobileScreen: BaseMenuPhone(
                        const [],
                        const [],
                        offsetAnimation,
                        S.current.calendar_work,
                        ImageAssets.icMenuCalender,
                        (p0) => null,
                        const [],
                        const [],
                      ),
                      tabletScreen: BaseMenuTablet(
                        const [],
                        const [],
                        offsetAnimation,
                        S.current.calendar_work,
                        ImageAssets.icMenuCalender,
                        (p0) => null,
                        const [],
                        const [],
                      ),
                    );
                  },
                  opaque: false,
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: hegihtCalendar),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: const InListForm(),
          ),
          Column(
            children: [
              Container(
                child: cubit.isCheck ? const BaseChooseDate() : Container(),
              ),
              const TableCalendarWidget(),
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
              builder: (context) => const CalenderWorkDayLichMobile(),
            ),
          );
        },
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
