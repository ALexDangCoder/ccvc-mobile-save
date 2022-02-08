import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonBottom extends StatefulWidget {
  final String title1;
  final String title2;
  final Function onPressed1;
  final Function onPressed2;

  const DoubleButtonBottom({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onPressed1,
    required this.onPressed2,
  }) : super(key: key);

  @override
  State<DoubleButtonBottom> createState() => _DoubleButtonBottomState();
}

class _DoubleButtonBottomState extends State<DoubleButtonBottom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onPressed1();
            },
            child: Container(
              height: 40.0.textScale(space: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
                color: buttonColor2,
              ),
              child: Center(
                child: Text(
                  widget.title1,
                  style: textNormalCustom(
                    fontSize: 14.0.textScale(space: 4.0),
                    color: textDefault,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0.textScale(space: 8.0)),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onPressed2();
            },
            child: Container(
              height: 40.0.textScale(space: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
                color: textDefault,
              ),
              child: Center(
                child: Text(
                  widget.title2,
                  style: textNormalCustom(
                    fontSize: 14.0.textScale(space: 4.0),
                    color: backgroundColorApp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
