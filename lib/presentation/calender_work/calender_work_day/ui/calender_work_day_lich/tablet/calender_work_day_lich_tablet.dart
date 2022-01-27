import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/calender_work_day_lich/tablet/widget/in_calender_form_tablet.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/drawer_menu.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/drawer_menu_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalenderWorkDayLichTablet extends StatefulWidget {
  const CalenderWorkDayLichTablet({Key? key}) : super(key: key);

  @override
  _CalenderWorkDayLichTabletState createState() =>
      _CalenderWorkDayLichTabletState();
}

class _CalenderWorkDayLichTabletState extends State<CalenderWorkDayLichTablet> {
  CalenderCubit cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.lich_cua_toi,
        leadingIcon: IconButton(
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
        ),
      ),
      body: Column(
        children: const [
          Expanded(child: InCalenderFormTablet()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CalenderWorkDayLichTablet(),
            ),
          );
        },
        backgroundColor: labelColor,
        child: SvgPicture.asset(ImageAssets.icVectorCalender),
      ),
    );
  }
}
