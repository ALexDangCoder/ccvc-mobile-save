import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ItemListBangTinTablet extends StatelessWidget {
  final String tin;
  final bool isCheck;
  final Function() onclick;

  const ItemListBangTinTablet({
    Key? key,
    required this.tin,
    required this.isCheck,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCheck
          ? AppTheme.getInstance().colorField().withOpacity(0.1)
          : backgroundColorApp,
      // margin: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () {
          onclick();
        },
        child: Row(
          children: [
            if (isCheck)
              Icon(
                Icons.double_arrow,
                color: AppTheme.getInstance().colorField(),
                size: 16,
              )
            else
              Container(
                width: 14,
              ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.brightness_1,
              color: isCheck
                  ? AppTheme.getInstance().colorField()
                  : AppTheme.getInstance().sideTextInactiveColor(),
              size: 12,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  tin,
                  style: textNormalCustom(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: isCheck
                        ? AppTheme.getInstance().colorField()
                        : infoColor,
                  ),
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
