import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldStyle extends StatelessWidget {
  final String? hintText;
  final String urlIcon;
  const TextFieldStyle({
    Key? key,
    this.hintText,
    required this.urlIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(urlIcon),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: lineColor),
              ),
            ),
            child: textField(),
          ),
        ),
      ],
    );
  }

  Widget textField() {
    return TextField(
      style: textNormal(titleColor, 16),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textNormal(textBodyTime, 16),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0)),
    );
  }
}
