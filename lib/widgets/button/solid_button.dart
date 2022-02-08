import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SolidButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String urlIcon;
  const SolidButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.urlIcon,
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
            : const EdgeInsets.only(top: 10, bottom: 10, left: 16,right: 20),
        decoration: BoxDecoration(
          color: buttonColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(urlIcon),
            const SizedBox(
              width: 8,
            ),
            Text(
             text,
              style: textNormalCustom(color: labelColor, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
