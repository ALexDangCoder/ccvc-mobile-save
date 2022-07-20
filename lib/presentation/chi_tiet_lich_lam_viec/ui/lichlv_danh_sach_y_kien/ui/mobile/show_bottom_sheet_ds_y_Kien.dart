import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/danh_sach_y_kien_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/bottom_sheet_y_kien.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
class DanhSachYKienButtom extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final ChiTietLichLamViecModel dataModel;
  final String id;
  final bool isTablet;

  const DanhSachYKienButtom({
    Key? key,
    required this.id,
    this.isTablet = false,
    required this.cubit,
    required this.dataModel,
  }) : super(key: key);

  @override
  _DanhSachYKienButtomState createState() => _DanhSachYKienButtomState();
}

class _DanhSachYKienButtomState extends State<DanhSachYKienButtom> {
  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          S.current.danh_sach_y_kien,
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
          Visibility(
            visible: widget.cubit.checkChoYKien(widget.dataModel),
            child: SolidButton(
              text: S.current.them_y_kien,
              urlIcon: ImageAssets.ic_danhsachykien,
              onTap: () {
                !widget.isTablet
                    ? showBottomSheetCustom(
                        context,
                        title: S.current.y_kien,
                        child: YKienBottomSheet(
                          id: widget.id,
                          isTablet: widget.isTablet,
                          isCalendarWork: true,
                        ),
                      ).then((value) {
                        if (value == true) {
                          widget.cubit.getDanhSachYKien(widget.id);
                        } else if (value == null) {
                          return;
                        }
                      })
                    : showDiaLogTablet(
                        context,
                        title: S.current.cho_y_kien,
                        child: YKienBottomSheet(
                          isTablet: true,
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
                          widget.cubit.getDanhSachYKien(widget.id);
                        } else if (value == null) {
                          return;
                        }
                      });
              },
            ),
          ),
          spaceH16,
          DanhSachYKienScreen(
            cubit: widget.cubit,
          )
        ],
      ),
    );
  }
}
