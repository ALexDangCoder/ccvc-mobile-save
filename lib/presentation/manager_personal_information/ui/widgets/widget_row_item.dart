import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_row.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button_switch/flutter_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetRowItem extends StatefulWidget {
  final ManagerPersonalInformationRow row;

  const WidgetRowItem({Key? key, required this.row}) : super(key: key);

  @override
  State<WidgetRowItem> createState() => _WidgetRowItemState();
}

class _WidgetRowItemState extends State<WidgetRowItem> {
  @override
  Widget build(BuildContext context) {
    final bool isContainer = widget.row.type == TypeRow.status;
    return Column(
      children: [
        spaceH24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Text(
                widget.row.title,
                style: tokenDetailAmount(
                  fontSize: 14.0.textScale(),
                  color: titleItemEdit,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: widget.row.type == TypeRow.text
                  ? Text(
                      '${widget.row.value}',
                      style: tokenDetailAmount(
                        fontSize: 14.0.textScale(),
                        color: titleCalenderWork,
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
