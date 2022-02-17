import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithTiltleWidget extends StatefulWidget {
  String title;
  Function onPress;
  String icon;
  bool type2;

  IconWithTiltleWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
    this.type2 = false,
  }) : super(key: key);

  @override
  _SolidButtonState createState() => _SolidButtonState();
}

class _SolidButtonState extends State<IconWithTiltleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 18),
          decoration: BoxDecoration(
            color: widget.type2
                ? statusCalenderRed.withOpacity(0.1)
                : textDefault.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: SizedBox(
            child: GestureDetector(
              onTap: () {
                widget.onPress();
              },
              child: Row(
                children: [
                  SvgPicture.asset(widget.icon),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.title,
                    style: textNormalCustom(
                      color: widget.type2 ? statusCalenderRed : textDefault,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        widget.type2 ? const SizedBox() : const Expanded(child: SizedBox())
      ],
    );
  }
}
