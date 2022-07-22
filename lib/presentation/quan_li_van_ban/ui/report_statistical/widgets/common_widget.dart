import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget infoItem({
  required String title,
  required int quantity,
  required int lastYearQuantity,
  required Color color,
}) {
  final format = NumberFormat(NUMBER_FORMAT_POINT, EN_US_CODE);
  return Container(
    width: 250,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(isMobile() ? 8 : 12),
      color: backgroundColorApp,
      border: Border.all(
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
            color: color3D5586,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              format.format(quantity),
              style: tokenDetailAmount(
                fontSize: 28.0.textScale(),
                weight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            '${S.current.nam_truoc}: ${format.format(lastYearQuantity)} (${getPercent(quantity, lastYearQuantity)})',
            style: tokenDetailAmount(
              fontSize: 12.0.textScale(),
              color: color667793,
            ),
          ),
        ),
      ],
    ),
  );
}

String getPercent(int firstNumber, int secondNumber) {
  final percent = (firstNumber / secondNumber) * 100 - 100;
  return '${percent > 0 ? '+' : ''}${percent.toStringAsFixed(2)}%';
}
