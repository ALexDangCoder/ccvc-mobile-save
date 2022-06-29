import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import 'widget/choose_time_calendar_tablet.dart';

class MainCalendarTabletScreen extends StatefulWidget {
  final bool isBack;
  const MainCalendarTabletScreen({Key? key, this.isBack = false})
      : super(key: key);

  @override
  _MainCalendarTabletScreenState createState() =>
      _MainCalendarTabletScreenState();
}

class _MainCalendarTabletScreenState extends State<MainCalendarTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWidgets,
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgWidgets,
        title: S.current.lich_cua_toi,
        leadingIcon: Row(
          children: [
            if (widget.isBack)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              )
            else
              const SizedBox(),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                ImageAssets.icMenuCalender,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ChooseTimeCalendarTablet(
            onChange: (startDate, endDate, type, keySearch) {

            },
            onChangeYear: (startDate,endDate,keySearch){

            }, onTapTao: () {  },
          )
        ],
      ),
    );
  }
}
