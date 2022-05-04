import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/shared/utils.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/utils.dart';
import 'package:flutter/material.dart';
import 'customization/calendar_style.dart';

class TableCandarTablet extends StatefulWidget {
  final Type_Choose_Option_Day type;
  final Function(DateTime? start, DateTime? end, DateTime? focusedDay)
      onChangeRange;
  final Function(DateTime startDate, DateTime endDate, DateTime selectDay)
      onChange;
  final List<DateTime>? eventsLoader;
  final DateTime? initTime;

  const TableCandarTablet({
    Key? key,
    required this.type,
    required this.onChangeRange,
    required this.onChange,
    this.eventsLoader,
    this.initTime,
  }) : super(key: key);

  @override
  State<TableCandarTablet> createState() => _TableCandarTabletState();
}

class _TableCandarTabletState extends State<TableCandarTablet> {
  TableCalendarCubit cubitCalendar = TableCalendarCubit();
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(cubitCalendar.selectedDay, selectedDay)) {
      setState(() {
        cubitCalendar.selectedDay = selectedDay;
        cubitCalendar.focusedDay = focusedDay;
        cubitCalendar.rangeStart = null; // Important to clean those
        cubitCalendar.rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      cubitCalendar.moveTimeSubject.add(cubitCalendar.selectedDay);

      if (widget.type == Type_Choose_Option_Day.DAY) {
        widget.onChange(selectedDay, selectedDay, selectedDay);
      } else if (widget.type == Type_Choose_Option_Day.WEEK) {
        widget.onChange(
          selectedDay.subtract(Duration(days: selectedDay.weekday - 1)),
          selectedDay.add(
            Duration(
              days: DateTime.daysPerWeek - selectedDay.weekday,
            ),
          ),
          selectedDay,
        );
      } else {
        widget.onChange(
          DateTime(
            cubitCalendar.moveTimeSubject.value.year,
            cubitCalendar.moveTimeSubject.value.month,
            1,
          ),
          DateTime(
            cubitCalendar.moveTimeSubject.value.year,
            cubitCalendar.moveTimeSubject.value.month + 1,
            0,
          ),
          selectedDay,
        );
      }
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      cubitCalendar.focusedDay = focusedDay;
      cubitCalendar.rangeStart = start;
      cubitCalendar.rangeEnd = end;
      widget.onChangeRange(start, end, focusedDay);
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  void initState() {
    super.initState();
    cubitCalendar.selectedDay = widget.initTime ?? cubitCalendar.focusedDay;
    _selectedEvents =
        ValueNotifier(_getEventsForDay(cubitCalendar.selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: cubitCalendar.moveTimeSubject.stream,
      builder: (context, snapshot) {
        return TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: cubitCalendar.focusedDay,
          cubitCalendar: cubitCalendar,
          typeCalendar: widget.type,
          selectedDayPredicate: (day) => cubitCalendar.selectDay(day),
          rangeStartDay: cubitCalendar.rangeStart,
          rangeEndDay: cubitCalendar.rangeEnd,
          calendarFormat: CalendarFormat.week,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: (day) =>
              widget.eventsLoader
                  ?.where((element) => isSameDay(element, day))
                  .toList() ??
              [],
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onPageChanged: (focusedDay) {
            cubitCalendar.focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().colorField().withOpacity(0.1),
              ),
              todayTextStyle: TextStyle(
                color: AppTheme.getInstance().colorField(),
                fontSize: 16.0,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().colorField(),
              )),
        );
      },
    );
  }
}
