import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
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
  BehaviorSubject<String> validateTime = BehaviorSubject();

  TypePickerDateTime lastedType = TypePickerDateTime.TIME_START;
  final int duration = 250;

  void handleSwitchButtonPressed({required bool isChecked}) {
    if (isShowBeginPickerSubject.value) {
      isShowBeginPickerSubject.sink.add(false);
    }
    if (isShowEndPickerSubject.value) {
      isShowEndPickerSubject.sink.add(false);
    }
    isSwitchBtnCheckedSubject.sink.add(isChecked);
    if (isChecked) {
      final date = DateTime.now();
      timeBeginSubject.sink.add(
        DateTime(date.year, date.month, date.day, 08)
            .dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
      );
      timeEndSubject.sink.add(
        DateTime(date.year, date.month, date.day, 18)
            .dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
      );
      dateBeginSubject.sink.add(
        DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
      );
      dateEndSubject.sink.add(
        DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
      );
      validateTime.sink.add('');
    } else {
      timeBeginSubject.sink
          .add(DateTime.now().dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT));
      timeEndSubject.sink
          .add(DateTime.now().dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT));
    }
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
  }

  /// handle datetime begin greater than datetime end

  /// Compares this DateTime object to [other],
  /// returning zero if the values are equal.
  /// Returns a negative value if this DateTime [isBefore] [other].
  /// It returns 0 if it [isAtSameMomentAs] [other],
  /// and returns a positive value otherwise (when this [isAfter] [other]).
  void checkTime() {
    if (dateBeginSubject.hasValue &&
        timeBeginSubject.hasValue &&
        dateEndSubject.hasValue &&
        timeEndSubject.hasValue) {
      final begin = DateTime.parse(
        timeFormat(
          '${dateBeginSubject.value} ${timeBeginSubject.value}',
          'dd/MM/yyyy HH:mm',
          'yyyy-MM-dd HH:mm',
        ),
      );
      final end = DateTime.parse(
        timeFormat(
          '${dateEndSubject.value} ${timeEndSubject.value}',
          'dd/MM/yyyy HH:mm',
          'yyyy-MM-dd HH:mm',
        ),
      );

      if (begin.isAtSameMomentAs(end) ||
          begin.isAfter(end) ||
          end.isAtSameMomentAs(begin) ||
          end.isBefore(begin)) {
        validateTime.sink.add(S.current.thoi_gian_bat_dau);
      } else {
        validateTime.sink.add('');
      }
    } else {
      validateTime.sink.add(S.current.ban_phai_chon_thoi_gian);
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
