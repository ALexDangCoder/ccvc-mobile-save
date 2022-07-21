import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down/cool_drop_down_custom.dart';
import 'package:flutter/material.dart';

class CoolDropDown extends StatefulWidget {
  final String placeHoder;
  final String initData;
  final Function(int) onChange;
  final List<String> listData;
  final double? setWidth;
  final int maxLines;
  final bool showSelectedDecoration;
  final bool useCustomHintColors;
  final Widget? selectedIcon;
  final bool needReInitData;

  const CoolDropDown({
    Key? key,
    this.placeHoder = '',
    required this.onChange,
    required this.listData,
    required this.initData,
    this.setWidth,
    this.maxLines = 1,
    this.showSelectedDecoration = true,
    this.selectedIcon,
    this.useCustomHintColors = false,
    this.needReInitData = false,
  }) : super(key: key);

  @override
  _CoolDropDownState createState() => _CoolDropDownState();
}

class _CoolDropDownState extends State<CoolDropDown> {
  final List<Map<dynamic, dynamic>> listSelect = [];
  int initIndex = -1;

  @override
  void initState() {
    for (var i = 0; i < widget.listData.length; i++) {
      listSelect.add({
        'label': widget.listData[i],
        'value': widget.listData[i],
        'icon': const SizedBox(),
      });
    }
    initIndex = widget.listData.indexOf(widget.initData);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CoolDropDown oldWidget) {
    if (widget.needReInitData && listSelect.isEmpty) {
      for (var i = 0; i < widget.listData.length; i++) {
        listSelect.add({
          'label': widget.listData[i],
          'value': widget.listData[i],
          'icon': const SizedBox(),
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
      maxLines: widget.maxLines,
      defaultValue: initIndex < 0 ? null : listSelect[initIndex],
      // resultWidth: MediaQuery.of(context).size.width,
      // dropdownWidth: widget.setWidth ?? MediaQuery.of(context).size.width - 52,
      dropdownHeight: 200,
      resultAlign: Alignment.center,
      dropdownList: listSelect,
      onChange: (value) {
        widget.onChange(listSelect.indexOf(value));
      },
      placeholder: widget.placeHoder,
      selectedItemTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleCalenderWork,
      ),
      unselectedItemTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleCalenderWork,
      ),
      selectedItemBD: widget.showSelectedDecoration
          ? BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(6),
            )
          : const BoxDecoration(),
      resultTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleCalenderWork,
      ),
      placeholderTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: widget.useCustomHintColors
            ? titleCalenderWork.withOpacity(0.5)
            : titleCalenderWork,
      ),
      selectedIcon: widget.selectedIcon,
      resultBD: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      dropdownBD: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        border: Border.all(color: borderColor),
      ),
      isTriangle: false,
      gap: 1.0,
      // resultWidth: 800,
    );
  }
}
