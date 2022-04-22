
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/config/resources/color.dart';
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
        color: cellColor,
        border: Border.all(color: cellColorborder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              color: titleColor,
              fontSize: 16,
            ),
          ),
          if (isExpandIcon)
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AqiColor,
            )
          else
            const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: AqiColor,
            ),
        ],
      ),
    );
  }
}
