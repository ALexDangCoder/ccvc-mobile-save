import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:flutter/material.dart';

class ItemAppointmentMonth extends StatelessWidget {
  const ItemAppointmentMonth({
    Key? key,
    required this.appointment,
    this.onClick,
  }) : super(key: key);
  final AppointmentWithDuplicate appointment;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          height: 20,
          decoration:  BoxDecoration(
            color: AppTheme.getInstance().colorField(),
            borderRadius:const BorderRadius.all(Radius.circular(4)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Text(
                  appointment.subject.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textNormalCustom(color: Colors.white, fontSize: 9),
                ),
              ),
              Visibility(
                visible: appointment.isDuplicate,
                child: Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: redChart, shape: BoxShape.circle,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
