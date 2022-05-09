import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';

class CoolDropDown extends StatefulWidget {
  final String placeHoder;
  final String initData;
  final Function(int) onChange;
  final List<String> listData;
  final double? setWidth;

  const CoolDropDown({
    Key? key,
    this.placeHoder = '',
    required this.onChange,
    required this.listData,
    required this.initData,
    this.setWidth,
  }) : super(key: key);

  @override
  _CoolDropDownState createState() => _CoolDropDownState();
}

class _CoolDropDownState extends State<CoolDropDown> {
  final List<Map<dynamic, dynamic>> pokemonsMap = [];
  int initIndex = -1;

  @override
  void initState() {
    for (var i = 0; i < widget.listData.length; i++) {
      pokemonsMap.add({
        'label': widget.listData[i],
        'value': widget.listData[i],
        'icon': const SizedBox(),
      });
    }
    initIndex = widget.listData.indexOf(widget.initData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
      defaultValue: initIndex < 0 ? null : pokemonsMap[initIndex],
      resultWidth: MediaQuery.of(context).size.width,
      dropdownWidth: widget.setWidth ?? MediaQuery.of(context).size.width - 52,
      dropdownHeight: 120,
      resultAlign: Alignment.center,
      dropdownList: pokemonsMap,
      onChange: (value) {
        widget.onChange(pokemonsMap.indexOf(value));
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
      selectedItemBD: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(6),
      ),
      resultTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleCalenderWork,
      ),
      placeholderTS: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleCalenderWork,
      ),
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
