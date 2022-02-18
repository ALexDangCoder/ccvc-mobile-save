import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/lich/in_calender_form.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/drawer_menu.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/base_choose_date/base_choose_date.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalenderWorkDayLichMobile extends StatefulWidget {
  const CalenderWorkDayLichMobile({Key? key}) : super(key: key);

  @override
  _CalenderWorkDayLichMobileState createState() =>
      _CalenderWorkDayLichMobileState();
}

class _CalenderWorkDayLichMobileState extends State<CalenderWorkDayLichMobile> {
  CalenderCubit cubit = CalenderCubit();
  GlobalKey globalKey = GlobalKey();
  double hegihtCalendar = 120;

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
                      tabletScreen: BaseMenuPhone(
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
            child: const InCalenderForm(),
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
        onPressed: () {},
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
