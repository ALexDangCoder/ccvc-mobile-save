import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:flutter/material.dart';

class ItemAppointmentWeek extends StatelessWidget {
  const ItemAppointmentWeek({
    Key? key,
    required this.appointment,
    this.onClick,
  }) : super(key: key);
  final AppointmentWithDuplicate appointment;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final lessThen30Minute = appointment.endTime.millisecondsSinceEpoch -
            appointment.startTime.millisecondsSinceEpoch <
        30 * 60 * 1000;
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: AppTheme.getInstance().colorField(),
            ),
            child: Text(
              appointment.subject.trim(),
              maxLines: appointment.isAllDay || lessThen30Minute ? 3 : null,
              style: textNormalCustom(
                fontSize: 11,
              ),
              overflow: appointment.isAllDay || lessThen30Minute
                  ? TextOverflow.ellipsis
                  : null,
            ),
          ),
          Visibility(
            visible: appointment.isDuplicate,
            child: Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: redChart,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
