import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:flutter/material.dart';

class ChooseTimeCalendarTypeWidget extends StatefulWidget {
  final ChooseTimeController controller;
  final Function(CalendarType) onChange;

  const ChooseTimeCalendarTypeWidget({
    Key? key,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  @override
  _ChooseTimeCalendarTypeWidgetState createState() =>
      _ChooseTimeCalendarTypeWidgetState();
}

class _ChooseTimeCalendarTypeWidgetState
    extends State<ChooseTimeCalendarTypeWidget> {
  CalendarType type = CalendarType.DAY;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.calendarType.addListener(() {
      type = widget.controller.calendarType.value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const data = CalendarType.values;

    return Container(
      height: 48,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColorApp,
        border: Border.all(color: borderColor.withOpacity(0.5)),
      ),
      child: Row(
        children: List.generate(data.length, (index) {
          final result = data[index];
          return GestureDetector(
            onTap: () {
              type = data[index];
              widget.onChange(result);
              setState(() {});
            },
            child: Container(
              height: 36,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: result == type
                    ? AppTheme.getInstance().colorField()
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  result.getIcon().title,
                  style: textNormalCustom(
                    fontSize: 16.0,
                    color: result == type ? backgroundColorApp : color3D5586,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
