import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SolidButton extends StatelessWidget {
  final bool? isColorBlue;
  final Function() onTap;
  final String text;
   final String urlIcon;
  final MainAxisAlignment? mainAxisAlignment;

  const SolidButton({
    Key? key,
    this.isColorBlue=false,
    required this.onTap,
    required this.text,
    required this.urlIcon,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: APP_DEVICE == DeviceType.MOBILE
            ? const EdgeInsets.only(right: 18, left: 12, top: 6, bottom: 6)
            : const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 20),
        decoration: BoxDecoration(
          color: !(isColorBlue??false)? AppTheme.getInstance().colorField().withOpacity(0.1):AppTheme.getInstance().colorField(),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:mainAxisAlignment?? MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              urlIcon,
              width: 20,
              height: 20,
              color: !(isColorBlue??false)? AppTheme.getInstance().colorField():backgroundColorApp,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: textNormalCustom(
                  color: !(isColorBlue??false)? AppTheme.getInstance().colorField():backgroundColorApp, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
