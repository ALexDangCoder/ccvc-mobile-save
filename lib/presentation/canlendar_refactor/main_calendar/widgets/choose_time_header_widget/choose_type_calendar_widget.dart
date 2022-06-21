import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTypeCalendarWidget extends StatefulWidget {
  const ChooseTypeCalendarWidget({Key? key}) : super(key: key);

  @override
  _ChooseTypeCalendarWidgetState createState() =>
      _ChooseTypeCalendarWidgetState();
}

class _ChooseTypeCalendarWidgetState extends State<ChooseTypeCalendarWidget> {
  CalendarType type = CalendarType.DAY;
  @override
  Widget build(BuildContext context) {
    const data = CalendarType.values;
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
              setState(() {});
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon.icon,
                    color:  textBodyTime,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Text(
                    icon.title,
                    style: textNormal(textBodyTime, 14),
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
