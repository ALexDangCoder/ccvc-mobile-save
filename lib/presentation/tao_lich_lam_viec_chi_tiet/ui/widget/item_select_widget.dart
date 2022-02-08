import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSelectWidget extends StatelessWidget {
  final String text;
  final bool isSelect;
  final Color? color;

  const ItemSelectWidget({
    Key? key,
    required this.text,
    required this.isSelect,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 21.0.textScale()),
      child: Row(
        children: [
          Container(
            height: 12.0.textScale(),
            width: 12.0.textScale(),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4),),
          ),
          SizedBox(
            width: 20.5.textScale(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: textNormalCustom(
                      color: fontColorTablet2,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                ),
                if (isSelect)
                  SvgPicture.asset(ImageAssets.icCheck)
                else
                  Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
