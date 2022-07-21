import 'dart:developer';

import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/utils/constants/image_asset.dart';

class CongViecCellTienIch extends StatefulWidget {
  final String text;
  final bool enabled;
  final bool borderBottom;
  final Function(bool) onCheckBox;
  final Function()? onStar;
  final Function()? onClose;
  final TodoDSCVModel todoModel;
  final Function(String)? onChange;
  final Function()? onEdit;
  final Function()? onThuHoi;
  final Function()? onXoaVinhVien;
  final DanhSachCongViecTienIchCubit cubit;
  final List<int>? isEnableIcon;
  final List<int>? showIcon;

  const CongViecCellTienIch({
    Key? key,
    required this.text,
    required this.onCheckBox,
    this.onStar,
    this.onClose,
    required this.todoModel,
    this.enabled = false,
    this.borderBottom = true,
    this.onChange,
    this.onEdit,
    this.onThuHoi,
    this.onXoaVinhVien,
    required this.cubit,
    this.isEnableIcon,
    this.showIcon,
  }) : super(key: key);

  @override
  State<CongViecCellTienIch> createState() => _CongViecCellTienIchState();
}

class _CongViecCellTienIchState extends State<CongViecCellTienIch> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    log('>>>>>>>>>>>>>${widget.todoModel.finishDay}');
    final double padingIcon = MediaQuery.of(context).size.width * 0.03;
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderButtomColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            /// Widget up
            Row(
              children: [
                if (widget.showIcon?.contains(IconDSCV.icCheckBox) ?? false)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Checkbox(
                      checkColor: Colors.white,
                      // color of tick Mark
                      activeColor: AppTheme.getInstance().colorField(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      side: const BorderSide(width: 1.5, color: lineColor),
                      value: widget.todoModel.isTicked ?? false,

                      onChanged: !(widget.isEnableIcon
                                  ?.contains(IconDSCV.icCheckBox) ??
                              false)
                          ? (value) {
                              widget.onCheckBox(value ?? false);
                            }
                          : null,
                    ),
                  ),
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: !widget.enabled
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.text,
                            style: textNormal(
                              infoColor,
                              14,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(right: 6),
                          child: TextFormField(
                            focusNode: focusNode,
                            controller:
                                TextEditingController(text: widget.text),
                            enabled: true,
                            style: textNormal(infoColor, 14.0.textScale()),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (vl) {},
                            onFieldSubmitted: (vl) {
                              if (vl.isNotEmpty) {
                                widget.onChange?.call(vl);
                              }
                            },
                          ),
                        ),
                ),
                if (widget.showIcon?.contains(IconDSCV.icEdit) ?? false)
                  Padding(
                    padding: EdgeInsets.only(right: padingIcon),
                    child: GestureDetector(
                      onTap: !(widget.isEnableIcon?.contains(IconDSCV.icEdit) ??
                              false)
                          ? widget.onEdit
                          : onTapNull,
                      child: SvgPicture.asset(ImageAssets.icEditBlue),
                    ),
                  ),
                if (widget.showIcon?.contains(IconDSCV.icImportant) ?? false)
                  Padding(
                    padding: EdgeInsets.only(right: padingIcon),
                    child: GestureDetector(
                      onTap: !(widget.isEnableIcon
                                  ?.contains(IconDSCV.icImportant) ??
                              false)
                          ? widget.onStar
                          : onTapNull,
                      child: SvgPicture.asset(
                        widget.todoModel.important ?? false
                            ? ImageAssets.icStarFocus
                            : ImageAssets.icStarUnfocus,
                      ),
                    ),
                  ),
                if (widget.showIcon?.contains(IconDSCV.icHoanTac) ?? false)
                  GestureDetector(
                    onTap:
                        !(widget.isEnableIcon?.contains(IconDSCV.icHoanTac) ??
                                false)
                            ? widget.onThuHoi
                            : onTapNull,
                    child: Padding(
                      padding: EdgeInsets.only(right: padingIcon),
                      child: SvgPicture.asset(
                        ImageAssets.ic_hoan_tac,
                      ),
                    ),
                  ),
                if (widget.showIcon?.contains(IconDSCV.icXoaVinhVien) ?? false)
                  GestureDetector(
                    onTap: !(widget.isEnableIcon
                                ?.contains(IconDSCV.icXoaVinhVien) ??
                            false)
                        ? widget.onXoaVinhVien
                        : onTapNull,
                    child: Padding(
                      padding: EdgeInsets.only(right: padingIcon),
                      child: SvgPicture.asset(
                        ImageAssets.ic_delete_dscv,
                      ),
                    ),
                  ),
                if (widget.showIcon?.contains(IconDSCV.icClose) ?? false)
                  GestureDetector(
                    onTap: !(widget.isEnableIcon?.contains(IconDSCV.icClose) ??
                            false)
                        ? widget.onClose
                        : onTapNull,
                    child: SvgPicture.asset(
                      ImageAssets.icClose,
                    ),
                  )
              ],
            ),

            /// Widget down
            Padding(
              padding: const EdgeInsets.only(left: 31),
              child: Row(
                children: [
                  textUnder(
                    DateTime.parse(widget.todoModel.finishDay ?? '')
                        .toStringWithListFormat,
                  ),
                  if (widget.todoModel.showDotOne()) circleWidget(),
                  StreamBuilder<List<NguoiThucHienModel>>(
                    stream: widget.cubit.listNguoiThucHienSubject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && widget.todoModel.showDotOne()) {
                        return Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                          ),
                          padding: const EdgeInsets.only(left: 8),
                          child: textUnder(
                            widget.cubit.convertIdToPerson(
                              vl: widget.todoModel.performer ?? '',
                              hasChucVu: false,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  if (widget.todoModel.showDotTwo()) circleWidget(),
                  if (widget.todoModel.showIconNote())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SvgPicture.asset(
                        ImageAssets.iconNote_dscv,
                      ),
                    ),
                  if (widget.todoModel.showIconFile())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SvgPicture.asset(
                        ImageAssets.ic_ghim_dscv,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textUnder(String text) => Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: textDetailHDSD(fontSize: 12, color: textTitleColumn),
      );

  Widget circleWidget() => Container(
        margin: const EdgeInsets.only(left: 8, top: 4),
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: textTitleColumn,
          shape: BoxShape.circle,
        ),
      );
}
