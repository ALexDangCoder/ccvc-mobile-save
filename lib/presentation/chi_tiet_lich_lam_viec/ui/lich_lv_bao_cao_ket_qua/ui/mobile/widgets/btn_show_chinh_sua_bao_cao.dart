import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/ui/mobile/bao_cao_mobile_screen.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import '../../widgets/bottom_sheet_bao_cao.dart';

class BtnShowChinhSuaBaoCao extends StatelessWidget {
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit;
  final ChiTietLichLamViecModel dataModel;

  const BtnShowChinhSuaBaoCao({Key? key, required this.chiTietLichLamViecCubit, required this.dataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          S.current.bao_cao_ket_qua,
          style: textNormalCustom(
            color: titleColumn,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dataModel.status != EnumScheduleStatus.Cancel &&
              !chiTietLichLamViecCubit.checkMenuLichThuHoi(dataModel))
            SolidButton(
            onTap: () {
              onBaoCaoKetQua(context);
            },
            text: S.current.bao_cao_ket_qua,
            urlIcon: ImageAssets.ic_baocao,
          ),
          spaceH16,
          BaoCaoScreen(
            cubit: chiTietLichLamViecCubit,
          ),
        ],
      ),
    );
  }

  void onBaoCaoKetQua(BuildContext context) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        title: S.current.bao_cao_ket_qua,
        child: BaoCaoBottomSheet(
          scheduleId: chiTietLichLamViecCubit.idLichLamViec,
          cubit: BaoCaoKetQuaCubit(),
          listTinhTrangBaoCao: chiTietLichLamViecCubit.listTinhTrang,
        ),
      ).then((value) {
        if (value is bool && value) {
          chiTietLichLamViecCubit
              .getDanhSachBaoCaoKetQua(chiTietLichLamViecCubit.idLichLamViec);
        }
      });
    } else {
      showDiaLogTablet(
        context,
        title: S.current.bao_cao_ket_qua,
        child: BaoCaoBottomSheet(
          scheduleId: chiTietLichLamViecCubit.idLichLamViec,
          cubit: BaoCaoKetQuaCubit(),
          listTinhTrangBaoCao: chiTietLichLamViecCubit.listTinhTrang,
        ),
        isBottomShow: false,
        funcBtnOk: () {
          Navigator.pop(context);



        },
      ).then((value) {
        if (value is bool && value) {
          chiTietLichLamViecCubit
              .getDanhSachBaoCaoKetQua(chiTietLichLamViecCubit.idLichLamViec);
        }
      });
    }
  }
}
