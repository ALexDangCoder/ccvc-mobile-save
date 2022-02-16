import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
class ThemDonViPhoiHopKhacScreen extends StatefulWidget {
  const ThemDonViPhoiHopKhacScreen({Key? key}) : super(key: key);

  @override
  _ThemDonViPhoiHopKhacScreenState createState() => _ThemDonViPhoiHopKhacScreenState();
}

class _ThemDonViPhoiHopKhacScreenState extends State<ThemDonViPhoiHopKhacScreen> {
  @override
  Widget build(BuildContext context) {
    return   SolidButton(
      onTap: () {
        showBottomSheetCustom(context,
          child:const ThemDonViPhoiHopKhacScreen(),
          title: S.current.don_vi_phoi_hop_khac,);
      },
      text: S.current.them_thanh_phan_tham_gia,
      urlIcon: ImageAssets.icAddButtonCalenderTablet,
    );
  }
}
