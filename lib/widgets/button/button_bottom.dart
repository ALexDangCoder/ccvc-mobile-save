import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool customColor;

  const ButtonBottom({
    Key? key,
    required this.onPressed,
    required this.text,
    this.customColor = false,
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
        color: customColor
            ? AppTheme.getInstance().colorField()
            : AppTheme.getInstance().colorField().withOpacity(0.1),
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Text(
              text,
              style: textNormalCustom(
                color: customColor
                    ? backgroundColorApp
                    : AppTheme.getInstance().colorField(),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
