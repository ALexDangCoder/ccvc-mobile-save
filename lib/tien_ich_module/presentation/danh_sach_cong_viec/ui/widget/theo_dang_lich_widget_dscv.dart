import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TheoDangLichWidgetDSCV extends StatelessWidget {
  final String icon;
  final String name;
  final bool isSelect;
  final Function onTap;
  final int number;

  const TheoDangLichWidgetDSCV({
    Key? key,
    required this.icon,
    required this.name,
    required this.isSelect,
    required this.onTap,
    required this.number,
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
                color: isSelect
                    ? Colors.white
                    : AppTheme.getInstance().colorField(),
              ),
            ),
            SizedBox(
              width: 12.0.textScale(space: 6),
            ),
            Expanded(
              child: Text(
                name,
                style: textNormalCustom(
                  color: isSelect ? Colors.white : color3D5586,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0.textScale(space: 4),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppTheme.getInstance().colorField(),
              ),
              alignment: Alignment.center,
              child: Text(
                number.toString(),
                style: textNormalCustom(
                  color: bgDropDown,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0.textScale(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
