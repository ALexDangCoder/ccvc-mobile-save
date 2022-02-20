import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YKienNguoiDanMenu extends StatefulWidget {
  const YKienNguoiDanMenu({Key? key}) : super(key: key);

  @override
  _YKienNguoiDanMenuState createState() => _YKienNguoiDanMenuState();
}

class _YKienNguoiDanMenuState extends State<YKienNguoiDanMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 44, left: 16),
        color: backgroundDrawerMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemMenu(
                widgetItem: SvgPicture.asset(ImageAssets.icMessItemMenu),
                textItem: S.current.y_kien_nguoi_dan,
                isTitile: true),
            const SizedBox(
              height: 32,
            ),
            ItemMenu(
              widgetItem: SvgPicture.asset(ImageAssets.icPersonItemMenu),
              textItem: S.current.thong_tin_chung,
              isTitile: true,
            ),
            const SizedBox(
              height: 32,
            ),
            ItemMenu(
              widgetItem: SvgPicture.asset(ImageAssets.icBaoCaoItemNenu),
              textItem: S.current.bao_cao_thong_ke,
              isTitile: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final Widget widgetItem;
  final String textItem;
  final bool isTitile;

  const ItemMenu(
      {Key? key,
      required this.widgetItem,
      required this.textItem,
      required this.isTitile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widgetItem,
        const SizedBox(
          width: 12,
        ),
        Text(
          textItem,
          style: textNormalCustom(
            fontWeight: isTitile ? FontWeight.w500 : FontWeight.w400,
            color: Colors.white,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
