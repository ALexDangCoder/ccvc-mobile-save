import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class IndicatorChart extends StatelessWidget {
  final ItemIndicator itemIndicator;

  const IndicatorChart({Key? key, required this.itemIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                color: itemIndicator.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            FittedBox(
              child: Text(
                itemIndicator.title,
                style: textNormal(
                  infoColor,
                  14.0.textScale(),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class ItemIndicator {
  final Color color;
  final String title;

  ItemIndicator({required this.color, required this.title});
}
