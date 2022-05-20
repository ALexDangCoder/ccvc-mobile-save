import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class TitleChildWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final double paddingTop;
  final double sizeTitle;
  const TitleChildWidget({
    Key? key,
    required this.title,
    required this.child,
    this.paddingTop = 16,
    this.sizeTitle = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textNormalCustom(color: color667793, fontSize: sizeTitle),
        ),
        SizedBox(
          height: paddingTop,
        ),
        child
      ],
    );
  }
}
