import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class TextLichAmHomNay extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextLichAmHomNay({
    Key? key,
    required this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: textNormalCustom(
            color: color ?? color667793,
            fontSize: fontSize ?? 16.0,
            fontWeight: fontWeight??FontWeight.w500
          ),
        ),
      ),
    );
  }
}
