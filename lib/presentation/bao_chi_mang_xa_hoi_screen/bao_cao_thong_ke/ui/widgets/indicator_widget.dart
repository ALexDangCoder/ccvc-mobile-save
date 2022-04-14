import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ChartIndicatorWidget extends StatelessWidget {
  final String title;
  final Color color;

  const ChartIndicatorWidget(
      {Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Flexible(
          child: FittedBox(
            child: Text(
              title,
              style: textNormal(
                infoColor,
                14.0.textScale(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
