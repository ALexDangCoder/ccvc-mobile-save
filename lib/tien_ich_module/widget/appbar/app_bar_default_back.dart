import 'dart:ui';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AppBarDefaultBack extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color? backGroundColors;

  AppBarDefaultBack(this.title, {Key? key, this.backGroundColors})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor:
          APP_DEVICE == DeviceType.MOBILE ? colorFFFFFF : colorF9FAFF,
      bottomOpacity: 0.0,
      elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
      shadowColor: colorE2E8F0,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => {Navigator.pop(context)},
        icon: SvgPicture.asset(
          ImageAssets.icBack,
        ),
      ),
    );
  }
}
