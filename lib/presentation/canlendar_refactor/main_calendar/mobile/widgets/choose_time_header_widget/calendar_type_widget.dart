import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTypeCalendarWidget extends StatefulWidget {
  final Function(CalendarType) onChange;
  final ChooseTimeController controller;
  final bool isSelectYear;
  const ChooseTypeCalendarWidget(
      {Key? key,
      required this.onChange,
      required this.controller,
      this.isSelectYear = false})
      : super(key: key);

  @override
  _ChooseTypeCalendarWidgetState createState() =>
      _ChooseTypeCalendarWidgetState();
}

class _ChooseTypeCalendarWidgetState extends State<ChooseTypeCalendarWidget> {
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
  void didUpdateWidget(covariant ChooseTypeCalendarWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(!widget.isSelectYear){
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.controller.calendarTypeDefault();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CalendarType> data = [];
    if (!widget.isSelectYear) {
      data = CalendarType.values
          .where((element) => element != CalendarType.YEAR)
          .toList();
    } else {
      data = CalendarType.values;
    }

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(data.length, (index) {
          final result = data[index];
          final icon = data[index].getIcon();
          return GestureDetector(
            onTap: () {
              type = data[index];
              widget.onChange(result);
              setState(() {});
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon.icon,
                    color: type == result
                        ? AppTheme.getInstance().colorField()
                        : textBodyTime,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Text(
                    icon.title,
                    style: textNormal(
                      type == result
                          ? AppTheme.getInstance().colorField()
                          : textBodyTime,
                      14,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
