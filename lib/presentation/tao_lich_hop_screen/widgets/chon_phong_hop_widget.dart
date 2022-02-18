import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';

class ChonPhongHopWidget extends StatefulWidget {
  const ChonPhongHopWidget({Key? key}) : super(key: key);

  @override
  _ChonPhongHopWidgetState createState() => _ChonPhongHopWidgetState();
}

class _ChonPhongHopWidgetState extends State<ChonPhongHopWidget> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {},
      text: S.current.chon_phong_hop,
      urlIcon: ImageAssets.icChonPhongHop,
    );
  }
}
