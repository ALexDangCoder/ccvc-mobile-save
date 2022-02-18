import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TypeContainer { expand, number }

class ContainerMenuWidget extends StatefulWidget {
  final String name;
  final String icon;
  final bool isIcon;
  final int index;
  final bool isTypeContainer;
  final TypeContainer type;
  final Widget? childExpand;
  final Function onTap;

  const ContainerMenuWidget({
    Key? key,
    required this.name,
    required this.icon,
    this.isIcon = true,
    this.type = TypeContainer.number,
    this.index = 0,
    this.isTypeContainer = true,
    this.childExpand,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ContainerMenuWidget> createState() => _ContainerMenuWidgetState();
}

class _ContainerMenuWidgetState extends State<ContainerMenuWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
            widget.onTap();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 17.0.textScale(),
              vertical: 12.0.textScale(),
            ),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (widget.isIcon)
                        SizedBox(
                          height: 15.0.textScale(space: 8),
                          width: 15.0.textScale(space: 8),
                          child: SvgPicture.asset(
                            widget.icon,
                            color: Colors.grey,
                          ),
                        )
                      else
                        const SizedBox(
                          height: 15,
                          width: 15,
                        ),
                      SizedBox(
                        width: 14.0.textScale(),
                      ),
                      Expanded(
                        child: Text(
                          widget.name,
                          style: textNormalCustom(
                            color: textTitle,
                            fontSize: 16.0.textScale(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12,),

                if (widget.isTypeContainer)
                  if (widget.type == TypeContainer.number)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: numberColorTabletbg,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.index.toString(),
                        style: textNormalCustom(
                          color: textDefault,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0.textScale(),
                        ),
                      ),
                    )
                  else
                    Icon(
                      isExpand
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_rounded,
                      color: AqiColor,
                    )
              ],
            ),
          ),
        ),
        if (widget.type == TypeContainer.expand)
          ExpandedSection(
            expand: isExpand,
            child: widget.childExpand ?? Container(),
          ),
      ],
    );
  }
}
