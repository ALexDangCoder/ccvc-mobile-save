import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  bool isCheckNgay = false;
  late BuildContext context;
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);

  BehaviorSubject<List<MeetingSchedule>> listMeetTingScheduleSubject =
      BehaviorSubject();

  BehaviorSubject<DateTime> moveTimeSubject = BehaviorSubject();

  Stream<List<MeetingSchedule>> get listMeetingStream =>
      listMeetTingScheduleSubject.stream;

  LichHopCubit() : super(LichHopStateIntial());
  List<String> listImageLichHopCuaToi = [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.lichCanKlch,
    ImageAssets.lichSapToi,
    ImageAssets.icLichCongTacNuocNgoai,
  ];

  dynamic currentTime = DateFormat.MMMMEEEEd().format(DateTime.now());
  List<MeetingSchedule> listMeeting = [
    MeetingSchedule(
        "hung hung hung", "2022-02-07T07:45:00", "2022-02-07T08:45:00"),
    MeetingSchedule("hung", "2022-02-07T09:45:00", "2022-02-07T10:45:00"),
    MeetingSchedule("hung", "2022-02-07T11:45:00", "2022-02-07T12:45:00"),
    MeetingSchedule("hung", "2022-02-07T13:45:00", "2022-02-07T15:45:00"),
  ];

  DataSource getCalenderDataSource() {
    List<Appointment> appointments = [];
    RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 2;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.recurrenceCount = 10;
    for (int i = 0; i < listMeeting.length; i++) {
      appointments.add(
        Appointment(
            startTime: DateTime.parse(listMeeting[i].dateTimeFrom),
            endTime: DateTime.parse(listMeeting[i].dateTimeTo),
            subject: listMeeting[i].title,
            color: textColorMangXaHoi,
            isAllDay: false),
      );
    }
    return DataSource(appointments);
  }

  chooseTypeList(Type_Choose_Option_List type) {
    if (type == Type_Choose_Option_List.DANG_LICH) {
      emit(const LichHopStateDangLich(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANG_LIST) {
      emit(const LichHopStateDangList(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANH_SACH) {
      emit(const LichHopStateDangDanhSach(Type_Choose_Option_Day.DAY));
    }
  }

  chooseTypeDay(Type_Choose_Option_Day type) {
    if (state is LichHopStateDangLich) {
      emit(LichHopStateDangLich(type));
    }
    if (state is LichHopStateDangList) {
      emit(LichHopStateDangList(type));
    }
    if (state is LichHopStateDangDanhSach) {
      emit(LichHopStateDangDanhSach(type));
    }
  }

  bool selectDay(DateTime b) {
    return selectedDay.year == b.year &&
        selectedDay.month == b.month &&
        selectedDay.day == b.day;
  }

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

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
