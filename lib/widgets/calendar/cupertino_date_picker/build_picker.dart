import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildPicker extends StatelessWidget {
  final double offAxisFraction;
  final bool looping;
  final FixedExtentScrollController controller;
  final Color backgroundColor;
  final List<Widget> children;
  final Function(int) onSelectItem;
  final bool canBorderLeft;
  final bool canBorderRight;

  const BuildPicker(
      {Key? key,
      required this.offAxisFraction,
      required this.controller,
      required this.backgroundColor,
      required this.children,
      required this.onSelectItem,
      this.canBorderRight = false,
      this.canBorderLeft = false,
      this.looping = true})
      : super(key: key);

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
  static const double _border = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft:
              canBorderLeft ? const Radius.circular(_border) : Radius.zero,
          topLeft: canBorderLeft ? const Radius.circular(_border) : Radius.zero,
          bottomRight:
              canBorderRight ? const Radius.circular(_border) : Radius.zero,
          topRight:
              canBorderRight ? const Radius.circular(_border) : Radius.zero,
        ),
        color: CupertinoDynamicColor.resolve(
          AppTheme.getInstance().colorField().withOpacity(0.1),
          context,
        ),
      ),
    );
  }
}
