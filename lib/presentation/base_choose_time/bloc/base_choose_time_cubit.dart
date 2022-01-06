import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/base_choose_time/bloc/base_choose_time_state.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class BaseChooseTimeCubit extends BaseCubit<BaseChooseTimeState> {
  BaseChooseTimeCubit() : super(BaseChooseTimeInitial());

  //
  bool isCheck = false;
  List<String> listText = ['Ngày', 'Tuần', 'Tháng'];
  String textContent = 'Ngày';

  //

  String textDisplayTime = '';
  String changeOption = 'Ngày';
  String dateChange = '';
  DateTime times = DateTime.now();
  BehaviorSubject<String> textDateTimeSubject = BehaviorSubject();

  Stream<String> get textDateTimeStream => textDateTimeSubject.stream;

  void getState(DateTime time) {
    times = time;
    textDisplayTime = getDateToString(time);
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  void onNextDay(DateTime time) {
    int timeMillisecond = time.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond + (24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  void onBackDay() {
    int timeMillisecond = times.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond - (24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  void ontoDay() {
    final DateTime now = DateTime.now();
    times = now;
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void onNextWeek() {
    int timeMillisecond = times.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond + (7 * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    final String today = DateFormat(DateFormat.WEEKDAY).format(times); // Tues
    final weekDay = times.weekday == 7 ? 0 : times.weekday;
    if (today == 'Sunday') {
      textDisplayTime = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
          getDate(
            times.subtract(
              Duration(days: DateTime.daysPerWeek - weekDay - 1),
            ),
          ).millisecondsSinceEpoch,
        ),
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.subtract(Duration(days: weekDay)))
              .millisecondsSinceEpoch,
        ),
      );
      textDateTimeSubject.sink.add(textDisplayTime);
    } else {
      textDisplayTime = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.subtract(Duration(days: weekDay)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000),
        ),
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.add(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000),
        ),
      );
      textDateTimeSubject.sink.add(textDisplayTime);
    }
  }

  void onBackWeek() {
    int timeMillisecond = times.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond - (7 * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    final String today = DateFormat(DateFormat.WEEKDAY).format(times); // Tues
    final weekDay = times.weekday == 7 ? 0 : times.weekday;
    if (today == 'Sunday') {
      textDisplayTime = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
          getDate(
            times.subtract(
              Duration(days: DateTime.daysPerWeek - weekDay - 1),
            ),
          ).millisecondsSinceEpoch,
        ),
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.subtract(Duration(days: weekDay)))
              .millisecondsSinceEpoch,
        ),
      );
      textDateTimeSubject.sink.add(textDisplayTime);
    } else {
      textDisplayTime = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.subtract(Duration(days: weekDay)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000),
        ),
        DateTime.fromMillisecondsSinceEpoch(
          getDate(times.add(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000),
        ),
      );
      textDateTimeSubject.sink.add(textDisplayTime);
    }
  }

  void onNextMonth() {
    final firstDayThisMonth = DateTime(times.year, times.month, times.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    final int numberDay =
        firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int timeMillisecond = times.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond + (numberDay * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    textDisplayTime = getDateToString(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.utc(
          times.year,
          times.month,
        ).millisecondsSinceEpoch,
      ),
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.utc(
          times.year,
          times.month + 1,
        ).subtract(const Duration(days: 1)).millisecondsSinceEpoch,
      ),
    );
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  void onBackMonth() {
    final firstDayThisMonth = DateTime(times.year, times.month, times.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    final int numberDay =
        firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int timeMillisecond = times.millisecondsSinceEpoch;
    timeMillisecond = timeMillisecond - (numberDay * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(timeMillisecond);
    textDisplayTime = getDateToString(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.utc(
          times.year,
          times.month,
        ).millisecondsSinceEpoch,
      ),
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.utc(
          times.year,
          times.month + 1,
        ).subtract(const Duration(days: 1)).millisecondsSinceEpoch,
      ),
    );
    textDateTimeSubject.sink.add(textDisplayTime);
  }

  void checkToOption(String name) {
    switch (name) {
      case 'Ngày':
        onNextDay(times);
        break;
      case 'Tuần':
        onNextWeek();
        break;
      case 'Tháng':
        onNextMonth();
        break;
    }
  }

  void checkToOptionBackDay(String name) {
    switch (name) {
      case 'Ngày':
        onBackDay();
        break;
      case 'Tuần':
        onBackWeek();
        break;
      case 'Tháng':
        onBackMonth();
        break;
    }
  }

  String getDateToString(DateTime time, [DateTime? endDate]) {
    String day;
    String month;
    if (time.day < 10) {
      day = '0${time.day}';
    } else {
      day = '${time.day}';
    }
    if (time.month < 10) {
      month = '0${time.month}';
    } else {
      month = '${time.month}';
    }

    //
    if (endDate != null) {
      // endDate
      String dayEnd;
      String monthEnd;
      if (endDate.day < 10) {
        dayEnd = '0${endDate.day}';
      } else {
        dayEnd = '${endDate.day}';
      }
      if (endDate.month < 10) {
        monthEnd = '0${endDate.month}';
      } else {
        monthEnd = '${endDate.month}';
      }
      if (changeOption == 'Tuần') {
        return '$day,$month - $dayEnd Tháng $monthEnd, ${endDate.year}';
      } else {
        return '$day - $dayEnd Tháng $monthEnd, ${endDate.year}';
      }
    }
    return '$day Tháng $month,${time.year}';
    //
  }

  void dispose() {
    textDateTimeSubject.close();
  }
}
