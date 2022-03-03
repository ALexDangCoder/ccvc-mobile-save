import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/danh_sach_y_kien_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DanhSachYKienButtom extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  const DanhSachYKienButtom({Key? key,required this.cubit}) : super(key: key);

  @override
  _DanhSachYKienButtomState createState() => _DanhSachYKienButtomState();
}

class _DanhSachYKienButtomState extends State<DanhSachYKienButtom> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      text: S.current.danh_sach_y_kien,
      urlIcon: ImageAssets.ic_danhsachykien,
      onTap: () {
        showBottomSheetCustom(
          context,
          child:  DanhSachYKienScreen(cubit: widget.cubit,),
          title: S.current.danh_sach_y_kien,
        );
      },
    );
  }
}
