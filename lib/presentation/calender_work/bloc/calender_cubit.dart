import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/danh_sach_lich_lam_viec.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderCubit extends BaseCubit<CalenderState> {
  CalenderCubit() : super(const CalenderStateIntial());
  int page = 1;
  int totalPage = 1;
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
  final BehaviorSubject<DanhSachLichlamViecModel> danhSachLichLamViecSubject =
      BehaviorSubject();

  Stream<DanhSachLichlamViecModel> get danhSachLichLamViecStream =>
      danhSachLichLamViecSubject.stream;

  /// ListLichLvRequest lichLvRequest = fakeData;

  bool isCheck = false;
  BehaviorSubject<DataLichLvModel> listLichSubject =
      BehaviorSubject.seeded(DataLichLvModel());
  DataLichLvModel dataLichLvModel = DataLichLvModel();

  Stream<DataLichLvModel> get streamListLich => listLichSubject.stream;
  DateTime startDates = DateTime.now();
  DateTime endDates = DateTime.now();

  void callApi(DateTime? startDate, DateTime? endDate) {
    //listDSLV.clear();
    //page = 1;
    callApiNgay(startDate ?? startDates, endDate ?? endDates);
  }

  void callApiNgay(
    DateTime startDate,
    DateTime endDate,
  ) {
    getListLichLV(
      dateFrom: startDate.formatApi,
      dateTo: endDate.formatApi,
      userId: HiveLocal.getDataUser()?.userId ?? '',
      donViId:
          HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
      pageIndex: page,
      pageSize: 10,
      isLichCuaToi: true,
    );
    dataLichLamViec(startDate: startDate.formatApi, endDate: endDate.formatApi);
    dataLichLamViecRight(
      startDate: startDate.formatApi,
      endDate: endDate.formatApi,
      type: 0,
    );
  }

  void callApiTuan() {
    final day = DateTime.now();
    final startDate = day.subtract(Duration(days: day.weekday - 1));
    final endDate = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
    callApiNgay(startDate, endDate);
  }

  void callApiMonth() {
    DateTime times = DateTime.now();
    final firstDayThisMonth = DateTime(times.year, times.month, times.day);
    final firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month,
      firstDayThisMonth.day,
    );
    final int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = times.millisecondsSinceEpoch;
    b = b + (c * 24 * 60 * 60 * 1000);
    times = DateTime.fromMillisecondsSinceEpoch(b);

    final startMonth = DateTime.fromMillisecondsSinceEpoch(
      DateTime.utc(
        times.year,
        times.month,
      ).millisecondsSinceEpoch,
    );
    final endMonth = DateTime.fromMillisecondsSinceEpoch(
      DateTime.utc(
        times.year,
        times.month + 1,
      ).subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    );
    callApiNgay(startMonth, endMonth);
  }

  List<ListLichLVModel> listDSLV = [];

  Future<void> getListLichLV({
    required String dateFrom,
    required String dateTo,
    required String userId,
    required String donViId,
    required int pageIndex,
    required int pageSize,
    required bool isLichCuaToi,
  }) async {
    final DanhSachLichLamViecRequest data = DanhSachLichLamViecRequest(
      DateFrom: dateFrom,
      DateTo: dateTo,
      UserId: userId,
      DonViId: donViId,
      PageIndex: pageIndex,
      PageSize: pageSize,
      isLichCuaToi: isLichCuaToi,
    );
    showLoading();
    final result = await _lichLamViec.getListLichLamViec(data);
    result.when(
      success: (res) {
        // listDSLV.clear();
        totalPage = res.totalPage ?? 1;
        dataLichLvModel = res;
        listDSLV.addAll(dataLichLvModel.listLichLVModel ?? []);
        dataLichLvModel.listLichLVModel = listDSLV;
        listLichSubject.sink.add(dataLichLvModel);
        showContent();
      },
      error: (error) {},
    );
  }

  DataSource getCalenderDataSource(DataLichLvModel dataLichLvModels) {
    final List<Appointment> appointments = [];
    final RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 2;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.recurrenceCount = 10;
    for (int i = 0; i < (dataLichLvModels.listLichLVModel?.length ?? 0); i++) {
      appointments.add(
        Appointment(
          startTime: DateTime.parse(
            dataLichLvModels.listLichLVModel?[i].dateTimeFrom ?? '',
          ),
          endTime: DateTime.parse(
            dataLichLvModels.listLichLVModel?[i].dateTimeTo ?? '',
          ),
          subject: dataLichLvModels.listLichLVModel?[i].title ?? '',
          color: Colors.blue,
        ),
      );
    }
    return DataSource(appointments);
  }

  List<String> img = [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.icLichLamViec,
    ImageAssets.icLichCongTacNuocNgoai,
    ImageAssets.icLichTiepDan,
    ImageAssets.icAdminTao,
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
    ),
    LichLamViecDashBroadItem(
      numberOfCalendars: 0,
      typeId: '',
      typeName: '',
    ),
    LichLamViecDashBroadItem(
      numberOfCalendars: 0,
      typeId: '',
      typeName: '',
    ),
    LichLamViecDashBroadItem(
      numberOfCalendars: 0,
      typeId: '',
      typeName: '',
    ),
    LichLamViecDashBroadItem(
      numberOfCalendars: 0,
      typeId: '',
      typeName: '',
    ),
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
    final LichLamViecRightRequest request = LichLamViecRightRequest(
      dateFrom: startDate,
      dateTo: endDate,
      type: type,
    );
    final result = await _lichLamViec.getLichLvRight(request);
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

  Future<void> postDanhSachLichlamViec({
    required DanhSachLichLamViecRequest body,
  }) async {
    final result = await _lichLamViec.postDanhSachLichLamViec(body);
    result.when(
      success: (value) {
        totalPage = value.totalPage ?? 1;
        danhSachLichLamViecSubject.add(value);
      },
      error: (error) {},
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
