import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CellThanhPhanThamGia extends StatefulWidget {
  final CanBoModel infoModel;
  final DetailMeetCalenderCubit cubit;
  final Function()? ontap;

  CellThanhPhanThamGia(
      {Key? key, required this.infoModel, required this.cubit, this.ontap})
      : super(key: key);

  @override
  State<CellThanhPhanThamGia> createState() => _CellThanhPhanThamGiaState();
}

class _CellThanhPhanThamGiaState extends State<CellThanhPhanThamGia> {
  @override
  Widget build(BuildContext context) {
    final isChecked = widget.cubit.checkIsSelected(widget.infoModel.id ?? '');
    return screenDevice(
      mobileScreen: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
            color: colorFCFDFD,
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
                    Text(
                      '${widget.infoModel.tenCoQuan}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: color667793,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    if (widget.infoModel.showCheckBox())
                      CustomCheckBox(
                        title: '',
                        isCheck: isChecked,
                        onChange: (isCheck) {
                          widget.cubit.addOrRemoveId(
                            isSelected: isChecked,
                            id: widget.infoModel.id ?? '',
                          );
                          // widget.cubit.checkAllSelect();
                          setState(() {});
                        },
                      )
                    else
                      GestureDetector(
                        onTap: widget.ontap,
                        child: SvgPicture.asset(ImageAssets.ic_huyDiemDanh),
                      )
                  ],
                ),
              ),
              widgetRow(
                name: S.current.ten_can_bo,
                child: Row(
                  children: [
                    Text(
                      '${widget.infoModel.tenCanBo}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: color667793,
                      ),
                    ),
                  ],
                ),
              ),
              widgetRow(
                name: S.current.vai_tro,
                child: Row(
                  children: [
                    Text(
                      '${widget.infoModel.vaiTro}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: color667793,
                      ),
                    ),
                  ],
                ),
              ),
              widgetRow(
                name: S.current.noi_dung_cong_viec,
                child: Row(
                  children: [
                    Text(
                      '${widget.infoModel.ghiChu}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: color667793,
                      ),
                    ),
                  ],
                ),
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
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
            color: colorFCFDFD,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  if (widget.infoModel.showCheckBox())
                    CustomCheckBox(
                      title: '',
                      isCheck: isChecked,
                      onChange: (isCheck) {
                        widget.cubit.addOrRemoveId(
                          isSelected: isChecked,
                          id: widget.infoModel.id ?? '',
                        );
                        // widget.cubit.checkAllSelect();
                        setState(() {});
                      },
                    ),
                  Text(
                    '${S.current.ten_can_bo}: ${widget.infoModel.tenCanBo}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: color667793,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  if (!widget.infoModel.showCheckBox())
                    GestureDetector(
                      onTap: widget.ontap,
                      child: SvgPicture.asset(ImageAssets.ic_huyDiemDanh),
                    )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        widgetRow(
                          name: S.current.vai_tro,
                          child: Text(
                            '${widget.infoModel.vaiTro}',
                            style: textNormalCustom(
                              fontSize: 14,
                              color: color667793,
                            ),
                          ),
                        ),
                        widgetRow(
                          name: S.current.noi_dung,
                          child: Text(
                            '${widget.infoModel.ghiChu}',
                            style: textNormalCustom(
                              fontSize: 14,
                              color: color667793,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
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
                  )
                ],
              ),
            ],
          ),
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
}
