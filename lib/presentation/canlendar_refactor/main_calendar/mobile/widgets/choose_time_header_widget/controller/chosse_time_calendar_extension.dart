import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../choose_time_item.dart';
import 'choose_time_calendar_controller.dart';

extension ChooseTimeControllerExtension on ChooseTimeController{
  Widget getIcon(){
    return  IconButton(
      onPressed: () {
        isShowCalendarType.value =
        !isShowCalendarType.value;
      },
      icon: ValueListenableBuilder<CalendarType>(
        valueListenable: calendarType,
        builder: (context, value, _) => SvgPicture.asset(value.getIcon().icon,height: 24,width: 24,),
      ),
    );
  }
}