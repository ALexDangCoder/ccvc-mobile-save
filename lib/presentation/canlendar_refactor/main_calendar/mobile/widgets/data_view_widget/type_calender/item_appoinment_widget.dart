import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:flutter/material.dart';

class ItemAppointment extends StatelessWidget {
  const ItemAppointment({Key? key, required this.appointment})
      : super(key: key);
  final AppointmentWithDuplicate appointment;

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              appointment.subject,
              style: textNormalCustom(
                fontSize: 11,
              ),
            ),
          ),
          if (appointment.isDuplicate)
            const Icon(
              Icons.circle,
              color: Colors.red,
              size: 10,
            ),
        ],
      ),
    );
  }
}
