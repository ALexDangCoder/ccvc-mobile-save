// ignore_for_file: prefer_null_aware_method_calls, unnecessary_statements

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/calendar/event.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  final bool isCalendar;
  final Function(DateTime? start, DateTime? end, DateTime? focusedDay)?
      onChangeRange;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(String value)? onSearch;

  const TableCalendarWidget({
    Key? key,
    this.isCalendar = true,
    this.onSearch,
    this.onChangeRange,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  DateTime? _startTime;
  DateTime? _endTime;

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  bool isSearch = false;
  bool isFomat = true;
  DateTime _selectedDay = DateTime.now();
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormatWeek = CalendarFormat.week;
  CalendarFormat _calendarFormatMonth = CalendarFormat.month;
  final TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: widget.isCalendar
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowContainerColor.withOpacity(0.1),
                      blurRadius: 20.0.textScale(),
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                )
              : BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowContainerColor.withOpacity(0.1),
                      blurRadius: 20.0.textScale(),
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 10.0.textScale(),
                  right: 12.0.textScale(),
                  top: 12.0.textScale(),
                  bottom: 16.0.textScale(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isSearch)
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.current.tim_kiem,
                            hintStyle: textNormalCustom(
                              color: textBodyTime,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0.textScale(),
                            ),
                          ),
                          onSubmitted: (value) {
                            print('click submit');
                            widget.onSearch != null
                                ? widget.onSearch!(value)
                                : null;
                          },
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          isFomat = !isFomat;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text(
                              DateTime.now().toStringWithListFormat,
                              style: textNormalCustom(
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w500,
                                color: titleColor,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: textBodyTime,
                            ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearch = !isSearch;
                        });
                      },
                      child: SvgPicture.asset(ImageAssets.ic_search_calendar),
                    ),
                  ],
                ),
              ),
              if (widget.isCalendar)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableCalendar(
                      eventLoader: _getEventsfromDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: (date, events) {
                        if (!isSameDay(_selectedDay, date)) {
                          setState(() {
                            _selectedDay = date;
                            _focusedDay.value = _selectedDay;
                          });
                        }

                        widget.onDaySelected(date, events);
                      },
                      rangeSelectionMode: RangeSelectionMode.toggledOff,
                      rangeStartDay: _startTime,
                      rangeEndDay: _endTime,
                      onRangeSelected: (startTime, endTime, focusedDay) {
                        print('$startTime ....... $endTime');
                      },
                      daysOfWeekVisible: true,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          isFomat
                              ? _calendarFormatWeek = _format
                              : _calendarFormatMonth = _format;
                        });
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      calendarStyle: CalendarStyle(
                        cellMargin: const EdgeInsets.all(11),
                        weekendTextStyle: textNormalCustom(
                          color: titleCalenderWork,
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w500,
                        ),
                        defaultTextStyle: textNormalCustom(
                          color: titleColor,
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w500,
                        ),
                        selectedTextStyle: textNormalCustom(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0.textScale(),
                          color: Colors.white,
                        ),
                        todayDecoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: toDayColor,
                        ),
                        todayTextStyle: textNormalCustom(
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w500,
                          color: buttonColor,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: radioFocusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerVisible: false,
                      calendarFormat:
                          isFomat ? _calendarFormatWeek : _calendarFormatMonth,
                      firstDay: DateTime.utc(2021, 8, 20),
                      lastDay: DateTime.utc(2030, 8, 20),
                      focusedDay: _selectedDay,
                    ),
                    ..._getEventsfromDay(_selectedDay).map(
                      (Event event) => ListTile(
                        title: Text(
                          event.title,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Container(),
            ],
          ),
        ),
      ],
    );
  }
}
