import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBox extends StatefulWidget {
  final Function() onSelectItem;
  bool isCheckButton = false;

  CustomCheckBox({
    Key? key,
    required this.onSelectItem,
    this.isCheckButton = false,
  }) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelectItem();
        widget.isCheckButton = !widget.isCheckButton;
      },
      child: SvgPicture.asset(
        widget.isCheckButton ? ImageAssets.icCheck : ImageAssets.icCheck,
      ),
    );
  }
}
