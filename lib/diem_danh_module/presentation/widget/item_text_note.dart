import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ItemTextNote extends StatelessWidget {
  final String title;

  const ItemTextNote({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormalCustom(
              color: color3D5586,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          ),
          Text(
            ' *',
            style: textNormalCustom(
              color: colorF44336,
            ),
          )
        ],
      ),
    );
  }
}
