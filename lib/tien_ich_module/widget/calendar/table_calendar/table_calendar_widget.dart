// ignore_for_file: prefer_null_aware_method_calls, unnecessary_statements
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/calendar/event.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lichh_am_duong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/customization/header_style_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/shared/utils_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_phone.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/src/table_calendar_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableCalendarWidget extends StatefulWidget {
  final bool isCalendar;
  late bool? tablet;
  late bool? isFomatMonth;
  final bool isCheckLunar;
  final DateTime? initDateTime;
  final LichAmDuongCubit cubit;
  final Function(DateTime day) selectDay;
  final Function(DateTime? start, DateTime? end, DateTime? focusedDay)
      onChangeRange;
  final Function(DateTime startDate, DateTime end, DateTime selectDay) onChange;
  final Function(String value)? onSearch;
  final Type_Choose_Option_Day type;
  final List<DateTime>? eventsLoader;
  final Function(BuildContext context)? onTap;
  final DateTime? dateTimeHeader;

  TableCalendarWidget({
    Key? key,
    this.onTap,
    this.isCheckLunar = false,
    this.isCalendar = true,
    this.tablet = false,
    this.initDateTime,
    this.isFomatMonth = true,
    this.onSearch,
    required this.onChangeRange,
    required this.onChange,
    this.type = Type_Choose_Option_Day.DAY,
    this.eventsLoader,
    required this.selectDay,
    required this.cubit,
    this.dateTimeHeader,
  }) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  TableCalendarCubit cubit = TableCalendarCubit();

  @override
  void initState() {
    selectedEvents = {};
    _selectedDay = widget.initDateTime ?? DateTime.now();
    cubit.selectedDay = widget.initDateTime ?? DateTime.now();
    super.initState();
  }

  @override
  @override
  void didUpdateWidget(TableCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedDay = widget.initDateTime ?? DateTime.now();
    cubit.selectedDay = widget.initDateTime ?? DateTime.now();
  }

  bool isSearch = false;
  late DateTime _selectedDay;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormatWeek = CalendarFormat.week;
  CalendarFormat _calendarFormatMonth = CalendarFormat.month;
  final TextEditingController _eventController = TextEditingController();

  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  //     .toggledOff; // Can be toggled on/off by longpressing a date

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
      // _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  void _onDaySelect(DateTime date, DateTime events) {
    if (!isSameDay(_selectedDay, date)) {
      setState(() {
        _selectedDay = date;
        _focusedDay.value = _selectedDay;
        cubit.rangeStart = null; // Important to clean those
        cubit.rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
    cubit.selectedDay = date;
    cubit.moveTimeSubject.add(cubit.selectedDay);

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
                : const BoxDecoration(
                    color: Colors.white,
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.tablet == false)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorECEEF7,
                        ),
                      ),
                    ),
                    child: TableCalendarPhone(
                      eventLoader: (day) =>
                          widget.eventsLoader
                              ?.where((element) => isSameDay(element, day))
                              .toList() ??
                          [],
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: _onDaySelect,
                      rangeStartDay: cubit.rangeStart,
                      rangeEndDay: cubit.rangeEnd,
                      onRangeSelected: _onRangeSelected,
                      daysOfWeekVisible: true,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          widget.isFomatMonth == true
                              ? _calendarFormatWeek = _format
                              : _calendarFormatMonth = _format;
                        });
                      },
                      selectedDayPredicate: (day) {
                        return widget.selectDay(day) ||
                            isSameDay(widget.cubit.selectTime, day);
                      },
                      calendarStyle: CalendarStyle(
                        weekendTextStyle: textNormalCustom(
                          color: titleCalenderWork,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        defaultTextStyle: textNormalCustom(
                          color: color3D5586,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        outsideTextStyle: textNormalCustom(
                          color: color3D5586,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        selectedTextStyle: textNormalCustom(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.getInstance()
                              .colorField()
                              .withOpacity(0.1),
                        ),
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.getInstance().colorField(),
                        ),
                        todayTextStyle: textNormalCustom(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.getInstance().colorField(),
                        ),
                      ),
                      headerVisible: false,

                      calendarFormat: widget.isFomatMonth == true
                          ? _calendarFormatWeek
                          : _calendarFormatMonth,
                       firstDay: DateTime.utc(1800, 1, 1),
                       lastDay: DateTime.utc(2199, 1, 1),
                      focusedDay: _focusedDay.value,
                      isCheckLuner: widget.isCheckLunar,
                    ),
                  )
                else
                  TableCalendarTablet(
                    dateTimeHeader: widget.dateTimeHeader,
                    eventLoader: (day) =>
                        widget.eventsLoader
                            ?.where((element) => isSameDay(element, day))
                            .toList() ??
                        [],
                    onTap: (contexts) {
                      if (widget.onTap != null) {
                        widget.onTap!(contexts);
                      }
                    },
                    isCheckLunar: widget.isCheckLunar,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: _onDaySelect,
                    // rangeSelectionMode: _rangeSelectionMode,
                    rangeStartDay: cubit.rangeStart,
                    rangeEndDay: cubit.rangeEnd,
                    onRangeSelected: _onRangeSelected,
                    daysOfWeekVisible: true,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        widget.isFomatMonth == true
                            ? _calendarFormatWeek = _format
                            : _calendarFormatMonth = _format;
                      });
                    },
                    selectedDayPredicate: (day) {
                      return widget.selectDay(day) ||
                          isSameDay(widget.cubit.selectTime, day);
                    },
                    calendarStyle: CalendarStyle(
                      cellMargin: EdgeInsets.zero,
                      cellPadding: EdgeInsets.zero,
                      weekendTextStyle: textNormalCustom(
                        color: titleCalenderWork,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      defaultTextStyle: textNormalCustom(
                        color: color3D5586,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      outsideTextStyle: textNormalCustom(
                        color: color3D5586,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      selectedTextStyle: textNormalCustom(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.getInstance()
                            .colorField()
                            .withOpacity(0.1),
                      ),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.getInstance().colorField(),
                      ),
                      todayTextStyle: textNormalCustom(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                    headerVisible: widget.tablet == true ? true : false,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronMargin: EdgeInsets.zero,
                      rightChevronMargin: EdgeInsets.zero,
                      leftChevronPadding:
                          const EdgeInsets.symmetric(vertical: 12.0),
                      rightChevronPadding:
                          const EdgeInsets.symmetric(vertical: 12.0),
                      leftChevronIcon: SvgPicture.asset(
                        ImageAssets.icLeftCalendar,
                      ),
                      rightChevronIcon: SvgPicture.asset(
                        ImageAssets.icRightCalendar,
                      ),
                      titleTextStyle: textNormalCustom(
                        fontSize: 16.0,
                        color: color3D5586,
                      ),
                      titleTextFormatter: (date, locale) =>
                          date.toStringMonth_Year,
                      formatButtonShowsNext: true,
                    ),
                    calendarFormat: widget.isFomatMonth == true
                        ? _calendarFormatWeek
                        : _calendarFormatMonth,
                    firstDay: DateTime.utc(1800, 1, 1),
                    lastDay: DateTime.utc(2199, 1, 1),
                    focusedDay: _focusedDay.value,
                    cubit: widget.cubit,
                  ),
              ],
            )),
      ],
    );
  }
}
