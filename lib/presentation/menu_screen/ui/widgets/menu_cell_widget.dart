import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuCellWidget extends StatefulWidget {
  final String urlIcon;
  final String title;
  final bool isBorder;
  final bool initSwitchButton;
  final bool isSwitchButton;
  final Function(bool)? switchFunction;

  const MenuCellWidget({
    Key? key,
    required this.title,
    required this.urlIcon,
    this.isBorder = true,
    this.initSwitchButton=false,
    this.isSwitchButton = false,
    this.switchFunction,
  }) : super(key: key);

  @override
  State<MenuCellWidget> createState() => _MenuCellWidgetState();
}

class _MenuCellWidgetState extends State<MenuCellWidget> {
  bool isCheck=false;
  @override
  void initState() {
    super.initState();
    isCheck = widget.initSwitchButton;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: widget.isBorder ? colorECEEF7 : Colors.transparent),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(widget.urlIcon),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: textNormal(
                    AppTheme.getInstance().titleColor(),
                    14.0.textScale(),
                  ),
                ),
                if (!widget.isSwitchButton) const Icon(
                  Icons.navigate_next,
                  color: colorA2AEBD,
                ) else CustomSwitch(
                  value: isCheck ,
                  onToggle: (bool value) {
                    isCheck = value;
                    widget.switchFunction?.call(isCheck);
                    setState(() {

                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
