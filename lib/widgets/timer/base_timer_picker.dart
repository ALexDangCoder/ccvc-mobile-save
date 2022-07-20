import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/material.dart';

class BaseChooseTimerWidget extends StatefulWidget {
  final String? Function(TimerData, TimerData)? validator;
  final Function(TimerData, TimerData)? onChange;
  final TimerData? timeBatDau;
  final TimerData? timeKetThuc;
  final bool isCheckRemoveDidUpdate;

  const BaseChooseTimerWidget({
    Key? key,
    this.validator,
    this.onChange,
    this.timeBatDau,
    this.timeKetThuc,
    this.isCheckRemoveDidUpdate = false,
  }) : super(key: key);

  @override
  State<BaseChooseTimerWidget> createState() => BaseChooseTimerWidgetState();
}

class BaseChooseTimerWidgetState extends State<BaseChooseTimerWidget> {
  bool validator() {
    validatorString = widget.validator?.call(startDate, endDate);
    setState(() {});
    if (validatorString != null) {
      return false;
    }
    return true;
  }

  String? validatorString;
  TimerData startDate = TimerData(hour: 0, minutes: 0);
  TimerData endDate = TimerData(hour: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TimeDateInputWidget(
                initTimerData: widget.timeBatDau,
                onChange: (value) {
                  startDate = value;
                  widget.onChange?.call(startDate, endDate);
                },
                isRemoveDidUpdate: widget.isCheckRemoveDidUpdate,
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
                initTimerData: widget.timeKetThuc,
                onChange: (value) {
                  endDate = value;
                  if (widget.onChange != null) {
                    widget.onChange!(startDate, endDate);
                  }
                },
                isRemoveDidUpdate: widget.isCheckRemoveDidUpdate,
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
