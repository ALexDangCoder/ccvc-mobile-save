import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class WidgetItem extends StatefulWidget {
  final String content;
  final Color borderColor;
  final Color backgroundColor;
  final Function clickICon;
  final Widget widgetIcon;

  const WidgetItem({
    Key? key,
    required this.content,
    required this.borderColor,
    required this.backgroundColor,
    required this.clickICon,
    required this.widgetIcon,
  }) : super(key: key);

  @override
  _WidgetItemState createState() => _WidgetItemState();
}

class _WidgetItemState extends State<WidgetItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DottedBorder(
        color: widget.borderColor,
        dashPattern: const [5, 5],
        strokeWidth: 2,
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        child: Container(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  Text(
                    widget.content,
                    style: textNormal(textTitle, 16),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.clickICon();
                },
                //  child: widget.widgetIcon,
                icon: widget.widgetIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
