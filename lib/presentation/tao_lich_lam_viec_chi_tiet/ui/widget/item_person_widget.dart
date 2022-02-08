import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class ItemPersonWidget extends StatelessWidget {
  final String name;

  const ItemPersonWidget(
      {Key? key, required this.name,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0.textScale()),
      child: Row(
        children: [
          Container(
            width: 26.5.textScale(),
          ),
          Container(
            height: 32.0.textScale(),
            width: 32.0.textScale(),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  gradientStart,
                  gradientEnd,
                ],
              ),
            ),
            child: Text(
              name[0],
              style: textNormalCustom(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0.textScale(),),
            ),
          ),
          SizedBox(
            width: 12.0.textScale(),
          ),
          Text(
            name,
            style: textNormalCustom(
              color: fontColorTablet2,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          )
        ],
      ),
    );
  }
}
