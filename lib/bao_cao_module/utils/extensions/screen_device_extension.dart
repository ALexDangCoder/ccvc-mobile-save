import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

Widget screenDevice({
  required Widget mobileScreen,
  required Widget tabletScreen,
}) {
  if (APP_DEVICE == DeviceType.MOBILE) {
    return mobileScreen;
  } else {
    return tabletScreen;
  }
}

bool isMobile() {
  if (APP_DEVICE == DeviceType.MOBILE) {
    return true;
  } else {
    return false;
  }
}
