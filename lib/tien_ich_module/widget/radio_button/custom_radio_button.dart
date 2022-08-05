import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String title;
  final Function(String) onchange;
  String? value;

  CustomRadioButton({
    Key? key,
    required this.title,
    required this.onchange,
    this.value = 'Nam',
  }) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  // String groupValue = 'Nam';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: tokenDetailAmount(
            fontSize: 16,
            color: color3D5586,
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              S.current.Nam,
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
            ),
            //bgDropDown
            leading: Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: textDefault,
              value: S.current.Nam,
              onChanged: (String? value) {
                setState(() {});
                widget.value = value ?? S.current.Nam;
                widget.onchange(widget.value ?? S.current.Nam);
              },
              groupValue: widget.value,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              S.current.Nu,
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: textDefault,
              value: S.current.Nu,
              onChanged: (String? value) {
                setState(() {});
                widget.value = value ?? S.current.Nu;
                widget.onchange(widget.value ?? S.current.Nu);
              },
              groupValue: widget.value,
            ),
          ),
        )
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    return  AppTheme.getInstance().colorField();
  }
}
