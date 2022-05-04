import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemMenuNhiemVuWidgetMobile extends StatelessWidget {
  final String icon;
  final String name;
  final bool isSelect;
  final Function onTap;

  const ItemMenuNhiemVuWidgetMobile({
    Key? key,
    required this.icon,
    required this.name,
    required this.isSelect,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.0.textScale(space: 13),
          vertical: 10.0.textScale(space: 4),
        ),
        color: isSelect ? AppTheme.getInstance().colorField() : Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 15.0.textScale(space: 8),
              width: 15.0.textScale(space: 8),
              child: SvgPicture.asset(
                icon,
                color: isSelect ? Colors.white : AppTheme.getInstance().colorField(),
              ),
            ),
            SizedBox(
              width: 12.0.textScale(space: 6),
            ),
            Text(
              name,
              style: textNormalCustom(
                color: isSelect ? Colors.white : titleColor,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(space: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
