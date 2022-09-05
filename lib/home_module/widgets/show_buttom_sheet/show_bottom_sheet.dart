import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';

Future<T?> showBottomSheetCustom<T>(
  BuildContext context, {
  required Widget child,
  required String title,
   double paddingHorizontal = 16,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    ),
    clipBehavior: Clip.hardEdge,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          lineContainer(),
          const SizedBox(
            height: 22,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const  EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: textNormalCustom(fontSize: 18, color: textTitle),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: child,
              )
            ],
          ),
        ],
      );
    },
  );
}

Widget lineContainer() {
  return Container(
    height: 6,
    width: 48,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: lineColor,
    ),
  );
}
