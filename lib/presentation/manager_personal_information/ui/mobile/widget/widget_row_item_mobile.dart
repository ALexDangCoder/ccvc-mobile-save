import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_row.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button_switch/flutter_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetRowItemMobile extends StatefulWidget {
  final ManagerPersonalInformationRow row;
  final bool isHeader;
  final Widget? header;

  const WidgetRowItemMobile({
    Key? key,
    required this.row,
    this.isHeader = false,
    this.header,
  }) : super(key: key);

  @override
  State<WidgetRowItemMobile> createState() => _WidgetRowItemMobileState();
}

class _WidgetRowItemMobileState extends State<WidgetRowItemMobile> {
  @override
  Widget build(BuildContext context) {
    final bool isContainer = widget.row.type == TypeRow.status;
    return Column(
      children: [
        spaceH10,
        if (widget.isHeader) widget.header ?? Container() else Container(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                widget.row.title,
                style: textDetailHDSD(
                  fontSize: 12.0.textScale(),
                  color: titleItemEdit,
                  textHeight: 1.7,
                ),
                maxLines: 2,
              ),
            ),
            Expanded(
              flex: 6,
              child: widget.row.type == TypeRow.text
                  ? Text(
                      '${widget.row.value}',
                      style: textDetailHDSD(
                        fontSize: 12.0.textScale(),
                        color: titleCalenderWork,
                        textHeight: 1.7,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isContainer)
                          Container(
                            decoration: const BoxDecoration(
                              color: daXuLyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 4,
                                bottom: 4,
                              ),
                              child: Text(
                                widget.row.value,
                                style: tokenDetailAmount(
                                  fontSize: 10.0.textScale(),
                                ),
                              ),
                            ),
                          )
                        else
                          customSwitch(widget.row.value, (value) {})
                      ],
                    ),
            )
          ],
        )
      ],
    );
  }

  Widget customSwitch(bool value, Function(bool) onToggle) {
    return FlutterSwitchWidget(
      height: 24,
      width: 42,
      toggleSize: 14,
      inactiveIcon: SvgPicture.asset(ImageAssets.icX),
      activeIcon: SvgPicture.asset(ImageAssets.icV),
      inactiveColor: borderColor,
      activeColor: labelColor,
      value: value,
      onToggle: onToggle,
    );
  }
}
