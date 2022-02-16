import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonWidget extends StatefulWidget {
  final Function onPressed1;
  final Function onPressed2;

  const DoubleButtonWidget({
    Key? key,
    required this.onPressed1,
    required this.onPressed2,
  }) : super(key: key);

  @override
  State<DoubleButtonWidget> createState() => _DoubleButtonWidgetState();
}

class _DoubleButtonWidgetState extends State<DoubleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onPressed1();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
                color: itemWidgetUsing.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  S.current.tham_gia,
                  style: textNormalCustom(
                    fontSize: 14.0.textScale(space: 4.0),
                    color: textTitle,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0.textScale(space: 8.0)),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onPressed2();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0.textScale(space: 4.0)),
                color: statusCalenderRed.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  S.current.huy,
                  style: textNormalCustom(
                    fontSize: 14.0.textScale(space: 4.0),
                    color: textTitle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
