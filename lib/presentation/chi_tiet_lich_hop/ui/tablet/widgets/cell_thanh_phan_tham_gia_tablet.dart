import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thanh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellThanhPhanThamGia extends StatefulWidget {
  final ThanhPhanThamGiaModel infoModel;
  final DetailMeetCalenderCubit cubit;

  CellThanhPhanThamGia({Key? key, required this.infoModel, required this.cubit})
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
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor.withOpacity(0.5)),
            color: colorNumberCellQLVB,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.ten_don_vi}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.ten_can_bo}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.vai_tro}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.noi_dung_cong_viec}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.trang_thai}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.diem_danh}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${widget.infoModel.tenDonVi}',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.tebCanBo}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.vaiTro}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.ndCongViec}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.trangThai}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.diemDanh}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomCheckBox(
                title: '',
                isCheck: isChecked,
                onChange: (isCheck) {
                  widget.cubit.addOrRemoveId(
                    isSelected: isChecked,
                    id: widget.infoModel.id ?? '',
                  );
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor.withOpacity(0.5)),
            color: colorNumberCellQLVB,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
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
                          '${S.current.ten_can_bo}:',
                          style: textNormalCustom(
                            fontSize: 16,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.ten_don_vi}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.vai_tro}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.noi_dung}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.tebCanBo}',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.tenDonVi}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.vaiTro}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.ndCongViec}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.trang_thai}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.diem_danh}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.trangThai}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${widget.infoModel.diemDanh}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
