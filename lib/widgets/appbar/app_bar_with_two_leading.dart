import 'dart:ui';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWithTwoLeading extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? leadingIcon;
  final Widget? widgetTitle;
  final String title;
  final Color? backGroundColorTablet;
  final List<Widget>? actions;

  AppBarWithTwoLeading({
    Key? key,
    required this.title,
    this.leadingIcon,
    this.widgetTitle,
    this.actions,
    this.backGroundColorTablet,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: isMobile()
          ? const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.dark,
      backgroundColor: backGroundColorTablet ?? backgroundColorApp,
      bottomOpacity: 0.0,
      leadingWidth: 100,
      elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
      shadowColor: bgDropDown,
      automaticallyImplyLeading: false,
      title: widgetTitle ??
          Text(
            title,
            style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
          ),
      centerTitle: true,
      leading: leadingIcon,
      actions: actions,
    );
  }
}
