import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/material.dart';

class ExpandOnlyHuongDanSuDung extends StatefulWidget {
  final String name;
  final Widget child;
  bool? isTablet;
 final Function onTap;

  ExpandOnlyHuongDanSuDung(
      {Key? key, required this.name, required this.child, this.isTablet, required this.onTap,})
      : super(key: key);

  @override
  _ExpandOnlyHuongDanSuDungState createState() =>
      _ExpandOnlyHuongDanSuDungState();
}

class _ExpandOnlyHuongDanSuDungState extends State<ExpandOnlyHuongDanSuDung> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0.textScale()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap();
              isExpand = !isExpand;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.textScale(space: 4),
                vertical: 10.5.textScale(space: 4),
              ),
              decoration: BoxDecoration(
                color: widget.isTablet ?? false
                    ? colorFFFFFF
                    : colorDBDFEF.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
                          style: textNormalCustom(
                            color: color3D5586,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0.textScale(),
                          ),
                          softWrap: true,
                        ),
                      ),
                      Icon(
                        isExpand
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_outlined,
                        color: colorA2AEBD,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ExpandedSection(
                      expand: isExpand,
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
