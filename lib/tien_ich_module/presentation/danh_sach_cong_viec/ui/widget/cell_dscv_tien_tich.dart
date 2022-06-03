import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
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
  final Function(TextEditingController)? onChange;
  final bool isTheEdit;
  final Function()? onEdit;
  final bool isDaBiXoa;
  final Function()? onThuHoi;
  final Function()? onXoaVinhVien;
  final DanhSachCongViecTienIchCubit cubit;

  const CongViecCellTienIch(
      {Key? key,
      required this.text,
      required this.onCheckBox,
      this.onStar,
      this.onClose,
      required this.todoModel,
      this.enabled = true,
      this.borderBottom = true,
      this.onChange,
      this.isTheEdit = false,
      this.onEdit,
      this.isDaBiXoa = false,
      this.onThuHoi,
      this.onXoaVinhVien,
      required this.cubit})
      : super(key: key);

  @override
  State<CongViecCellTienIch> createState() => _CongViecCellTienIchState();
}

class _CongViecCellTienIchState extends State<CongViecCellTienIch> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.text.trim();
    focusNode.addListener(() {
      if (!focusNode.hasFocus && widget.onChange != null) {
        widget.onChange?.call(textEditingController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderButtomColor)),
      ),
      child: Column(
        children: [
          Row(
            children: [
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

                  onChanged: (value) {
                    widget.onCheckBox(value ?? false);
                  },
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Expanded(
                child: !widget.enabled
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.text,
                            style: textNormal(
                              infoColor,
                              14,
                            ).copyWith(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(right: 6),
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: textEditingController,
                          enabled: widget.enabled,
                          style: textNormal(infoColor, 14),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
              ),
              Row(
                children: [
                  if (widget.isTheEdit)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: widget.onEdit,
                        child: SvgPicture.asset(ImageAssets.icEditBlue),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: widget.onStar,
                      child: SvgPicture.asset(
                        widget.todoModel.important ?? false
                            ? ImageAssets.icStarFocus
                            : ImageAssets.icStarUnfocus,
                      ),
                    ),
                  ),
                  if (widget.isDaBiXoa)
                    GestureDetector(
                      onTap: widget.onThuHoi,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(
                          ImageAssets.ic_hoan_tac,
                        ),
                      ),
                    ),
                  if (widget.isDaBiXoa)
                    GestureDetector(
                      onTap: widget.onXoaVinhVien,
                      child: SvgPicture.asset(
                        ImageAssets.ic_delete_dscv,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          ImageAssets.icClose,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Row(
              children: [
                textUnder(
                  DateTime.parse(widget.todoModel.createdOn ?? '').formatApi,
                ),
                if (widget.todoModel.showDotOne()) circle(),
                textUnder(
                  widget.cubit.convertIdToPerson(
                    vl: widget.todoModel.performer ?? '',
                    hasChucVu: true,
                  ),
                ),
                if (widget.todoModel.showDotTwo()) circle(),
                if (widget.todoModel.showIconNote())
                  SvgPicture.asset(
                    ImageAssets.iconNote_dscv,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textUnder(String text) => Flexible(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: textDetailHDSD(fontSize: 12, color: textTitleColumn),
        ),
      );

  Widget circle() => Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: textTitleColumn,
          shape: BoxShape.circle,
        ),
      );
}
