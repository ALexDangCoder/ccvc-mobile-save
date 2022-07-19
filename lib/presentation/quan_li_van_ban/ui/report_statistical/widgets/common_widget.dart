import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget infoItem({
  required String title,
  required int quantity,
  required int lastYearQuantity,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile() ? 6 : 12),
        color: backgroundColorApp,
        border: isMobile()
            ? null
            : Border.all(
                color: borderColor.withOpacity(0.5),
              ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: tokenDetailAmount(
              fontSize: 14.0.textScale(),
              color: color586B8B,
            ),
          ),
          Text(
            quantity.toString(),
            style: tokenDetailAmount(
              fontSize: 28.0.textScale(),
              weight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            'Năm trước: $lastYearQuantity (${getPercent(quantity, lastYearQuantity)})',
            style: tokenDetailAmount(
              fontSize: 12.0.textScale(),
              color: color667793,
            ),
          ),
        ],
      ),
    ),
  );
}
String getPercent(int firstNumber, int secondNumber){
  final percent = (firstNumber/secondNumber)*100 - 100;
  return '${percent > 0 ? '+' : ''}${percent.toStringAsFixed(2)}%';
}
