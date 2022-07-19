import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DropDownWidget extends StatefulWidget {
  final String title;
  final String hint;
  final bool isNote;
  final Function(int) onChange;
  final List<String> listData;

  const DropDownWidget({
    Key? key,
    required this.title,
    required this.hint,
    this.isNote = false,
    required this.listData,
    required this.onChange,
  }) : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? valueChoose;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: textNormalCustom(
                color: titleItemEdit,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
              ),
            ),
            if (widget.isNote)
              Text(
                ' *',
                style: textNormalCustom(
                  color: Colors.red,
                ),
              )
            else
              Container(),
          ],
        ),
        SizedBox(
          height: 10.0.textScale(),
        ),
        CoolDropDown(
          useCustomHintColors: true,
          initData: '',
          placeHoder: widget.hint,
          onChange: (value) {
            widget.onChange.call(value);
          },
          listData: widget.listData,
        ),
      ],
    );
  }
}
