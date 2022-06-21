import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class MainCanlendanRefactor extends StatefulWidget {
  const MainCanlendanRefactor({Key? key}) : super(key: key);

  @override
  _MainCanlendanRefactorState createState() => _MainCanlendanRefactorState();
}

class _MainCanlendanRefactorState extends State<MainCanlendanRefactor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgTabletColor,
        title: 'Lịch của tôi',
        leadingIcon: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                ImageAssets.icCalenderDayBig,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ChooseTimeCalendarWidget()],
        ),
      ),
    );
  }
}
