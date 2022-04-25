
import 'package:ccvc_mobile/config/resources/color.dart';


import 'package:ccvc_mobile/presentation/widget_manage/ui/mobile/widget_mange_screen.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/tablet/widget_mange_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextQuanLyWidget extends StatelessWidget {
  const TextQuanLyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => screenDevice(
              mobileScreen: const WidgetManageScreen(),
              tabletScreen: const WidgetManageScreenTablet(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const  BoxDecoration(
          border: Border(
            bottom: BorderSide(color: lineColor),
          ),
        ),
        child: Container(
          height: 32,
          width: 144,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: buttonColor
          ),
          child: Stack(
            c
          )

        ),
      ),
    );
  }
}
