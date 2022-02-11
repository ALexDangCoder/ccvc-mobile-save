import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioButtonCheck extends StatefulWidget {
  bool isCheck;
  final bool allowUnSelect;
  final bool canSelect;
  final String title;
  final Function(bool) onSelectItem;
  final bool isTheRadio;
  final bool isTheTitle;

  CustomRadioButtonCheck({
    Key? key,
    this.isCheck = false,
    this.title = '',
    this.allowUnSelect = false,
    required this.onSelectItem,
    required this.canSelect,
    this.isTheRadio = true,
    this.isTheTitle = true,
  }) : super(key: key);

  @override
  _CustomRadioButtonCheckState createState() => _CustomRadioButtonCheckState();
}

class _CustomRadioButtonCheckState extends State<CustomRadioButtonCheck> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.canSelect ? 1 : 0.5,
      child: GestureDetector(
        onTap: () {
          if (widget.canSelect) {
            if (widget.allowUnSelect) {
              setState(() {
                widget.isCheck = !widget.isCheck;
              });
            } else {
              if (!widget.isCheck) {
                setState(() {
                  widget.isCheck = true;
                });
              }
            }
            widget.onSelectItem(widget.isCheck);
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                widget.isTheRadio
                    ? widget.isCheck
                        ? ImageAssets.icchecked
                        : ImageAssets.icUnchecked
                    : widget.isCheck
                        ? ImageAssets.icChecked
                        : ImageAssets.icChecked2,
              ),
              if (widget.isTheTitle)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(widget.title),
                )
              else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
