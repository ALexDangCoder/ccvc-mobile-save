import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRadioButtons extends StatefulWidget {
  final String title;
  final Function(bool) onchange;

  const CustomRadioButtons({
    Key? key,
    required this.title,
    required this.onchange,
  }) : super(key: key);

  @override
  _CustomRadioButtonsState createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons> {
  String groupValue = S.current.bo_khieu_kin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: tokenDetailAmount(
            color: color667793,
            fontSize: 14.0,
          ),
        ),
        Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: color7966FF,
              value: S.current.bo_khieu_kin,
              onChanged: (String? value) {
                setState(() {});
                groupValue = value ?? S.current.bo_khieu_kin;
                widget.onchange(false);
              },
              groupValue: groupValue,
            ),
            Text(
              S.current.bo_khieu_kin,
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
            )
          ],
        ),
        Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: color7966FF,
              value: S.current.bo_phieu_cong_khai,
              onChanged: (String? value) {
                setState(() {});
                groupValue = value ?? S.current.bo_phieu_cong_khai;
                widget.onchange(true);
              },
              groupValue: groupValue,
            ),
            Text(
              S.current.bo_phieu_cong_khai,
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
            )
          ],
        )
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    return color7966FF;
  }
}
