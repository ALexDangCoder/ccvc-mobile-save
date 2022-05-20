import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class HeaderExpaned extends StatefulWidget {
  final String title;

  const HeaderExpaned({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderExpanedState createState() => _HeaderExpanedState();
}

class _HeaderExpanedState extends State<HeaderExpaned> {
  bool isExpandIcon = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: color01DBDFEF,
        border: Border.all(color: color05OpacityDBDFEF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              color: color3D5586,
              fontSize: 16,
            ),
          ),
          if (isExpandIcon)
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: colorA2AEBD,
            )
          else
            const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: colorA2AEBD,
            ),
        ],
      ),
    );
  }
}
