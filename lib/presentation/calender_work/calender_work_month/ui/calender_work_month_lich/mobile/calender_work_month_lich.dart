import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_month/ui/calender_work_month_lich/mobile/widget/calender_form_month.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/drawer_menu.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/drawer_menu_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalenderWorkMonthLichMobile extends StatefulWidget {
  const CalenderWorkMonthLichMobile({Key? key}) : super(key: key);

  @override
  _CalenderWorkMonthLichMobileState createState() =>
      _CalenderWorkMonthLichMobileState();
}

class _CalenderWorkMonthLichMobileState
    extends State<CalenderWorkMonthLichMobile> {
  CalenderCubit cubit = CalenderCubit();
  GlobalKey globalKey = GlobalKey();

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
          icon: SvgPicture.asset(ImageAssets.icCalenderWorkMoth),
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
                        offsetAnimation,
                        S.current.calendar_work,
                        ImageAssets.icMenuCalender,
                      ),
                      tabletScreen: BaseMenuTablet(
                        offsetAnimation,
                        S.current.calendar_work,
                        ImageAssets.icMenuCalender,
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
      body: const CalenderFormMonth(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
