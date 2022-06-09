import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'date_time_cupertino_custom_state.dart';

enum TypePickerDateTime { DATE_START, DATE_END, TIME_START, TIME_END }

class DateTimeCupertinoCustomCubit
    extends BaseCubit<DateTimeCupertinoCustomState> {
  DateTimeCupertinoCustomCubit() : super(DateTimeCupertinoCustomInitial());

  BehaviorSubject<bool> isSwitchBtnCheckedSubject = BehaviorSubject();
  BehaviorSubject<String> timeBeginSubject = BehaviorSubject();
  BehaviorSubject<String> dateBeginSubject = BehaviorSubject();
  BehaviorSubject<String> timeEndSubject = BehaviorSubject();
  BehaviorSubject<String> dateEndSubject = BehaviorSubject();
  BehaviorSubject<TypePickerDateTime> typePickerSubjectStart =
      BehaviorSubject.seeded(TypePickerDateTime.TIME_START);
  BehaviorSubject<TypePickerDateTime> typePickerSubjectEnd =
      BehaviorSubject.seeded(TypePickerDateTime.TIME_END);
  BehaviorSubject<bool> isShowBeginPickerSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isShowEndPickerSubject = BehaviorSubject.seeded(false);

  TypePickerDateTime lastedType = TypePickerDateTime.TIME_START;
  final int duration = 250;

  void handleSwitchButtonPressed({required bool isChecked}) {
    if (isShowBeginPickerSubject.value) {
      isShowBeginPickerSubject.sink.add(false);
    }
    if (isShowEndPickerSubject.value) {
      isShowEndPickerSubject.sink.add(false);
    }
    if (isChecked) {
      dateBeginSubject.sink.add(
        DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
      );
      dateEndSubject.sink.add(
        DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
      );
    }
    isSwitchBtnCheckedSubject.sink.add(isChecked);
  }

  Future<void> handleDateTimePressed({
    bool isBegin = true,
  }) async {
    if (lastedType != typePickerSubjectStart.value) {
      if (isShowBeginPickerSubject.value) {
        isShowBeginPickerSubject.sink.add(false);
      }
      if (isShowEndPickerSubject.value) {
        isShowEndPickerSubject.sink.add(false);
      }
    }
    await Future.delayed(Duration(milliseconds: duration));
    isBegin
        ? isShowBeginPickerSubject.sink.add(!isShowBeginPickerSubject.value)
        : isShowEndPickerSubject.sink.add(!isShowEndPickerSubject.value);
  }

  void setTypePickerStart(TypePickerDateTime type) {
    typePickerSubjectStart.sink.add(type);
  }

  void setTypePickerEnd(TypePickerDateTime type) {
    typePickerSubjectEnd.sink.add(type);
  }

  CupertinoDatePickerMode getTypePicker(TypePickerDateTime type) {
    switch (type) {
      case TypePickerDateTime.TIME_START:
      case TypePickerDateTime.TIME_END:
        return CupertinoDatePickerMode.time;
      case TypePickerDateTime.DATE_START:
      case TypePickerDateTime.DATE_END:
        return CupertinoDatePickerMode.date;
    }
  }

  void onTimeChanged({
    required DateTime timeSelected,
    required TypePickerDateTime typePicker,
  }) {
    if (isSwitchBtnCheckedSubject.hasValue && isSwitchBtnCheckedSubject.value) {
      timeEndSubject.sink.add(timeBeginSubject.value);
      dateBeginSubject.sink.add(
        timeSelected.dateTimeFormatter(pattern: DateFormatApp.date),
      );
      dateEndSubject.sink.add(
        timeSelected.dateTimeFormatter(pattern: DateFormatApp.date),
      );
      return;
    }

    switch (typePicker) {
      case TypePickerDateTime.TIME_START:
        timeBeginSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
        );
        break;
      case TypePickerDateTime.TIME_END:
        timeEndSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
        );
        break;
      case TypePickerDateTime.DATE_START:
        dateBeginSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: DateFormatApp.date),
        );
        break;
      case TypePickerDateTime.DATE_END:
        dateEndSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: DateFormatApp.date),
        );
        break;
    }

    /// handle datetime begin greater than datetime end

    /// Compares this DateTime object to [other],
    /// returning zero if the values are equal.
    /// Returns a negative value if this DateTime [isBefore] [other].
    /// It returns 0 if it [isAtSameMomentAs] [other],
    /// and returns a positive value otherwise (when this [isAfter] [other]).
    if (typePicker == TypePickerDateTime.TIME_START) {
      final DateTime timeEnd =
          '${dateEndSubject.value} ${timeEndSubject.value}'.convertStringToDate(
        formatPattern: DateTimeFormat.DATE_DD_MM_HM,
      );
      if (timeSelected.compareTo(timeEnd) > 0) {
        timeEndSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
        );
      }
    }

    if (typePicker == TypePickerDateTime.DATE_START) {
      final DateTime dateEnd =
          '${dateEndSubject.value} ${timeEndSubject.value}'.convertStringToDate(
        formatPattern: DateFormatApp.date,
      );
      final timeSelectFormatted =
          '${dateBeginSubject.value} ${timeBeginSubject.value}'
              .convertStringToDate(
        formatPattern: DateFormatApp.date,
      );
      if (timeSelectFormatted.compareTo(dateEnd) > 0) {
        timeEndSubject.sink.add(timeBeginSubject.value);
        dateEndSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: DateFormatApp.date),
        );
      }
    }
  }

  int getYearNumber() {
    try {
      return int.parse(
        dateBeginSubject.value.substring(
          dateBeginSubject.value.length - 4,
          dateBeginSubject.value.length,
        ),
      );
    } catch (e) {
      return 1900;
    }
  }

  void dispose() {
    isSwitchBtnCheckedSubject.close();
    timeBeginSubject.close();
    dateBeginSubject.close();
    timeEndSubject.close();
    dateEndSubject.close();
    typePickerSubjectStart.close();
    isShowBeginPickerSubject.close();
    isShowEndPickerSubject.close();
  }
}
