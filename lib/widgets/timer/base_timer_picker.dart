import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/material.dart';

class BaseChooseTimerWidget extends StatefulWidget {
  final String? Function()? validator;

  const BaseChooseTimerWidget({Key? key, this.validator}) : super(key: key);

  @override
  State<BaseChooseTimerWidget> createState() => BaseChooseTimerWidgetState();
}

class BaseChooseTimerWidgetState extends State<BaseChooseTimerWidget> {
  bool validator() {
    if (widget.validator != null) {
      validatorString = widget.validator!();
      setState(() {});
      if (validatorString != null) {
        return true;
      }
      return false;
    }
    return false;
  }

  String? validatorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TimeDateInputWidget(
                onChange: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                S.current.den,
                style: textNormal(dateColor, 14),
              ),
            ),
            Expanded(
              child: TimeDateInputWidget(
                onChange: (value) {},
              ),
            )
          ],
        ),
        if (validatorString == null)
          const SizedBox()
        else
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          )
      ],
    );
  }
}
