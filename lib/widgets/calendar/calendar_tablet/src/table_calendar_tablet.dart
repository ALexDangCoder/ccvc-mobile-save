import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/shared/utils.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_tablet_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/utils.dart';
import 'package:flutter/material.dart';

class TableCandarTablet extends StatefulWidget {
  final Type_Choose_Option_Day type;

  const TableCandarTablet({Key? key, required this.type}) : super(key: key);

  @override
  State<TableCandarTablet> createState() => _TableCandarTabletState();
}

class _TableCandarTabletState extends State<TableCandarTablet> {
  TableCalendarTabletCubit cubitCalendar = TableCalendarTabletCubit();
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
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      cubitCalendar.focusedDay = focusedDay;
      cubitCalendar.rangeStart = start;
      cubitCalendar.rangeEnd = end;
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
    cubitCalendar.selectedDay = cubitCalendar.focusedDay;
    _selectedEvents =
        ValueNotifier(_getEventsForDay(cubitCalendar.selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: cubitCalendar.moveTimeSubject.stream,
      builder: (context, snapshot) {
        return TableCalendar<Event>(
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
          eventLoader: _getEventsForDay,
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onPageChanged: (focusedDay) {
            cubitCalendar.focusedDay = focusedDay;
          },
        );
      },
    );
  }
}