import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderTabletCalendarWidget extends StatelessWidget {
  final String time;
  const HeaderTabletCalendarWidget({Key? key,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 15, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                time,
                style:
                    textNormalCustom(fontSize: 14, color: titleCalenderWork),
              ),
             const Icon(
                Icons.arrow_drop_down_sharp,
                color: textBodyTime,
              ),
            ],
          ),
          SvgPicture.asset(ImageAssets.ic_search_calendar)
        ],
      ),
    );
  }
}
