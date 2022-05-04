import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ItemListBangTin extends StatelessWidget {
  String tin;
  bool isCheck;
  Function() onclick;

  ItemListBangTin(
      {Key? key,
      required this.tin,
      required this.isCheck,
      required this.onclick,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: (){
          onclick();
        },
        child: Row(
          children: [
            if (isCheck)
               Icon(
                Icons.double_arrow,
                color: AppTheme.getInstance().colorField(),
                size: 14,
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
              color: isCheck ? AppTheme.getInstance().colorField() : sideTextInactiveColor,
              size: 8,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                tin,
                style: textNormalCustom(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: isCheck ? AppTheme.getInstance().colorField() : infoColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
