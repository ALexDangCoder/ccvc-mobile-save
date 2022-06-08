import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

Widget rowInfo({required String key, required String value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Text(
          key,
          style: textNormal(infoColor, 14.0.textScale()),
        ),
      ),
      spaceW8,
      Expanded(
        flex: 7,
        child: Text(
          value,
          style: textNormal(color3D5586, 14.0.textScale(),),
        ),
      )
    ],
  );
}
