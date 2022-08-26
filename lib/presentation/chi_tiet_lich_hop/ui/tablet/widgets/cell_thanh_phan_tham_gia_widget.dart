import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellThanhPhanThamGia extends StatefulWidget {
  final CanBoModel infoModel;
  final ThanhPhanThamGiaHopCubit cubit;
  final Function()? ontap;
  final bool diemDanh;

  const CellThanhPhanThamGia({
    Key? key,
    required this.infoModel,
    required this.cubit,
    this.ontap,
    this.diemDanh = true,
  }) : super(key: key);

  @override
  State<CellThanhPhanThamGia> createState() => _CellThanhPhanThamGiaState();
}

class _CellThanhPhanThamGiaState extends State<CellThanhPhanThamGia> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor.withOpacity(0.5)),
          color: colorNumberCellQLVB,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            widgetRow(
              name: S.current.ten_don_vi,
              child: Row(
                children: [
                  Expanded(
                    child: textCell(widget.infoModel.tenCoQuan ?? ''),
                  ),
                  if (widget.diemDanh)
                    Container(
                      child: widget.infoModel.showCheckBox()
                          ? CustomCheckBox(
                        isOnlyCheckbox: true,
                        isCheck: widget.cubit.diemDanhIds
                            .contains(widget.infoModel.id ?? ''),
                        onChange: (isCheck) {
                          widget.cubit.addOrRemoveId(
                            isSelected: !isCheck,
                            id: widget.infoModel.id ?? '',
                          );
                          setState(() {});
                        },
                      )
                          : GestureDetector(
                        onTap: widget.ontap,
                              child: SvgPicture.asset(
                                ImageAssets.ic_huyDiemDanh,
                                color: AppTheme.getInstance().colorField(),
                              ),
                            ),
                    ),
                ],
              ),
            ),
            widgetRow(
              name: S.current.ten_can_bo,
              child: textCell(widget.infoModel.titleCanBo()),
            ),
            widgetRow(
              name: S.current.vai_tro,
              child: textCell(widget.infoModel.getNameVaiTro()),
            ),
            widgetRow(
              name: S.current.noi_dung_cong_viec,
              child: textCell(widget.infoModel.ghiChu ?? ''),
            ),
            widgetRow(
              name: S.current.trang_thai,
              child: borderCellStatus(
                text: widget.infoModel.trangThaiTPTG(),
                color: widget.infoModel.trangThaiColor(),
              ),
            ),
            widgetRow(
              name: S.current.diem_danh,
              child: borderCellStatus(
                text: widget.infoModel.diemDanhTPTG(),
                color: widget.infoModel.diemDanhColors(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget borderCellStatus({
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: color,
          ),
          child: Text(
            text,
            style: textNormalCustom(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget textCell(String text) => Text(
        text,
        style: textNormalCustom(
          fontSize: 14,
          color: infoColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
