import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

extension SizeInt on int {
  int textScale({int space = 2}) {
    return APP_DEVICE == DeviceType.MOBILE ? this : this + space;
  }
}

extension SizeDouble on double {
  double textScale({double space = 2}) {
    return APP_DEVICE == DeviceType.MOBILE ? this : this + space;
  }
}
