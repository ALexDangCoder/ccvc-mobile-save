import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

class AppTheme {
  static AppColor getInstance() {
    switch(APP_THEME){
      case AppMode.MAC_DINH:
         return DefaultTheme();
      case AppMode.XANH:
        return BlueTheme();
      case AppMode.HONG:
        return PinkTheme();
      case AppMode.VANG:
       return YellowTheme();
    }

  }
}
