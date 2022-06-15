import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/danh_sach_lich_lam_viec.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_state.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/common_api_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/api_time_type_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
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
  bool changeDateByClick = true;

  CalenderCubit() : super(const CalenderStateIntial());
  int page = 1;
  int totalPage = 1;
  int pageSize = 100;
  Type_Choose_Option_List modeLLV = Type_Choose_Option_List.DANG_LICH;
  Type_Choose_Option_Day stateOptionDay = Type_Choose_Option_Day.DAY;
  BehaviorSubject<bool> isCheckNgay = BehaviorSubject();
  BehaviorSubject<int> checkIndex = BehaviorSubject();
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isCheckList = BehaviorSubject();
  BehaviorSubject<List<bool>> selectTypeCalendarSubject =
      BehaviorSubject.seeded([true, false]);
  BehaviorSubject<TypeCalendarMenu> changeItemMenuSubject =
      BehaviorSubject.seeded(TypeCalendarMenu.LichCuaToi);
  final BehaviorSubject<List<DateTime>> eventsSubject = BehaviorSubject();

  BehaviorSubject<List<MenuModel>> menuModelSubject = BehaviorSubject();
  BehaviorSubject<DateTime> initTime = BehaviorSubject();
  DateTime? initTimes;
  BehaviorSubject<bool> isSearchBar = BehaviorSubject.seeded(true);
  BehaviorSubject<DateTime> initTimeSubject = BehaviorSubject();

  Stream<DateTime> get streamInitTime => initTimeSubject.stream;

  Stream<List<DateTime>> get eventsStream => eventsSubject.stream;

  Stream<int> get checkIndexStream => checkIndex.stream;

  Stream<bool> get isCheckNgayStream => isCheckNgay.stream;

  Stream<TypeCalendarMenu> get changeItemMenuStream =>
      changeItemMenuSubject.stream;
  final BehaviorSubject<DanhSachLichlamViecModel> danhSachLichLamViecSubject =
      BehaviorSubject();

  final CalendarController stateCalendarControllerDay = CalendarController();
  final CalendarController stateCalendarControllerWeek = CalendarController();
  final CalendarController stateCalendarControllerMonth = CalendarController();

  BehaviorSubject<DateTime> moveTimeSubject = BehaviorSubject();

  Stream<DanhSachLichlamViecModel> get danhSachLichLamViecStream =>
      danhSachLichLamViecSubject.stream;

  BehaviorSubject<stateLDM> getStateLDM =
      BehaviorSubject.seeded(stateLDM.ChoXacNhan);

  /// ListLichLvRequest lichLvRequest = fakeData;

  bool isCheck = false;
  BehaviorSubject<DataLichLvModel> listLichSubject =
      BehaviorSubject.seeded(DataLichLvModel());
  DataLichLvModel dataLichLvModel = DataLichLvModel();

  Stream<DataLichLvModel> get streamListLich => listLichSubject.stream;
  DateTime selectDay = DateTime.now();
  DateTime startDates = DateTime.now();
  DateTime endDates = DateTime.now();

  ///Data menu
  String idDonViLanhDao = '';
  String titleAppbar = '';
  List<ItemThongBaoModelMyCalender> listLanhDao = [];
  List<ItemThongBaoModelMyCalender> listDataMenu = listThongBao;

  void initDataMenu() {
    listDataMenu[2].listWidget = listLanhDao;
  }

  void callApi() {
    startDates = selectDay;
    endDates = selectDay;
    initDataMenu();
    callApiNgay();
    moveTimeSubject.add(selectDay);
  }

  Future<void> searchLichHop(String? query) async {
    Timer(const Duration(microseconds: 500), () {
      (dataLichLvModel.listLichLVModel ?? []).clear();
      if (query == null || query.isEmpty) {
        getListLichLV();
      } else {
        getListLichLV(query);
      }
    });
  }

  void callApiTuan() {
    final day = selectDay;
    startDates = day.subtract(Duration(days: day.weekday - 1));
    endDates = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
    callApiNgay();
  }

  void callApiMonth() {
    final day = selectDay;
    startDates = DateTime(day.year, day.month, 1);
    endDates = DateTime(day.year, day.month + 1, 0);
    callApiNgay();
  }

  List<ListLichLVModel> listDSLV = [];

  Future<void> getListLichLV([String? search]) async {
    showLoading();
    final DanhSachLichLamViecRequest data = DanhSachLichLamViecRequest(
      Title: search,
      DateFrom: startDates.formatApi,
      DateTo: endDates.formatApi,
      DonViId: changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
          ? idDonViLanhDao
          : HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
      IsLichLanhDao:
          changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
              ? true
              : null,
      isLichCuaToi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichCuaToi),
      isLichDuocMoi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichDuocMoi),
      isLichTaoHo: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichTaoHo),
      isLichHuyBo:
          changeItemMenuSubject.value.getListLichHop(TypeCalendarMenu.LichHuy),
      isLichThuHoi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichThuHoi),
      isChuaCoBaoCao: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichHopCanKLCH),
      isDaCoBaoCao: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichDaKLCH),
      isChoXacNhan: getStateLDM.value.getListState(stateLDM.ChoXacNhan),
      isLichThamGia: getStateLDM.value.getListState(stateLDM.ThamGia),
      isLichTuChoi: getStateLDM.value.getListState(stateLDM.TuChoi),
      PageIndex: page,
      PageSize: modeLLV == Type_Choose_Option_List.DANG_LICH ? 1000 : 10,
      UserId: HiveLocal.getDataUser()?.userId ?? '',
    );
    final result = await lichLamViec.getListLichLamViec(data);
    result.when(
      success: (res) {
        totalPage = res.totalPage ?? 1;
        dataLichLvModel = res;
        listDSLV.addAll(dataLichLvModel.listLichLVModel ?? []);
        dataLichLvModel.listLichLVModel = listDSLV;
        listLichSubject.sink.add(dataLichLvModel);
      },
      error: (error) {},
    );
    showContent();
  }

  ListLichLVModel getElementFromId(String id) {
    return (listLichSubject.value.listLichLVModel ?? [])
        .where((element) => element.id == id)
        .toList()
        .first;
  }

  DataSource getCalenderDataSource(DataLichLvModel dataLichLvModels) {
    final List<Appointment> appointments = [];

    final RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 2;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.recurrenceCount = 10;
    for (final i in dataLichLvModels.listLichLVModel ?? []) {
      appointments.add(
        Appointment(
          startTime: DateTime.parse(
            i.dateTimeFrom ?? '',
          ),
          endTime: DateTime.parse(
            i.dateTimeTo ?? '',
          ),
          subject: i.title ?? '',
          color: Colors.blue,
          id: i.id ?? '',
        ),
      );
    }

    getMatchDate(dataLichLvModels);
    // appointments.add(Appointment(startTime: DateTime(DateTime
    //     .now()
    //     .year, DateTime
    //     .now()
    //     .month, DateTime
    //     .now()
    //     .day, 3), endTime: DateTime(DateTime
    //     .now()
    //     .year, DateTime
    //     .now()
    //     .month, DateTime
    //     .now()
    //     .day, 4), subject: 'DAng Hung'),);
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

  //tong dashbroad

  BehaviorSubject<DashBoardLichHopModel> lichLamViecDashBroadSubject =
      BehaviorSubject.seeded(
    DashBoardLichHopModel.empty(),
  );

  Stream<DashBoardLichHopModel> get streamLichLamViec =>
      lichLamViecDashBroadSubject.stream;
  DashBoardLichHopModel lichLamViecDashBroads = DashBoardLichHopModel.empty();

  LichLamViecRepository get lichLamViec => Get.find();

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
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

extension HandleDataCalendar on CalenderCubit {
  Future<void> updateDataSlideCalendar(DateTime timeSlide) async {
    if (!changeDateByClick) {
      showLoading();
      selectDay = timeSlide;
      await postEventsCalendar();
      initTimeSubject.add(selectDay);
      if (stateOptionDay == Type_Choose_Option_Day.DAY) {
        await callApiDayCalendar();
      }
      if (stateOptionDay == Type_Choose_Option_Day.WEEK) {
        await callApiWeekCalendar();
      }
      if (stateOptionDay == Type_Choose_Option_Day.MONTH) {
        await callApiMonthCalendar();
      }
      showContent();
    }
  }

  Future<void> callApi() async {
    showLoading();
    listDSLV.clear();
    page = 1;
    await getListLichLV();
    await dataLichLamViec(
      startDate: startDates.formatApi,
      endDate: endDates.formatApi,
    );
    await dataLichLamViecRight(
      startDate: startDates.formatApi,
      endDate: endDates.formatApi,
      type: 0,
    );
    await menuCalendar();
    showContent();
  }

  void getMatchDate(DataLichLvModel data) {
    if ((data.listLichLVModel ?? []).isEmpty) {
      return;
    }
    (data.listLichLVModel ?? []).sort(
      (a, b) => DateTime.parse(
        a.dateTimeFrom ?? '',
      ).compareTo(
        DateTime.parse(
          b.dateTimeFrom ?? '',
        ),
      ),
    );
    for (final e in data.listLichLVModel ?? []) {
      (data.listLichLVModel ?? [])
          .where(
            (i) =>
                (DateTime.parse(
                      e.dateTimeTo ?? '',
                    ).isAfter(
                      DateTime.parse(
                        i.dateTimeFrom ?? '',
                      ),
                    ) ||
                    isMatch(
                      DateTime.parse(
                        e.dateTimeFrom ?? '',
                      ),
                      DateTime.parse(
                        i.dateTimeFrom ?? '',
                      ),
                    )) &&
                DateTime.parse(
                  e.dateTimeFrom ?? '',
                ).isBefore(
                  DateTime.parse(
                    i.dateTimeFrom ?? '',
                  ),
                ) &&
                i.id != e.id,
          )
          .toList()
          .forEach((element) {
        element.isTrung = true;
        e.isTrung = true;
      });
    }
  }

  bool isMatch(DateTime? oldData, DateTime? newData) {
    if (oldData == newData) return true;

    return false;
  }
}
