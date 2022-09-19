import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down/cool_drop_down_custom.dart';
import 'package:flutter/material.dart';

class CoolDropDownItem {
  String label;
  String value;

  CoolDropDownItem({
    required this.label,
    required this.value,
  });
}

class CoolDropDown extends StatefulWidget {
  final String placeHoder;
  final String initData;
  final Function(int) onChange;
  final List<String> listData;
  final List<CoolDropDownItem>? listDataWithValue;
  final double? setWidth;
  final int maxLines;
  final bool showSelectedDecoration;
  final bool useCustomHintColors;
  final Widget? selectedIcon;
  final bool needReInitData;
  final double? fontSize;

  const CoolDropDown({
    Key? key,
    this.placeHoder = '',
    required this.onChange,
    required this.listData,
    this.listDataWithValue,
    required this.initData,
    this.setWidth,
    this.maxLines = 1,
    this.showSelectedDecoration = true,
    this.selectedIcon,
    this.useCustomHintColors = false,
    this.needReInitData = false,
    this.fontSize,
  }) : super(key: key);

  @override
  CoolDropDownState createState() => CoolDropDownState();
}

class CoolDropDownState extends State<CoolDropDown> {
  final List<Map<dynamic, dynamic>> listSelect = [];
  int initIndex = -1;
  final _dropKey = GlobalKey<CoolDropdownState>();

  @override
  void initState() {
    initListSelect();
    getCurrentIndex();
    super.initState();
  }

  void getCurrentIndex() {
    if (widget.listDataWithValue != null) {
      initIndex = widget.listDataWithValue!.indexWhere(
        (element) => element.value == widget.initData,
      );
    } else {
      initIndex = widget.listData.indexOf(widget.initData);
    }
  }

  @override
  void didUpdateWidget(covariant CoolDropDown oldWidget) {
    if (widget.needReInitData && listSelect.isEmpty) {
      initListSelect();
    }
    super.didUpdateWidget(oldWidget);
  }
  void initListSelect() {
    if (widget.listDataWithValue != null) {
      for (var i = 0; i < widget.listDataWithValue!.length; i++) {
        listSelect.add({
          'label': widget.listDataWithValue![i].label,
          'value': widget.listDataWithValue![i].value,
          'icon': const SizedBox(),
        });
      }
    } else {
      for (var i = 0; i < widget.listData.length; i++) {
        listSelect.add({
          'label': widget.listData[i],
          'value': widget.listData[i],
          'icon': const SizedBox(),
        });
      }
    }
  }


  void initData({required List<String> data, required String value}) {
    listSelect.clear();
    for (var i = 0; i < widget.listData.length; i++) {
      listSelect.add({
        'label': widget.listData[i],
        'value': widget.listData[i],
        'icon': const SizedBox(),
      });
    }
    initIndex = widget.listData.indexOf(widget.initData);
    _dropKey.currentState?.initData(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
      key: _dropKey,
      maxLines: widget.maxLines,
      defaultValue: initIndex < 0 ? null : listSelect[initIndex],
      dropdownHeight: 200,
      resultAlign: Alignment.center,
      dropdownList: listSelect,
      onChange: (value) {
        widget.onChange(listSelect.indexOf(value));
      },
      placeholder: widget.placeHoder,
      selectedItemTS: tokenDetailAmount(
        fontSize: widget.fontSize ?? 14.0.textScale(),
        color: titleCalenderWork,
      ),
      unselectedItemTS: tokenDetailAmount(
        fontSize: widget.fontSize ?? 14.0.textScale(),
        color: titleCalenderWork,
      ),
      selectedItemBD: widget.showSelectedDecoration
          ? BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(6),
            )
          : const BoxDecoration(),
      resultTS: tokenDetailAmount(
        fontSize: widget.fontSize ?? 14.0.textScale(),
        color: titleCalenderWork,
      ),
      placeholderTS: tokenDetailAmount(
        fontSize: widget.fontSize ?? 14.0.textScale(),
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
    );
  }
}
