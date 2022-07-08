import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.textScale(),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: toDayColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: colorImageLichHop,
              isExpanded: true,
              elevation: 0,
              value: valueChoose,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (value) {
                widget.onChange.call(0);
                valueChoose = value as String?;
                setState(() {});
              },
              hint: Text(
                widget.hint,
                style: textNormalCustom(
                  color: titleItemEdit,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              items: widget.listData
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: textNormalCustom(
                          fontWeight: FontWeight.w400,
                          color: textTitle,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
