import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class TextFieldStylePNG extends StatelessWidget {
  final String? hintText;
  final String urlIcon;
  final int maxLines;

  const TextFieldStylePNG({
    Key? key,
    this.hintText,
    required this.urlIcon,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          width: 16.0.textScale(space: 4),
          height: 16.0.textScale(space: 4),
          color: Colors.transparent,
          child: Image.asset(urlIcon),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: maxLines == 1 ? 9 : 0),
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
      maxLines: maxLines,
      style: textNormal(titleColor, 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textNormal(textBodyTime, 16),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
