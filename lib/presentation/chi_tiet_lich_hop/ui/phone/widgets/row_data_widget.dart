import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class RowDataWidget extends StatelessWidget {
  final String keyTxt;
  final String value;
  final bool isStatus;
  final Color? color;

  const RowDataWidget({
    Key? key,
    required this.keyTxt,
    required this.value,
    this.isStatus = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            keyTxt,
            style: textNormal(infoColor, 14.0.textScale()),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          flex: 7,
          child: isStatus
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: color ?? Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                    child: Text(
                      value,
                      style: textNormalCustom(
                          color: backgroundColorApp, fontSize: 12),
                    ),
                  ),
                )
              : Text(
                  value,
                  style: textNormal(color3D5586, 14.0.textScale()),
                ),
        )
      ],
    );
  }
}
