import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioButtonCheck extends StatefulWidget {
  final Function() onSelectItem;
  bool isCheckButton;
  final String? name;

  CustomRadioButtonCheck({
    Key? key,
    required this.onSelectItem,
    required this.name,
    this.isCheckButton = false,
  }) : super(key: key);

  @override
  _CustomRadioButtonCheckState createState() => _CustomRadioButtonCheckState();
}

class _CustomRadioButtonCheckState extends State<CustomRadioButtonCheck> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelectItem();
        widget.isCheckButton = !widget.isCheckButton;
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name ?? '',
              style: tokenDetailAmount(
                color: color3D5586,
                fontSize: 14,
              ),
            ),
            SvgPicture.asset(
              widget.isCheckButton
                  ? ImageAssets.ic_CheckedDate
                  : ImageAssets.ic_unChecked,
              color: AppTheme.getInstance().colorField(),
            ),
          ],
        ),
      ),
    );
  }
}
