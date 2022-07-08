import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonBottomCustom extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color? customColor;
  final Color? textColor;

  const ButtonBottomCustom({
    Key? key,
    required this.onPressed,
    required this.text,
    this.customColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: customColor ?? AppTheme.getInstance().colorField(),
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Text(
              text,
              style: textNormalCustom(
                color: textColor ?? backgroundColorApp,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
