import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseDayWeedMonth extends StatelessWidget {
  final Function onTapDay;
  final Function onTapWeek;
  final Function onTapmonth;

  const ChooseDayWeedMonth({
    Key? key,
    required this.onTapDay,
    required this.onTapWeek,
    required this.onTapmonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                onTapDay();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icDayMonth),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    S.current.ngay,
                    style: textNormal(linkColor, 14.0),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onTapWeek();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icDayCalenderWeek),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    S.current.tuan,
                    style: textNormal(linkColor, 14.0),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onTapmonth();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icDayCalenderMonth),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    S.current.thang,
                    style: textNormal(linkColor, 14.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
