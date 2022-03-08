

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CongViecCell extends StatefulWidget {
  final String text;
  final bool enabled;
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
              checkColor: Colors.white, // color of tick Mark
              activeColor: indicatorColor,
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
                : TextFormField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    enabled: widget.enabled,
                    style: textNormal(infoColor, 14),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onStar();
                },
                child: SvgPicture.asset(
                  widget.todoModel.important ?? false
                      ? ImageAssets.icStarFocus
                      : ImageAssets.icStarUnfocus,
                ),
              ),
              const SizedBox(
                width: 20,
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
