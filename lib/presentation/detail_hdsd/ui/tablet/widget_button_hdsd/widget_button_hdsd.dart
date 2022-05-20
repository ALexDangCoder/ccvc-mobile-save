import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetButtonHDSD extends StatefulWidget {
  final bool isColorBlue;
  final String title;
  final Function onPressed;
  final double? size;
  final double? top;

  final double? bottom;

  final double? left;

  final double? right;

  const WidgetButtonHDSD({
    Key? key,
    required this.isColorBlue,
    required this.title,
    this.size,
    required this.onPressed,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  _WidgetButtonHDSDState createState() => _WidgetButtonHDSDState();
}

class _WidgetButtonHDSDState extends State<WidgetButtonHDSD> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          child: Container(
            padding: EdgeInsets.only(
              left: widget.left ?? 0,
              right: widget.right ?? 0,
              top: widget.top ?? 0,
              bottom: widget.bottom ?? 0,
            ),
            height: 40.0.textScale(space: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
              color: widget.isColorBlue ? color7966FF : color1A7966FF,
            ),
            child: Center(
              child: Text(
                widget.title,
                style: textNormalCustom(
                  fontSize: widget.size ?? 14.0.textScale(space: 4.0),
                  color: widget.isColorBlue ? colorFFFFFF : color7966FF,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
