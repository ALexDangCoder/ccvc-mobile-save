import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button_switch/flutter_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSwitchWidget extends StatefulWidget {
  final bool value;
  final Function(bool) onToggle;

  const CustomSwitchWidget(
      {Key? key, required this.value, required this.onToggle})
      : super(key: key);

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.current.cong_khai_lich,
          style: textNormal(titleColumn, 16.0.textScale()),
        ),
        FlutterSwitchWidget(
          height: 24,
          width: 42,
          toggleSize: 14,
          inactiveIcon: SvgPicture.asset(ImageAssets.icX),
          activeIcon: SvgPicture.asset(ImageAssets.icV),
          inactiveColor: borderColor,
          activeColor: AppTheme.getInstance().colorField(),
          value: value,
          onToggle: (v) {
            setState(() {
              value = v;
            });
            widget.onToggle(v);
          },
        ),
      ],
    );
  }
}
