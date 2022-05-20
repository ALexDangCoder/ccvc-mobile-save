import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TuKhoaPhoBienWidget extends StatelessWidget {
  final List<String> listKeyWord;

  const TuKhoaPhoBienWidget({Key? key, required this.listKeyWord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: listKeyWord
          .map(
            (value) => Container(
              margin: EdgeInsets.only(
                right: 12.0.textScale(),
                bottom: 8.0.textScale(),
              ),
              decoration: BoxDecoration(
                color: colorF0F6FF,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.textScale(),
                vertical: 5.0.textScale(),
              ),
              child: Text(
                value,
                style: textNormalCustom(
                  color: color667793,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
