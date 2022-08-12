import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/chosse_time_calendar_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/days_of_week_style_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableCalendarTabletWidget extends StatefulWidget {
  final ChooseTimeController controller;
  final Function(DateTime) onPageCalendar;
  final Function(DateTime) onSelect;
  final List<DateTime> calendarDays;
  final bool isSelectYear;

  const TableCalendarTabletWidget({
    Key? key,
    required this.calendarDays,
    required this.controller,
    required this.onPageCalendar,
    required this.onSelect,
    this.isSelectYear = false,
  }) : super(key: key);

  @override
  _TableCalendarTabletWidgetState createState() =>
      _TableCalendarTabletWidgetState();
}

class _TableCalendarTabletWidgetState extends State<TableCalendarTabletWidget> {
  DateTime selectDay = DateTime.now();
  ValueNotifier<DateTime> pageDateTime = ValueNotifier(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.controller.selectDate.addListener(() {
        selectDay = widget.controller.selectDate.value;
        if (mounted) setState(() {});
      });
      widget.controller.calendarType.addListener(() {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<DateTime>(
              valueListenable: pageDateTime,
              builder: (context, value, _) {
                return coverTime(value);
              },
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.controller.backTime();
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 32,
                    height: 26,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImageAssets.icBack,
                      color: colorA2AEBD,
                      height: 18,
                      width: 8,
                    ),
                  ),
                ),
                Text(
                  dateFormat(selectDay),
                  style: textNormalCustom(
                    fontSize: 16,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.controller.nextTime();
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 32,
                    height: 26,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImageAssets.icNext,
                      color: colorA2AEBD,
                      height: 18,
                      width: 7,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        TableCalendarPhone(
          locale: 'vi',
          isDowTop: false,
          onPageChanged: (value) {
            pageDateTime.value = value;
            if (value.month != widget.controller.pageTableCalendar.month) {
              widget.controller.pageTableCalendar = value;
              widget.onPageCalendar(value);
            }
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: textNormalCustom(fontSize: 18, color: color667793),
            weekendStyle: textNormalCustom(fontSize: 18, color: colorA2AEBD),
          ),
          eventLoader: (day) => widget.calendarDays
              .where((element) => isSameDay(element, day))
              .toList(),
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: (selectDay, focusDay) {
            this.selectDay = selectDay;
            pageDateTime.value = selectDay;
            widget.onSelect(selectDay);
            setState(() {});
          },
          daysOfWeekVisible: true,
          selectedDayPredicate: (day) {
            return isSameDay(selectDay, day);
          },
          calendarStyle: CalendarStyle(
            weekendTextStyle: textNormalCustom(
              color: colorA2AEBD,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
            defaultTextStyle: textNormalCustom(
              color: color3D5586,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
            selectedTextStyle: textNormalCustom(
              fontWeight: FontWeight.w500,
              fontSize: 14.0.textScale(),
              color: Colors.white,
            ),
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().colorField(),
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().colorField().withOpacity(0.2),
            ),
            todayTextStyle: textNormalCustom(
              fontSize: 14.0.textScale(),
              color: Colors.white,
            ),
          ),
          headerVisible: false,
          calendarFormat: CalendarFormat.week,
          firstDay: DateTime.utc(DateTime.now().year - 10, 8, 20),
          lastDay: DateTime.utc(DateTime.now().year + 10, 8, 20),
          focusedDay: selectDay,
        ),
      ],
    );
  }

  Widget coverTime(DateTime dateTime) {
    return RichText(
      text: TextSpan(
        text: '${S.current.thang} ${dateTime.month} - ',
        style: textNormalCustom(
          color: color3D5586,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '${dateTime.year}',
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        widget.controller.calendarType.value == CalendarType.MONTH) {
      return S.current.thang_nay;
    }
    return widget.controller.dateFormat(dateTime);
  }
}
