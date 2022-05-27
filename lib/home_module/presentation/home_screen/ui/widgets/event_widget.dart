import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';

class EventWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const EventWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Text(
              title,
              style: textNormal(infoColor, 14.0.textScale()),
            ),
          )
        ],
      ),
    );
  }
}
