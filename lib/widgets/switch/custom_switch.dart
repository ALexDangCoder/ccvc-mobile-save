import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button_switch/flutter_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onToggle;

  const CustomSwitch({Key? key, required this.value, required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitchWidget(
      height: 24,
      width: 42,
      toggleSize: 14,
      inactiveIcon: SvgPicture.asset(ImageAssets.icX),
      activeIcon: SvgPicture.asset(ImageAssets.icV),
      inactiveColor: colorDBDFEF,
      activeColor: AppTheme.getInstance().colorField(),
      value: value,
      onToggle: onToggle,
    );
  }
}
