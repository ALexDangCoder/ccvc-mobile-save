import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/tablet/bao_cao_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';

class BtnShowBaoCaoTablet extends StatelessWidget {
  final ChiTietLichLamViecCubit cubit;

  const BtnShowBaoCaoTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaoCaoTabletScreen(
              cubit: cubit,
            ),
          ),
        );
      },
      text: S.current.danh_sach_bao_cao_ket_qua,
      urlIcon: ImageAssets.ic_baocao,
    );
  }
}
