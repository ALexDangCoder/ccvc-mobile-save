// ignore_for_file: prefer_null_aware_method_calls, unnecessary_statements
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/calendar/event.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableCalendarWidget extends StatefulWidget {
  final bool isCalendar;
  final Function(DateTime? start, DateTime? end, DateTime? focusedDay)
      onChangeRange;
  final Function(String? value) onChangeText;
  final Function(DateTime startDate, DateTime end, DateTime selectDay) onChange;
  final Function(String value)? onSearch;
  final Type_Choose_Option_Day type;
  final List<DateTime>? eventsLoader;
  final DateTime? initTime;
  final bool isSearchBar;

  const TableCalendarWidget({
    Key? key,
    this.isCalendar = true,
    this.onSearch,
    required this.onChangeRange,
    required this.onChange,
    this.type = Type_Choose_Option_Day.DAY,
    this.eventsLoader,
    required this.onChangeText,
    this.initTime,
    this.isSearchBar = true,
  }) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  TableCalendarCubit cubit = TableCalendarCubit();

  @override
  void initState() {
    selectedEvents = {};
    _selectedDay = widget.initTime ?? DateTime.now();
    cubit.selectedDay = widget.initTime ?? DateTime.now();
    super.initState();
  }


  bool isSearch = false;
  bool isFomat = true;
  late DateTime _selectedDay ;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormatWeek = CalendarFormat.week;
  CalendarFormat _calendarFormatMonth = CalendarFormat.month;
  final TextEditingController _eventController = TextEditingController();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      cubit.focusedDay = focusedDay;
      cubit.rangeStart = start;
      cubit.rangeEnd = end;
      widget.onChangeRange(start, end, focusedDay);
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  void _onDaySelect(DateTime date, DateTime events) {
    if (!isSameDay(_selectedDay, date)) {
      setState(() {
        _selectedDay = date;
        _focusedDay.value = _selectedDay;
        cubit.rangeStart = null; // Important to clean those
        cubit.rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }

    cubit.selectedDay = date;
    cubit.moveTimeSubject.sink.add(cubit.selectedDay);

    if (widget.type == Type_Choose_Option_Day.DAY) {
      widget.onChange(date, date, date);
    } else if (widget.type == Type_Choose_Option_Day.WEEK) {
      widget.onChange(
        date.subtract(Duration(days: date.weekday - 1)),
        date.add(
          Duration(
            days: DateTime.daysPerWeek - date.weekday,
          ),
        ),
        date,
      );
    } else {
      widget.onChange(
        DateTime(
          cubit.moveTimeSubject.value.year,
          cubit.moveTimeSubject.value.month,
          1,
        ),
        DateTime(
          cubit.moveTimeSubject.value.year,
          cubit.moveTimeSubject.value.month + 1,
          0,
        ),
        date,
      );
    }
  }

  // @override
  // void didUpdateWidget(covariant TableCalendarWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (cubit.isMatchDay(oldWidget.initTime, widget.initTime)) {
  //     _selectedDay = storeSelectDay;
  //   } else {
  //     _selectedDay = widget.initTime!;
  //   }
  //   cubit.moveTimeSubject.add(_selectedDay);
  // }

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
                    if (isSearch && widget.isSearchBar)
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            widget.onChangeText(value);
                          },
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
                            widget.type.getTextWidget(
                              cubit: cubit,
                              textColor: color3D5586,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: textBodyTime,
                            ),
                          ],
                        ),
                      ),
                    if (widget.isSearchBar) GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearch = !isSearch;
                              });
                            },
                            child: SvgPicture.asset(
                                ImageAssets.ic_search_calendar),
                          ) else Container(),
                  ],
                ),
              ),
              if (widget.isCalendar)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableCalendarPhone(
                      eventLoader: (day) =>
                          widget.eventsLoader
                              ?.where((element) => isSameDay(element, day))
                              .toList() ??
                          [],
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: _onDaySelect,
                      rangeSelectionMode: _rangeSelectionMode,
                      rangeStartDay: cubit.rangeStart,
                      rangeEndDay: cubit.rangeEnd,
                      onRangeSelected: _onRangeSelected,
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
                        weekendTextStyle: textNormalCustom(
                          color: titleCalenderWork,
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
                          color: AppTheme.getInstance()
                              .colorField()
                              .withOpacity(0.2),
                        ),
                        todayTextStyle: textNormalCustom(
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w500,
                          color: buttonColor,
                        ),
                      ),
                      headerVisible: false,
                      calendarFormat:
                          isFomat ? _calendarFormatWeek : _calendarFormatMonth,
                      firstDay: DateTime.utc(2021, 8, 20),
                      lastDay: DateTime.utc(2030, 8, 20),
                      focusedDay:  _selectedDay,
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
