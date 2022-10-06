import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/widgets/text/ellipsis_character_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemAppointmentDay extends StatelessWidget {
  const ItemAppointmentDay({
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
    final lessThan1Hour = appointment.endTime.millisecondsSinceEpoch -
            appointment.startTime.millisecondsSinceEpoch <
        60 * 60 * 1000;
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: appointment.isAllDay ? 1 : 6,
            ),
            decoration:  BoxDecoration(
              color: AppTheme.getInstance().colorField(),
              borderRadius: const  BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: EllipsisDoubleLineText (
                    appointment.subject.trim(),
                    maxLines: appointment.isAllDay || lessThen30Minute ? 1 : 2,
                    style: textNormalCustom(
                      color: Colors.white,
                      fontSize: appointment.isAllDay ? 11 : 14,
                    ),
                  ),
                ),
                if (!appointment.isAllDay && !lessThan1Hour) spaceH4,
                if (!appointment.isAllDay && !lessThan1Hour)
                  Text(
                    '${DateFormat.jm('en').format(
                      appointment.startTime,
                    )} - ${DateFormat.jm('en').format(
                      appointment.endTime,
                    )}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textNormalCustom(
                      fontSize: 12,
                      color: backgroundColorApp.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  )
              ],
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
