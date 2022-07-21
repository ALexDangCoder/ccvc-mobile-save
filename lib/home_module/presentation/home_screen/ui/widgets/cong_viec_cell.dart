import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/todo_model.dart';
import '/home_module/utils/constants/image_asset.dart';

class CongViecCell extends StatefulWidget {
  final String text;
  final bool enabled;
  final String nguoiGan;
  final bool borderBottom;
  final Function(bool) onCheckBox;
  final Function onStar;
  final Function() onClose;
  final TodoModel todoModel;
  final Function(TextEditingController)? onChange;

  const CongViecCell({
    Key? key,
    required this.text,
    required this.onCheckBox,
    required this.onStar,
    required this.onClose,
    required this.todoModel,
    this.enabled = true,
    required this.nguoiGan,
    this.borderBottom = true,
    this.onChange,
  }) : super(key: key);

  @override
  State<CongViecCell> createState() => _CongViecCellState();
}

class _CongViecCellState extends State<CongViecCell> {
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
      child: Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: Checkbox(
              checkColor: Colors.white,
              // color of tick Mark
              activeColor: AppTheme.getInstance().colorSelect(),
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
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: textNormal(infoColor, 14),
                        ),
                        Visibility(
                          visible: widget.nguoiGan.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${S.current.nguoi_gan} ${widget.nguoiGan}',
                                style: textNormal(
                                  infoColor,
                                  12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onStar();
                },
                child: (widget.todoModel.important ?? false)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: SvgPicture.asset(
                          ImageAssets.icStarFocus,
                          color: AppTheme.getInstance().colorSelect(),
                        ),
                      )
                    : Icon(
                        Icons.star_outline_rounded,
                        color: AppTheme.getInstance().colorSelect(),
                        size: 24,
                      ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  widget.onClose();
                },
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
    );
  }
}
