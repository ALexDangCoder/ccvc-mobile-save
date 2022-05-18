import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonEditScreen extends StatefulWidget {
  final String title1;
  final String title2;

  final Function onPressed1;
  final Function onPressed2;

  const DoubleButtonEditScreen({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onPressed1,
    required this.onPressed2,
  }) : super(key: key);

  @override
  State<DoubleButtonEditScreen> createState() => _DoubleButtonEditScreenState();
}

class _DoubleButtonEditScreenState extends State<DoubleButtonEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            widget.onPressed1();
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 61, right: 61, top: 13, bottom: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
              color: AppTheme.getInstance().colorField().withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                widget.title1,
                style: textNormalCustom(
                  fontSize: 14.0.textScale(space: 4.0),
                  color: AppTheme.getInstance().colorField(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0.textScale(space: 8.0)),
        GestureDetector(
          onTap: () {
            widget.onPressed2();
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 49, right: 49, top: 13, bottom: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
              color: AppTheme.getInstance().colorField(),
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
      ],
    );
  }
}
