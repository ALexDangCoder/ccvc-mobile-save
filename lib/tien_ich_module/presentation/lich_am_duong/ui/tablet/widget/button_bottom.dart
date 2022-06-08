import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonBottomTablet extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ButtonBottomTablet({
    Key? key,
    required this.onPressed,
    required this.text,
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
        color: AppTheme.getInstance().statusColor(),
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Text(
              text,
              style: textNormalCustom(
                color: AppTheme.getInstance().bgColor(),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
