import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: colorFFFFFF,
        border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: color6566E9.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Image.asset(ImageAssets.icListGroundMobile),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              S.current.bac_cao,
              style: textNormal(color3D5586, 16),
            ),
          )
        ],
      ),
    );
  }
}
