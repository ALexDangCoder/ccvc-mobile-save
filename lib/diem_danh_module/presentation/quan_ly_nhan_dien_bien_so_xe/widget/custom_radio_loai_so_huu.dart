import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomRadioLoaiSoHuu extends StatefulWidget {
  final Function(bool) onChange;
  final String? groupValueInit;
  final String? errText;

  const CustomRadioLoaiSoHuu({
    Key? key,
    required this.onChange,
    this.groupValueInit,
    this.errText,
  }) : super(key: key);

  @override
  CustomRadioLoaiSoHuuState createState() => CustomRadioLoaiSoHuuState();
}

class CustomRadioLoaiSoHuuState extends State<CustomRadioLoaiSoHuu> {
  String groupValue = S.current.xe_can_bo;
  bool isShowError = false;

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValueInit ?? '';
  }

  /// return false if nothing select
  bool validator() {
    isShowError = groupValue.isEmpty;
    setState(() {});
    return groupValue.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    isShowError = false;
                    setState(() {});
                    groupValue = value ?? S.current.xe_can_bo;
                    widget.onChange(false);
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
                    isShowError = false;
                    setState(() {});
                    groupValue = value ?? S.current.xe_lanh_dao;
                    widget.onChange(true);
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
        ),
        Visibility(
          visible: isShowError,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.errText ?? S.current.chon_loai_xe,
              style: textNormal(colord32f2f, 12).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    return textDefault;
  }
}
