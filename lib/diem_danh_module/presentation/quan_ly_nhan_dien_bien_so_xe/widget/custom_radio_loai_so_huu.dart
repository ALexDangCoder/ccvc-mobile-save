import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRadioLoaiSoHuu extends StatefulWidget {
  final Function(bool) onchange;
  final String? groupValueInit;

  const CustomRadioLoaiSoHuu({
    Key? key,
    required this.onchange,
    this.groupValueInit,
  }) : super(key: key);

  @override
  _CustomRadioLoaiSoHuuState createState() => _CustomRadioLoaiSoHuuState();
}

class _CustomRadioLoaiSoHuuState extends State<CustomRadioLoaiSoHuu> {
  String groupValue = S.current.xe_can_bo;

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValueInit ?? S.current.xe_can_bo;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: textDefault,
              value: S.current.xe_can_bo,
              onChanged: (String? value) {
                setState(() {});
                groupValue = value ?? S.current.xe_can_bo;
                widget.onchange(false);
              },
              groupValue: groupValue,
            ),
            Text(
              S.current.xe_can_bo,
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
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              activeColor: textDefault,
              value: S.current.xe_lanh_dao,
              onChanged: (String? value) {
                setState(() {});
                groupValue = value ?? S.current.xe_lanh_dao;
                widget.onchange(true);
              },
              groupValue: groupValue,
            ),
            Text(
              S.current.xe_lanh_dao,
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
    return textDefault;
  }
}
