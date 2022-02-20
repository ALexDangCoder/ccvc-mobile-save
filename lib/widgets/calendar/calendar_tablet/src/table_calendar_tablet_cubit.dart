import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:rxdart/rxdart.dart';

class TableCalendarTabletCubit {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  BehaviorSubject<DateTime> moveTimeSubject = BehaviorSubject();

  bool isSameNextWeek(DateTime a, DateTime b) {
    if (DateTime(a.year, a.month + 1, 0).day == 29 && a.day == 29) {
      return true;
    } else if (b.weekday == 7) {
      return false;
    } else if (a.weekday < b.weekday || a.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  bool selectDay(DateTime b) {
    return selectedDay.year == b.year &&
        selectedDay.month == b.month &&
        selectedDay.day == b.day;
  }

  bool isSameLeftWeek(DateTime a, DateTime b) {
    if ((b.day + DateTime(a.year, a.month + 1, 0).day) == 35) {
      return false;
    } else if (b.weekday == 7) {
      return true;
    } else if (a.weekday == 7) {
      return false;
    } else if (a.weekday > b.weekday) {
      return true;
    } else {
      return false;
    }
  }

  int leftPageMonth() {
    final int day = selectedDay.day;
    final int month = selectedDay.month;
    final int year = selectedDay.year;
    final int rangeBeetwenTwoDay = DateTime(year, month, 0).day + day;
    final int rangeWeekBeetwenTwoDay = rangeBeetwenTwoDay ~/ 7;

    if (isSameLeftWeek(DateTime(year, month - 1, 1), selectedDay)) {
      return rangeWeekBeetwenTwoDay + 1;
    } else {
      if ((day + DateTime(year, month, 0).day) == 35 &&
          DateTime(year, month - 1, 1).weekday == 7) {
        return rangeWeekBeetwenTwoDay - 1;
      }
      return rangeWeekBeetwenTwoDay;
    }
  }

  int nextPageMonth() {
    final int day = selectedDay.day;
    final int month = selectedDay.month;
    final int year = selectedDay.year;
    final int rangeBeetwenTwoDay = DateTime(year, month + 1, 0).day - day;
    final int rangeWeekBeetwenTwoDay = rangeBeetwenTwoDay ~/ 7;
    final int surplusDay = rangeBeetwenTwoDay - rangeWeekBeetwenTwoDay * 7;

    if (isSameNextWeek(
      DateTime(year, month, DateTime(year, month + 1, 0).day - surplusDay),
      DateTime(year, month + 1, 0),
    )) {
      if (DateTime(year, month + 1, 0).day == 29 && day == 29) {
        return rangeWeekBeetwenTwoDay;
      }

      if (DateTime(year, month + 1, 0).weekday == 6) {
        return rangeWeekBeetwenTwoDay + 1;
      }

      return rangeWeekBeetwenTwoDay;
    } else {
      return rangeWeekBeetwenTwoDay + 1;
    }
  }

  void onRight(Type_Choose_Option_Day type) {
    if (type == Type_Choose_Option_Day.DAY) {
      selectedDay =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day + 1);
    } else if (type == Type_Choose_Option_Day.WEEK) {
      selectedDay = DateTime(selectedDay.year, selectedDay.month,
          selectedDay.day + (7 - selectedDay.weekday + 1));
    } else {
      selectedDay = DateTime(selectedDay.year, selectedDay.month + 1, 1);
    }
    moveTimeSubject.add(selectedDay);
  }

  void onLeft(Type_Choose_Option_Day type) {
    if (type == Type_Choose_Option_Day.DAY) {
      selectedDay =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day - 1);
    } else if (type == Type_Choose_Option_Day.WEEK) {
      selectedDay = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day - selectedDay.weekday - 7 + 1,
      );
    } else {
      selectedDay = DateTime(
        selectedDay.year,
        selectedDay.month - 1,
        1,
      );
    }

    moveTimeSubject.add(selectedDay);
  }
}
