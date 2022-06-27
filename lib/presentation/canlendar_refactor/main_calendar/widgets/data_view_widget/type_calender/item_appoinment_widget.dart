import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ItemAppointment extends StatelessWidget {
  const ItemAppointment({Key? key, required this.appointment}) : super(key: key);
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: AppTheme.getInstance().colorField(),
      ),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  appointment.subject,
                  style: textNormalCustom(
                    fontSize: 10,
                  ),
                ),
              ),
              // const Icon(
              //   Icons.circle,
              //   color: Colors.red,
              //   size: 10,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
