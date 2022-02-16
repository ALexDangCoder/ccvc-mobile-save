import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/ui/tablet/bao_cao_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';

class BtnShowBaoCaoTablet extends StatelessWidget {
  const BtnShowBaoCaoTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BaoCaoTabletScreen(),
          ),
        );
      },
      text: S.current.danh_sach_bao_cao_ket_qua,
      urlIcon: ImageAssets.ic_baocao,
    );
  }
}
