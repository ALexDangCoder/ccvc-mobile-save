import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class ItemListTablet extends StatelessWidget {
  const ItemListTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: backgroundColorApp,
        border: Border.all(color: borderColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
            child: Image.asset(ImageAssets.icMenuListBaoCaoTab),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              S.current.bac_cao,
              style: textNormalCustom(color: titleCalenderWork, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
