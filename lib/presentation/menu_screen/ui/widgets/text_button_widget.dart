import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/mobile/widget_mange_screen.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/tablet/widget_mange_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

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
      child: Text(
        S.current.quan_ly_widget,
        style: textNormalCustom(
          color: AppTheme.getInstance().colorField(),
          fontWeight: APP_DEVICE == DeviceType.MOBILE
              ? FontWeight.w500
              : FontWeight.w700,
          fontSize: 14.0.textScale(),
        ),
      ),
    );
  }
}
