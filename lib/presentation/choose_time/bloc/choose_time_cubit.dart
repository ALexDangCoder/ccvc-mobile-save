import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ChooseTimeCubit extends BaseCubit<ChooseTimeState> {
  ChooseTimeCubit() : super(ChooseTimeInitial());

  //
  bool isCheck = false;
  List<String> listText = ['Ngày', 'Tuần', 'Tháng'];
  String textContent = 'Ngày';

  //

  String textDisplayTime = '';
  String changeOption = 'Ngày';
  String dateChange = '';
  String startDate = '';
  String endDate = '';
  DateTime times = DateTime.now();
  BehaviorSubject<String> textDateTimeSubject = BehaviorSubject();

  Stream<String> get textDateTimeStream => textDateTimeSubject.stream;

  void getState(DateTime time) {
    times = time;
    textDisplayTime = getDateToString(time);
    textDateTimeSubject.sink.add(textDisplayTime);
    final dataDateTime =
        times.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    startDate = dataDateTime.first.formatApi;
    endDate = dataDateTime.last.formatApi;
  }

  void onNextDay(DateTime time) {
    int a = time.millisecondsSinceEpoch;
    a = a + (24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(a);
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
    startDate = times.formatApi;
    endDate = times.formatApi;
  }

  void onBackDay() {
    int a = times.millisecondsSinceEpoch;
    a = a - (24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(a);
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
    startDate = times.formatApi;
    endDate = times.formatApi;
  }

  void ontoDay() {
    final DateTime now = DateTime.now();
    times = now;
    textDisplayTime = getDateToString(times);
    textDateTimeSubject.sink.add(textDisplayTime);
    startDate = times.formatApi;
    endDate = times.formatApi;
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void onNextWeek() {
    int b = times.millisecondsSinceEpoch;
    b = b + (7 * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(b);
    final String a = DateFormat(DateFormat.WEEKDAY).format(times); // Tues
    final weekDay = times.weekday == 7 ? 0 : times.weekday;
    if (a == S.current.sun_day) {
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
      final dataDateTime =
          times.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      startDate = dataDateTime.first.formatApi;
      endDate = dataDateTime.last.formatApi;
    }
  }

  void onBackWeek() {
    int b = times.millisecondsSinceEpoch;
    b = b - (7 * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(b);
    final String a = DateFormat(DateFormat.WEEKDAY).format(times); // Tues
    final weekDay = times.weekday == 7 ? 0 : times.weekday;
    if (a == S.current.sun_day) {
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
      final dataDateTime =
          times.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      startDate = dataDateTime.first.formatApi;
      endDate = dataDateTime.last.formatApi;
    }
  }

  void onNextMonth() {
    final firstDayThisMonth = DateTime(times.year, times.month, times.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    final int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = times.millisecondsSinceEpoch;
    b = b + (c * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(b);
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
    final dataDateTime =
        times.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    startDate = dataDateTime.first.formatApi;
    endDate = dataDateTime.last.formatApi;
  }

  void onBackMonth() {
    final firstDayThisMonth = DateTime(times.year, times.month, times.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    final int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = times.millisecondsSinceEpoch;
    b = b - (c * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(b);
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
    final dataDateTime =
        times.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    startDate = dataDateTime.first.formatApi;
    endDate = dataDateTime.last.formatApi;
  }

  void checkToOption(String a) {
    switch (a) {
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

  void checkToOptionBackDay(String a) {
    switch (a) {
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
