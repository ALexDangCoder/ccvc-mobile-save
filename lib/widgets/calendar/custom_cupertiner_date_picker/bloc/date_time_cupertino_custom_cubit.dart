import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
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
  BehaviorSubject<TypePickerDateTime> typePickerSubject = BehaviorSubject();
  BehaviorSubject<bool> isShowBeginPickerSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isShowEndPickerSubject = BehaviorSubject.seeded(false);

  TypePickerDateTime lastedType = TypePickerDateTime.TIME_START;
  final int duration = 250;

  void handleSwitchButtonPressed({required bool isChecked}) {
    isSwitchBtnCheckedSubject.sink.add(isChecked);
  }

  Future<void> handleDateTimePressed({
    bool isBegin = true,
  }) async {
    if (lastedType != typePickerSubject.value &&
        (isShowBeginPickerSubject.value || isShowEndPickerSubject.value)) {
      isShowBeginPickerSubject.sink.add(false);
      isShowEndPickerSubject.sink.add(false);
    }
    await Future.delayed(Duration(milliseconds: duration));
    isBegin
        ? isShowBeginPickerSubject.sink.add(!isShowBeginPickerSubject.value)
        : isShowEndPickerSubject.sink.add(!isShowEndPickerSubject.value);
  }

  void setTypePicker(TypePickerDateTime type) {
    typePickerSubject.sink.add(type);
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

  void dispose() {
    isSwitchBtnCheckedSubject.close();
    timeBeginSubject.close();
    dateBeginSubject.close();
    timeEndSubject.close();
    dateEndSubject.close();
    typePickerSubject.close();
    isShowBeginPickerSubject.close();
    isShowEndPickerSubject.close();
  }
}
