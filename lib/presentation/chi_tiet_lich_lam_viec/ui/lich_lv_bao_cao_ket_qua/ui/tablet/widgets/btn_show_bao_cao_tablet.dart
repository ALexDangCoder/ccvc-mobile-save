import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/widgets/bottom_sheet_bao_cao.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BtnShowBaoCaoTablet extends StatelessWidget {
  final ChiTietLichLamViecCubit cubit;

  const BtnShowBaoCaoTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const  EdgeInsets.symmetric(vertical: 12),
        child: Text(
          S.current.bao_cao_ket_qua,
          style: textNormalCustom(
            color: titleColumn,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: SolidButton(
        onTap: () {
          showBottomSheetCustom(
            context,
            title: S.current.bao_cao_ket_qua,
            child: BaoCaoBottomSheet(
              scheduleId: cubit.idLichLamViec,
              cubit: BaoCaoKetQuaCubit(),
              listTinhTrangBaoCao:
              cubit.listTinhTrang,
            ),
          ).then((value){
            if (value is bool && value) {
              cubit.getDanhSachBaoCaoKetQua(
                  cubit.idLichLamViec);
            }
          });
        },
        text: S.current.danh_sach_bao_cao_ket_qua,
        urlIcon: ImageAssets.ic_baocao,
      ),
    );
  }
}
