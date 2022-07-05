import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'date_time_cupertino_custom_state.dart';

enum TypePickerDateTime { DATE_START, DATE_END, TIME_START, TIME_END }

class DateTimeCupertinoCustomCubit
    extends BaseCubit<DateTimeCupertinoCustomState> {
  DateTimeCupertinoCustomCubit() : super(DateTimeCupertinoCustomInitial()) {
    getTimeConfig();
  }

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
  String timeFromTmp = INIT_TIME_PICK;
  String dateFromTmp = INIT_DATE_PICK;
  String dateToTmp = INIT_DATE_PICK;
  String timeToTmp = INIT_TIME_PICK;
  String timeStartConfigSystem = '00:00';
  String timeEndConfigSystem = '00:00';

  CalendarWorkRepository get calendarRepo => Get.find();

  Future<void> getTimeConfig() async {
    final result = await calendarRepo.getConfigTime();
    result.when(
      success: (res) {
        timeStartConfigSystem = res.timeStart ?? '00:00';
        timeEndConfigSystem = res.timeEnd ?? '00:00';
      },
      error: (error) {},
    );
  }

  void handleSwitchButtonPressed({required bool isChecked}) {
    if (isShowBeginPickerSubject.value) {
      isShowBeginPickerSubject.sink.add(false);
    }
    if (isShowEndPickerSubject.value) {
      isShowEndPickerSubject.sink.add(false);
    }
    isSwitchBtnCheckedSubject.sink.add(isChecked);
    if (isChecked) {
      dateBeginSubject.sink
          .add(DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date));

      dateEndSubject.sink.add(
        DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
      );
      timeBeginSubject.sink.add(timeStartConfigSystem);
      timeEndSubject.sink.add(timeEndConfigSystem);
      validateTime.sink.add('');
    } else {
      timeBeginSubject.sink.add(timeFromTmp);
      timeEndSubject.sink.add(timeToTmp);
      dateBeginSubject.sink.add(dateFromTmp);
      dateEndSubject.sink.add(dateToTmp);
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
    switch (typePicker) {
      case TypePickerDateTime.TIME_START:
        timeFromTmp = timeSelected.dateTimeFormatter(
          pattern: HOUR_MINUTE_FORMAT,
        );
        timeBeginSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
        );
        break;
      case TypePickerDateTime.TIME_END:
        timeToTmp = timeSelected.dateTimeFormatter(
          pattern: HOUR_MINUTE_FORMAT,
        );
        timeEndSubject.sink.add(
          timeSelected.dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
        );
        break;
      case TypePickerDateTime.DATE_START:
        dateFromTmp =
            timeSelected.dateTimeFormatter(pattern: DateFormatApp.date);
        dateBeginSubject.sink.add(dateFromTmp);
        break;
      case TypePickerDateTime.DATE_END:
        dateToTmp = timeSelected.dateTimeFormatter(pattern: DateFormatApp.date);
        dateEndSubject.sink.add(dateToTmp);
        break;
    }
  }

  bool checkTime() {
    try {
      if (dateBeginSubject.hasValue &&
          timeBeginSubject.hasValue &&
          dateEndSubject.hasValue &&
          timeEndSubject.hasValue) {
        if (dateBeginSubject.value != INIT_DATE_PICK &&
            timeBeginSubject.value != INIT_TIME_PICK &&
            dateEndSubject.value != INIT_DATE_PICK &&
            timeEndSubject.value != INIT_TIME_PICK) {
          final begin = DateTime.parse(
            timeFormat(
              '${dateBeginSubject.valueOrNull} ${timeBeginSubject.valueOrNull}',
              DateTimeFormat.DATE_TIME_PICKER,
              DateTimeFormat.DATE_TIME_PUT_EDIT,
            ),
          );
          final end = DateTime.parse(
            timeFormat(
              '${dateEndSubject.valueOrNull} ${timeEndSubject.valueOrNull}',
              DateTimeFormat.DATE_TIME_PICKER,
              DateTimeFormat.DATE_TIME_PUT_EDIT,
            ),
          );
          if (begin.isAtSameMomentAs(end) ||
              begin.isAfter(end) ||
              end.isAtSameMomentAs(begin) ||
              end.isBefore(begin)) {
            validateTime.sink.add(S.current.thoi_gian_bat_dau);
            return false;
          } else {
            validateTime.sink.add('');
            return true;
          }
        } else {
          validateTime.sink.add(S.current.ban_phai_chon_thoi_gian);
          return false;
        }
      }
      validateTime.sink.add(S.current.ban_phai_chon_thoi_gian);
      return false;
    } catch (e) {
      validateTime.sink.add(S.current.ban_phai_chon_thoi_gian);
      return false;
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
