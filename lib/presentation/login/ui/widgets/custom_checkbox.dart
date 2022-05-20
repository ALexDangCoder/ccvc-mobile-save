import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final title;
  bool isCheck;
  final Function(bool check) onChange;

  CustomCheckBox({
    Key? key,
    required this.title,
    required this.isCheck,
    required this.onChange,
  }) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18.0.textScale(),
          height: 18.0.textScale(),
          child: Checkbox(
            checkColor: Colors.white,
            // color of tick Mark
            activeColor: AppTheme.getInstance().colorField(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: const BorderSide(width: 1.5, color: colorECEEF7),
            value: widget.isCheck,
            onChanged: (value) {
              setState(() {
                widget.onChange(widget.isCheck);
              });
            },
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        Text(
          widget.title,
          style: textNormal(color3D5586, 14.0.textScale()),
        )
      ],
    );
  }
}
