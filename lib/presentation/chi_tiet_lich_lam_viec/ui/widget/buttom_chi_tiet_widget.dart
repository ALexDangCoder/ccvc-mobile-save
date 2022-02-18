import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtomChiTietWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  const ButtomChiTietWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.0.textScale(),
        horizontal: 18.0.textScale(),
      ),
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              width: 10.0.textScale(),
            ),
            Text(
              title,
              style: textNormalCustom(
                color: buttonColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0.textScale(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
