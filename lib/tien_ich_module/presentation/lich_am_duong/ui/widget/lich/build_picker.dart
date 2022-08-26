import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kItemExtent = 40.0;

const bool kUseMagnifier = true;
const double kMagnification = 1.08;
const double kDatePickerPadSize = 12.0;
const double kSqueeze = 0.7;

class BuildPickerCusTom extends StatelessWidget {
  final double offAxisFraction;
  final bool looping;
  final FixedExtentScrollController controller;
  final Color backgroundColor;
  final List<Widget> children;
  final Function(int) onSelectItem;
  final bool canBorderLeft;
  final bool canBorderRight;

  const BuildPickerCusTom({
    Key? key,
    required this.offAxisFraction,
    required this.controller,
    required this.backgroundColor,
    required this.children,
    required this.onSelectItem,
    this.canBorderRight = false,
    this.canBorderLeft = false,
    this.looping = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: controller,
      itemExtent: 40,
      useMagnifier: kUseMagnifier,
      magnification: kMagnification,
      backgroundColor: backgroundColor,
      squeeze: kSqueeze,
      diameterRatio: 3,
      selectionOverlay: CupertinoPickerDefaultSelectionOverlayWidget(
        canBorderRight: canBorderRight,
        canBorderLeft: canBorderLeft,
      ),
      onSelectedItemChanged: (int index) {
        onSelectItem(index);
      },
      looping: looping,
      children: children,
    );
  }
}

class CupertinoPickerDefaultSelectionOverlayWidget extends StatelessWidget {
  final bool canBorderLeft;
  final bool canBorderRight;

  const CupertinoPickerDefaultSelectionOverlayWidget({
    Key? key,
    this.canBorderLeft = false,
    this.canBorderRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.resolve(
          AppTheme.getInstance().colorField().withOpacity(0.1),
          context,
        ),
      ),
    );
  }
}
