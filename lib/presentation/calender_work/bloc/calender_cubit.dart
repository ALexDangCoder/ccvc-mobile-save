import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/list_lich_lv/list_lich_lv_request.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderCubit extends BaseCubit<CalenderState> {
  CalenderCubit() : super(const CalenderStateIntial());
  BehaviorSubject<bool> isCheckNgay = BehaviorSubject();
  BehaviorSubject<int> checkIndex = BehaviorSubject();
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);
  BehaviorSubject<List<bool>> selectTypeCalendarSubject =
      BehaviorSubject.seeded([true, false]);
  BehaviorSubject<TypeCalendarMenu> changeItemMenuSubject =
      BehaviorSubject.seeded(TypeCalendarMenu.LichCuaToi);

  Stream<int> get checkIndexStream => checkIndex.stream;

  Stream<bool> get isCheckNgayStream => isCheckNgay.stream;

  Stream<TypeCalendarMenu> get changeItemMenuStream =>
      changeItemMenuSubject.stream;

  /// ListLichLvRequest lichLvRequest = fakeData;

  bool isCheck = false;
  BehaviorSubject<DataLichLvModel> listLichSubject = BehaviorSubject();
  DataLichLvModel dataLichLvModel = DataLichLvModel();
  int page = 1;
  int totalPage = 1;

  Stream<DataLichLvModel> get streamListLich => listLichSubject.stream;

  void callApi() {
    getListLichHop(
      dateFrom: '2022-02-01',
      dateTo: '2022-02-28',
      isLichCuaToi: true,
      pageIndex: page,
      pageSize: 10,
    );
    dataLichLamViec(startDate: '2022-02-01', endDate: '2022-02-28');
    dataLichLamViecRight(
      startDate: '2022-02-01',
      endDate: '2022-02-28',
      type: 3,
    );
  }

  Future<void> getListLichHop({
    required String dateFrom,
    required String dateTo,
    required bool isLichCuaToi,
    required int pageIndex,
    required int pageSize,
  }) async {
    final ListLichLvRequest data = ListLichLvRequest(
      dateFrom: dateFrom,
      dateTo: dateTo,
      isLichCuaToi: isLichCuaToi,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );
    showLoading();
    final result = await _lichLamViec.getListLichLamViec(data);
    result.when(
      success: (res) {
        totalPage = res.totalPage ?? 1;
        dataLichLvModel = res;
        listLichSubject.sink.add(dataLichLvModel);
        showContent();
      },
      error: (error) {},
    );
  }

  List<String> img = [
    //ImageAssets.icTongSoLichLamviec,
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
      '2022-01-25T01:45:00',
      '2022-01-25T02:45:00',
    ),
    MeetingSchedule(
      'Họp nội',
      '2022-01-27T09:45:00',
      '2022-01-27T10:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2022-01-25T05:45:00',
      '2022-01-25T06:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T13:45:00',
      '2021-12-29T15:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T16:45:00',
      '2021-12-29T17:45:00',
    ),
    MeetingSchedule(
      'Họp nội bộ đơn vị',
      '2021-12-29T18:45:00',
      '2021-12-29T19:45:00',
    ),
  ];
  dynamic currentTime = DateFormat.MEd().format(DateTime.now());

  String textDay = '';

  void changeScreenMenu(TypeCalendarMenu typeMenu) {
    changeItemMenuSubject.add(typeMenu);
  }

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

  //tong dashbroad

  BehaviorSubject<LichLamViecDashBroad> lichLamViecDashBroadSubject =
      BehaviorSubject.seeded(LichLamViecDashBroad(countScheduleCaNhan: 0));

  Stream<LichLamViecDashBroad> get streamLichLamViec =>
      lichLamViecDashBroadSubject.stream;
  LichLamViecDashBroad lichLamViecDashBroads = LichLamViecDashBroad();

  LichLamViecRepository get _lichLamViec => Get.find();

  Future<void> dataLichLamViec({
    required String startDate,
    required String endDate,
  }) async {
    showLoading();
    final result = await _lichLamViec.getLichLv(startDate, endDate);
    result.when(
      success: (res) {
        lichLamViecDashBroads = res;
        lichLamViecDashBroadSubject.sink.add(lichLamViecDashBroads);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }

  BehaviorSubject<List<LichLamViecDashBroadItem>>
      lichLamViecDashBroadRightSubject = BehaviorSubject.seeded([
    LichLamViecDashBroadItem(
      numberOfCalendars: 0,
      typeId: '',
      typeName: '',
    )
  ]);

  Stream<List<LichLamViecDashBroadItem>> get streamLichLamViecRight =>
      lichLamViecDashBroadRightSubject.stream;
  List<LichLamViecDashBroadItem> lichLamViecDashBroadRight = [];

  Future<void> dataLichLamViecRight({
    required String startDate,
    required String endDate,
    required int type,
  }) async {
    showLoading();
    final result = await _lichLamViec.getLichLvRight(
      startDate,
      endDate,
      type,
    );
    result.when(
      success: (res) {
        lichLamViecDashBroadRight = res;
        lichLamViecDashBroadRightSubject.sink.add(lichLamViecDashBroadRight);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
