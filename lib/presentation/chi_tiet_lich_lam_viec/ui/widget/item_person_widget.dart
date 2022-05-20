import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPersonWidget extends StatelessWidget {
  final Color color;
  final String name;
  final bool isConnect;

  const ItemPersonWidget({
    Key? key,
    required this.color,
    required this.name,
    required this.isConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.0.textScale()),
      child: Row(
        children: [
          if (isConnect)
            SizedBox(
              width: 40.0.textScale(),
              height: 40.0.textScale(),
              child: Stack(
                children: [
                  avata(firstName: name.substring(0, 1), color: color),
                  Positioned(
                    top: 15.0.textScale(),
                    left: 22.0.textScale(),
                    child: Image.asset(ImageAssets.imgCheckBox),
                  )
                ],
              ),
            )
          else
            avata(firstName: name.substring(0, 1), color: color),
          SizedBox(
            width: !isConnect ? 26.0.textScale() : 18.0.textScale(),
          ),
          Text(
            name,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

Widget avata({required String firstName, required Color color}) {
  return Container(
    width: 32.0.textScale(),
    height: 32.0.textScale(),
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child:  Text(
      firstName,
      style: textNormalCustom(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 14.0.textScale(),
      ),
    ),
  );
}
