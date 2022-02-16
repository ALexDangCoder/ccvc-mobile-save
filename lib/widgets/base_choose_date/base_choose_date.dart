import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseChooseDate extends StatefulWidget {
  final Function? onTapDay;
  final Function? onTapWeek;
  final Function? onTapMonth;

  const BaseChooseDate({
    Key? key,
    this.onTapDay,
    this.onTapWeek,
    this.onTapMonth,
  }) : super(key: key);

  @override
  _BaseChooseDateState createState() => _BaseChooseDateState();
}

class _BaseChooseDateState extends State<BaseChooseDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onTapDay!();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icCalenderDay),
                  spaceW13,
                  Text(
                    S.current.ngay,
                    style: textDetailHDSD(fontSize: 14, color: iconColorDown),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onTapWeek!();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icCalenderWorkWeek),
                  spaceW13,
                  Text(
                    S.current.tuan,
                    style: textDetailHDSD(fontSize: 14, color: iconColorDown),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onTapMonth!();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.icCalenderWorkMoth),
                  spaceW13,
                  Text(
                    S.current.thang,
                    style: textDetailHDSD(fontSize: 14, color: textBodyTime),
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
