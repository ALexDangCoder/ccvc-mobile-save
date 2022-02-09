import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioButtonCheck extends StatefulWidget {
  bool isCheck;
  final bool allowUnSelect;
  final bool canSelect;
  final String title;
  final Function(bool) onSelectItem;

  CustomRadioButtonCheck({
    Key? key,
    this.isCheck = false,
    this.title = '',
    this.allowUnSelect = false,
    required this.onSelectItem,
    required this.canSelect,
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
                widget.isCheck ? ImageAssets.icchecked : ImageAssets.icUnchecked,
              ),
              const SizedBox(width: 10),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}
