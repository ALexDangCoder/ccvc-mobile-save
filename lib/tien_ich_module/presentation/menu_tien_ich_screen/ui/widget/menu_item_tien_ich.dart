import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemTienIch extends StatelessWidget {
  final String urlIcon;
  final String title;
  final bool isBorder;

  const MenuItemTienIch({
    Key? key,
    required this.title,
    required this.urlIcon,
    this.isBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
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
                  Expanded(
                    child: Text(
                      title,
                      style: textNormal(
                        AppTheme.getInstance().titleColor(),
                        14.0.textScale(),
                      ),
                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
