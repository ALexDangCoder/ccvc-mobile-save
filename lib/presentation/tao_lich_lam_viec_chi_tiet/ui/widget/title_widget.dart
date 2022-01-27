import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWidget extends StatefulWidget {
  final String? image;
  final String title;
  final Color? color;
  final String? title2;
  final bool isColor;
  final bool isLine;
  final Widget child;

  const TitleWidget({
    Key? key,
    this.image,
    required this.title,
    this.color,
    this.title2,
    this.isColor = false,
    this.isLine = false,
    required this.child,
  }) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.5.textScale()),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (widget.isColor)
                      Container(
                        height: 12.0.textScale(),
                        width: 12.0.textScale(),
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )
                    else
                      SizedBox(
                        height: 12.0.textScale(),
                        width: 12.0.textScale(),
                        child: SvgPicture.asset(
                          widget.image ?? ImageAssets.icNhacLai,
                        ),
                      ),
                    SizedBox(
                      width: 20.5.textScale(),
                    ),
                    Text(
                      widget.title,
                      style: textNormalCustom(
                        color: dateColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title2 ?? '',
                      style: textNormalCustom(
                        color: dateColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isExpand = !isExpand;
                        setState(() {});
                      },
                      child: Icon(
                        isExpand
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_outlined,
                        color: AqiColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (widget.isLine)
            Container(
              margin: EdgeInsets.only(
                left: 32.5.textScale(),
                top: 5.0.textScale(),
              ),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: lineColor)),
              ),
            )
          else
            Container(),

          SizedBox(height: 20.0.textScale(),),
          ExpandedSection(expand: isExpand, child: widget.child),
        ],
      ),
    );
  }
}
