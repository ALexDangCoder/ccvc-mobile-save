import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class ButtonSaveWidget extends StatelessWidget {
  final String leftTxt;
  final String rightTxt;
  final Function() funcBtnOk;
  const ButtonSaveWidget(
      {Key? key,
      required this.leftTxt,
      required this.rightTxt,
      required this.funcBtnOk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        button(
          onTap: () {
            Navigator.pop(context);
          },
          title: leftTxt,
        ),
        spaceW20,
        button(
          onTap: () {
            funcBtnOk();
          },
          title: rightTxt,
          isLeft: false,
        )
      ],
    );
  }

  Widget button({
    required Function onTap,
    required String title,
    bool isLeft = true,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 44,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft ? buttonColor2 : textDefault,
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft ? textDefault : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
