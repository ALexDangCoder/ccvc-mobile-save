import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/material.dart';

class ExpandOnlyNhiemVu extends StatefulWidget {
  final String name;
  final Widget child;

  const ExpandOnlyNhiemVu({
    Key? key,
    required this.name,
    required this.child,
  }) : super(key: key);

  @override
  _ExpandOnlyNhiemVuState createState() => _ExpandOnlyNhiemVuState();
}

class _ExpandOnlyNhiemVuState extends State<ExpandOnlyNhiemVu> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isExpand = !isExpand;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0.textScale()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.textScale(space: 4),
                vertical: 10.5.textScale(space: 4),
              ),
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.1),
                border: Border.all(color: borderColor.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                  Icon(
                    isExpand
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_up_rounded,
                    color: AqiColor,
                  ),
                ],
              ),
            ),
            ExpandedSection(
              expand: isExpand,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
