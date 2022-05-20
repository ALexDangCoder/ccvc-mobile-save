import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuCellWidget extends StatelessWidget {
  final String urlIcon;
  final String title;
  final bool isBorder;
  const MenuCellWidget({
    Key? key,
    required this.title,
    required this.urlIcon,
    this.isBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: isBorder ? colorECEEF7 : Colors.transparent),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(urlIcon),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().titleColor(),
                    14.0.textScale(),
                  ),
                ),
                const Icon(
                  Icons.navigate_next,
                  color: colorA2AEBD,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
