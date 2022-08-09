import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerMenuDSCVWidget extends StatefulWidget {
  final String name;
  final String? icon;
  final bool isIcon;
  final bool isTypeContainer;
  final TypeContainer type;
  final Widget? childExpand;
  final Function()? onTap;

  const ContainerMenuDSCVWidget({
    Key? key,
    required this.name,
    this.icon,
    this.isIcon = true,
    this.type = TypeContainer.number,
    this.isTypeContainer = true,
    this.childExpand,
    this.onTap,
  }) : super(key: key);

  @override
  State<ContainerMenuDSCVWidget> createState() =>
      _ContainerMenuDSCVWidgetState();
}

class _ContainerMenuDSCVWidgetState extends State<ContainerMenuDSCVWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Column(
        children: [
          GestureDetector(
            onTap: () {
              isExpand = !isExpand;
              setState(() {});
              widget.onTap;
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.0.textScale(),
                vertical: 8.0.textScale(),
              ),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.isIcon)
                          widget.icon != null
                              ? SizedBox(
                                  height: 15.0.textScale(space: 8),
                                  width: 15.0.textScale(space: 8),
                                  child: SvgPicture.asset(
                                    widget.icon ?? '',
                                    color: AqiColor,
                                  ),
                                )
                              : SizedBox(
                                  height: 15.0.textScale(space: 8),
                                  width: 15.0.textScale(space: 8),
                                )
                        else
                          const SizedBox(
                            height: 15,
                            width: 15,
                          ),
                        SizedBox(
                          width: 10.0.textScale(),
                        ),
                        Expanded(
                          child: Text(
                            widget.name,
                            style: textNormalCustom(
                              color: backgroundColorApp,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0.textScale(space: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isTypeContainer)
                    if (widget.type == TypeContainer.number)
                      const SizedBox()
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
      ),
      tabletScreen: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, left: 10, right: 10),
            decoration: BoxDecoration(
              color: toDayColor.withOpacity(0.1),
              border: Border.all(
                color: toDayColor.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                isExpand = !isExpand;
                setState(() {});
                widget.onTap;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.0.textScale(),
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
                            widget.icon != null
                                ? SizedBox(
                                    height: 15.0.textScale(space: 8),
                                    width: 15.0.textScale(space: 8),
                                    child: SvgPicture.asset(
                                      widget.icon ?? '',
                                      color:
                                          AppTheme.getInstance().colorField(),
                                    ),
                                  )
                                : SizedBox(
                                    height: 15.0.textScale(space: 8),
                                    width: 15.0.textScale(space: 8),
                                  )
                          else
                            const SizedBox(
                              height: 15,
                              width: 15,
                            ),
                          SizedBox(
                            width: 16.0.textScale(),
                          ),
                          Expanded(
                            child: Text(
                              widget.name,
                              style: textNormalCustom(
                                color: color3D5586,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0.textScale(space: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.isTypeContainer)
                      if (widget.type == TypeContainer.number)
                        const SizedBox()
                      else
                        Icon(
                          isExpand
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_rounded,
                          // color: AqiColor,
                        )
                  ],
                ),
              ),
            ),
          ),
          if (widget.type == TypeContainer.expand)
            ExpandedSection(
              expand: isExpand,
              child: widget.childExpand ?? Container(),
            ),
        ],
      ),
    );
  }
}
