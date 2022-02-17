import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/ui/mobile/bao_cao_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BtnShowChinhSuaBaoCao extends StatelessWidget {
  const BtnShowChinhSuaBaoCao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showBottomSheetCustom<BaoCaoModel>(
          context,
          title: S.current.bao_cao_ket_qua,
          child: const BaoCaoScreen(),
        );
      },
      text: S.current.danh_sach_bao_cao_ket_qua,
      urlIcon: ImageAssets.ic_baocao,
    );
  }
}
