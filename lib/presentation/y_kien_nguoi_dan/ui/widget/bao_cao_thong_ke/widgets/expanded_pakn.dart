import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/material.dart';

class ExpandPAKNWidget extends StatefulWidget {
  final String name;
  final Widget child;
  final Function(bool isExpand)? isFuncExpand;
  const ExpandPAKNWidget({
    Key? key,
    required this.name,
    required this.child,
    this.isFuncExpand,
  }) : super(key: key);

  @override
  _ExpandPAKNWidgetState createState() => _ExpandPAKNWidgetState();
}

class _ExpandPAKNWidgetState extends State<ExpandPAKNWidget> {
  bool isExpand = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                widget.name,
                style: textNormalCustom(
                  color: textTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.textScale(),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  isExpand = !isExpand;
                  if(widget.isFuncExpand != null) widget.isFuncExpand!(isExpand);
                  setState(() {});
                },
                child: Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_outlined,
                  color: AqiColor,
                ),
              ),
            ),
          ],
        ),
        ExpandedSection(
          expand: isExpand,
          child: widget.child,
        ),
      ],
    );
  }
}
