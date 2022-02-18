import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioButtonCheck extends StatefulWidget {
  final Function() onSelectItem;
  bool isCheckButton = false;

  CustomRadioButtonCheck({
    Key? key,
    required this.onSelectItem,
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
      child: SvgPicture.asset(
        widget.isCheckButton
            ? ImageAssets.ic_CheckedDate
            : ImageAssets.ic_unChecked,
      ),
    );
  }
}
