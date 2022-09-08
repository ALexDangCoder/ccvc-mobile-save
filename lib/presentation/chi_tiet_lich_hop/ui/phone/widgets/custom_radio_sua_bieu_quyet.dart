import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRadioSuaBieuQuyet extends StatefulWidget {
  final String title;
  final Function(bool) onchange;
  final String initValue;

  const CustomRadioSuaBieuQuyet({
    Key? key,
    required this.title,
    required this.onchange,
    required this.initValue,
  }) : super(key: key);

  @override
  _CustomRadioSuaBieuQuyetState createState() =>
      _CustomRadioSuaBieuQuyetState();
}

class _CustomRadioSuaBieuQuyetState extends State<CustomRadioSuaBieuQuyet> {
  String groupValue = '';

  @override
  void initState() {
    groupValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: tokenDetailAmount(
            color: dateColor,
            fontSize: 14.0,
          ),
        ),
        Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: AppTheme.getInstance().colorSelect(),
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
              activeColor: textDefault,
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
    return AppTheme.getInstance().colorSelect();
  }
}
