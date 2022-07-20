import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:flutter/material.dart';

class DanhSachYKienButtomTablet extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final String id;

  const DanhSachYKienButtomTablet({
    Key? key,
    required this.id,
    required this.cubit,
  }) : super(key: key);

  @override
  _DanhSachYKienButtomTabletState createState() =>
      _DanhSachYKienButtomTabletState();
}

class _DanhSachYKienButtomTabletState extends State<DanhSachYKienButtomTablet> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      text: S.current.danh_sach_y_kien,
      urlIcon: ImageAssets.ic_danhsachykien,
      onTap: () {
        showDiaLogTablet(
          context,
          title: S.current.cho_y_kien,
          child: YKienBottomSheet(
            id: widget.id,
            isCheck: false,
            isCalendarWork: true,
          ),
          isBottomShow: false,
          funcBtnOk: () {
            Navigator.pop(context);
          },
        ).then((value) {
          if (value == true) {
            widget.cubit.loadApi(widget.id);
          } else if (value == null) {
            return;
          }
        });
      },
    );
  }
}
