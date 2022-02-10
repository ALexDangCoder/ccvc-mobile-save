import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderCubit extends BaseCubit<CalenderState> {
  CalenderCubit() : super(const CalenderStateIntial());
  BehaviorSubject<bool> isCheckNgay = BehaviorSubject();
  BehaviorSubject<int> checkIndex = BehaviorSubject();
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);

  Stream<int> get checkIndexStream => checkIndex.stream;

  Stream<bool> get isCheckNgayStream => isCheckNgay.stream;
  bool isCheck = false;
  List<String> img = [
    ImageAssets.icTongSoLichLamviec,
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.icLichLamViec,
    ImageAssets.icLichCongTacNuocNgoai,
    ImageAssets.icLichTiepDan,
    ImageAssets.icAdminTao,
  ];
  List<DashboardSchedule> list = [
    DashboardSchedule(1, '22ssads2', 'Lịch công tác trong nước'),
    DashboardSchedule(2, '2dasdsd22', 'Lịch làm việc'),
    DashboardSchedule(3, '2dasda22', 'Lịch công tác nước ngoài'),
    DashboardSchedule(4, '2asdas22', 'Lịch tiếp dân'),
    DashboardSchedule(5, 'sdasdasd', 'admin tạo'),
    DashboardSchedule(6, 'sdasdasd', 'admin tạo'),
  ];
  List<MeetingSchedule> listMeeting = [
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2022-01-25T07:45:00',
      '2022-01-25T08:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2022-01-25T09:45:00',
      '2022-01-25T10:45:00',
    ),
    MeetingSchedule(
      'Họp nội',
      '2022-01-27T09:45:00',
      '2022-01-27T10:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2022-01-25T07:45:00',
      '2022-01-25T08:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T13:45:00',
      '2021-12-29T15:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T13:45:00',
      '2021-12-29T15:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T13:45:00',
      '2021-12-29T15:45:00',
    ),
  ];
  dynamic currentTime = DateFormat.MEd().format(DateTime.now());

  String textDay = '';

  void getDay() {
    final DateTime textTime = DateTime.now();
    textDay = getDateToString(textTime);
  }

  String getDateToString(DateTime time) {
    return 'Thứ ${time.weekday},${time.day} tháng ${time.month}';
  }

  DataSource getCalenderDataSource() {
    final List<Appointment> appointments = [];
    final RecurrenceProperties recurrence =
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
          color: Colors.blue,
        ),
      );
    }
    return DataSource(appointments);
  }

  void chooseTypeListLv(Type_Choose_Option_List type) {
    if (type == Type_Choose_Option_List.DANG_LICH) {
      emit(const LichLVStateDangLich(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANG_LIST) {
      emit(const LichLVStateDangList(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANH_SACH) {
      emit(const LichLVStateDangDanhSach(Type_Choose_Option_Day.DAY));
    }
  }

  void chooseTypeCalender(Type_Choose_Option_Day type) {
    if (state is LichLVStateDangLich) {
      emit(LichLVStateDangLich(type));
    } else {
      emit(LichLVStateDangList(type));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
