import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadioButtonCheck extends StatefulWidget {
  bool isCheck;
  final bool allowUnSelect;
  final bool canSelect;
  final String title;
  final Function(bool) onSelectItem;
  final bool isTheRadio;
  final bool isTheTitle;

  RadioButtonCheck({
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
  _RadioButtonCheckState createState() => _RadioButtonCheckState();
}

class _RadioButtonCheckState extends State<RadioButtonCheck> {
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
                    ? ImageAssets.ic_baocao
                    : ImageAssets.ic_chitet
                    : widget.isCheck
                    ? ImageAssets.ic_baocao
                    : ImageAssets.ic_chitet,
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
