import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_thong_ke_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  LichHopCubit() : super(const LichHopStateIntial()) {
    final user = HiveLocal.getDataUser();
    if (user != null) {
      userId = user.userId ?? '';
      donViId = user.userInformation?.donViTrucThuoc?.id ?? '';
    }
  }
  BehaviorSubject<DateTime> initTimeSubject = BehaviorSubject();
  bool changeDateByClick = false;
  Type_Choose_Option_Day stateOptionDay = Type_Choose_Option_Day.DAY;
  List<ItemThongBaoModelMyCalender> dataMenu = listThongBaoMyCalendar;
  List<ItemThongBaoModelMyCalender> listLanhDaoLichHop = [];
  String idDonViLanhDao = '';
  String titleAppbar = '';
  int indexThongKe = 0;
  String idThongKe = '';
  BehaviorSubject<List<bool>> selectTypeCalendarSubject =
      BehaviorSubject.seeded([true, false, false]);
  Type_Choose_Option_List typeLH = Type_Choose_Option_List.DANG_LICH;
  List<ItemDanhSachLichHop> listDSLH = [];
  DateTime selectDay = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String userId = '';
  String donViId = '';
  int page = 1;
  int totalPage = 2;
  bool isCheckNgay = false;

  BehaviorSubject<bool> isListThongKeSubject = BehaviorSubject.seeded(false);
  late BuildContext context;
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);

  BehaviorSubject<List<StatisticByMonthModel>> statisticSubject =
      BehaviorSubject();

  BehaviorSubject<TypeCalendarMenu> changeItemMenuSubject =
      BehaviorSubject.seeded(TypeCalendarMenu.LichCuaToi);

  Stream<TypeCalendarMenu> get changeItemMenuStream =>
      changeItemMenuSubject.stream;
  BehaviorSubject<DateTime> moveTimeSubject = BehaviorSubject();
  BehaviorSubject<stateLDM> getStateLDM =
      BehaviorSubject.seeded(stateLDM.ChoXacNhan);

  BehaviorSubject<CalendarController> stateCalendarSubject = BehaviorSubject();

  HopRepository get hopRepo => Get.find();
  BehaviorSubject<List<MenuModel>> menuModelSubject = BehaviorSubject();

  BehaviorSubject<List<ToChucBoiDonViModel>> toChucBoiDonViSubject =
      BehaviorSubject();

  BehaviorSubject<List<MeetingSchedule>> listMeetTingScheduleSubject =
      BehaviorSubject();
  BehaviorSubject<List<TiLeThamGiaModel>> tiLeThamGiaSubject =
      BehaviorSubject();

  BehaviorSubject<List<DashBoardThongKeModel>> listDashBoardThongKe =
      BehaviorSubject();

  BehaviorSubject<List<ChartData>> coCauLichHopSubject = BehaviorSubject();

  final BehaviorSubject<DanhSachLichHopModel> danhSachLichHopSubject =
      BehaviorSubject();

  final BehaviorSubject<List<DateTime>> eventsSubject = BehaviorSubject();

  Stream<List<DateTime>> get eventsStream => eventsSubject.stream;

  BehaviorSubject<DashBoardLichHopModel> dashBoardSubject = BehaviorSubject();

  Stream<DashBoardLichHopModel> get dashBoardStream => dashBoardSubject.stream;

  Stream<List<MeetingSchedule>> get listMeetingStream =>
      listMeetTingScheduleSubject.stream;

  Stream<DanhSachLichHopModel> get danhSachLichHopStream =>
      danhSachLichHopSubject.stream;

  void changeScreenMenu(TypeCalendarMenu typeMenu) {
    changeItemMenuSubject.add(typeMenu);
  }

  void initDataMenu() {
    final List<ItemThongBaoModelMyCalender> listTheoTrangThai =
        dataMenu[1].listWidget ?? [];

    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_DUYET_THIET_BI,
    )) {
      listTheoTrangThai.add(
        ItemThongBaoModelMyCalender(
          typeMenu: TypeCalendarMenu.LichDuyetThietBi,
          type: TypeContainer.number,
        ),
      );
    }
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.DUYET_KY_THUAT,
    )) {
      listTheoTrangThai.add(
        ItemThongBaoModelMyCalender(
          typeMenu: TypeCalendarMenu.LichDuyetKyThuat,
          type: TypeContainer.number,
        ),
      );
    }
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.YEU_CAU_CHUAN_BI,
    )) {
      listTheoTrangThai.add(
        ItemThongBaoModelMyCalender(
          typeMenu: TypeCalendarMenu.LichYeuCauChuanBi,
          type: TypeContainer.number,
        ),
      );
    }

    dataMenu[1].listWidget = listTheoTrangThai;
    dataMenu[2].listWidget = listLanhDaoLichHop;
  }

  double getMax(List<ToChucBoiDonViModel> data) {
    double value = 0;
    data.forEach((element) {
      if ((element.quantities?.toDouble() ?? 0.0) > value) {
        value = element.quantities?.toDouble() ?? 0.0;
      }
    });
    final double range = value % 10;

    return (value + (10.0 - range)) / 5.0;
  }

  double getMaxTiLe(List<TiLeThamGiaModel> data) {
    double value = 0;
    data.forEach((element) {
      if ((element.rate?.toDouble() ?? 0.0) > value) {
        value = element.rate?.toDouble() ?? 0.0;
      }
    });

    final double range = value % 10;

    return (value + (10.0 - range)) / 5.0;
  }

  Future<void> searchLichHop(String? query) async {
    Timer(const Duration(microseconds: 500), () {
      listDSLH.clear();
      if (query == null || query.isEmpty) {
        postDanhSachLichHop();
      } else {
        postDanhSachLichHop(query);
      }
    });
  }

  Future<void> postCoCauLichHop() async {
    final result = await hopRepo.postCoCauLichHop(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );

    final List<ChartData> dataCoCauLichHop = [];

    result.when(
      success: (value) {
        for (var i in value) {
          dataCoCauLichHop.add(
            ChartData(
              i.name ?? '',
              i.quantities?.toDouble() ?? 0,
              i.color ?? Colors.white,
            ),
          );
        }
        idThongKe = value[indexThongKe].id ?? '';
        coCauLichHopSubject.add(dataCoCauLichHop);
      },
      error: (error) {},
    );
  }

  Future<void> postToChucBoiDonVi() async {
    showLoading();
    final result = await hopRepo.postToChucBoiDonVi(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );

    result.when(
      success: (value) {
        toChucBoiDonViSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> postTiLeThamDu() async {
    final result = await hopRepo.postTiLeThamGia(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );

    result.when(
      success: (value) {
        tiLeThamGiaSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> getDashBoardThongKe() async {
    showLoading();
    final result = await hopRepo.getDashBoardThongKe(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );

    result.when(
      success: (success) {
        listDashBoardThongKe.add(success);
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> menuCalendar() async {
    final result = await hopRepo.getDataMenu(
      startDate.formatApi,
      endDate.formatApi,
    );

    result.when(
      success: (value) {
        listLanhDaoLichHop.clear();
        value.forEach((element) {
          listLanhDaoLichHop.add(
            ItemThongBaoModelMyCalender(
              typeMenu: TypeCalendarMenu.LichTheoLanhDao,
              type: TypeContainer.number,
              menuModel: element,
            ),
          );
        });
        menuModelSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> postEventsCalendar({
    TypeCalendarMenu typeCalendar = TypeCalendarMenu.LichCuaToi,
  }) async {
    showLoading();

    final result = await hopRepo.postEventCalendar(
      EventCalendarRequest(
        Title: '',
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: donViId,
        isLichCuaToi: typeCalendar == TypeCalendarMenu.LichCuaToi,
        month: selectDay.month,
        PageIndex: page,
        PageSize: 10,
        UserId: userId,
        year: selectDay.year,
      ),
    );
    result.when(
      success: (value) {
        final List<DateTime> data = [];

        value.forEach((element) {
          data.add(element.convertStringToDate());
        });

        eventsSubject.add(data);
      },
      error: (error) {},
    );
    showContent();
  }

  bool checkDataList(List<dynamic> data) {
    for (var i in data) {
      if (i.quantities != 0) return true;
    }
    return false;
  }

  bool checkDataRateList(List<TiLeThamGiaModel> data) {
    for (var i in data) {
      if (i.rate != 0) return true;
    }
    return false;
  }

  void getDataCalendar(
    DateTime startTime,
    DateTime endTime,
    DateTime selectTime,
    Type_Choose_Option_Day type,
  ) {
    startDate = startTime;
    endDate = endTime;
    selectDay = selectTime;
    listDSLH.clear();
    page = 1;

    if (type == Type_Choose_Option_Day.DAY) {
      postDSLHDay();
    } else if (type == Type_Choose_Option_Day.WEEK) {
      postDSLHWeek();
    } else {
      postDSLHMonth();
    }
    final CalendarController controller = CalendarController();
    controller.displayDate = selectTime;
    stateCalendarSubject.add(controller);
  }

  Future<void> initData() async {
    page = 1;
    getDashboard();
    postDanhSachLichHop(null, true);
    postEventsCalendar();
    menuCalendar();
    initDataMenu();
    postStatisticByMonth();
    getDashBoardThongKe();
    postCoCauLichHop();
    postToChucBoiDonVi();
    postTiLeThamDu();
  }

  Future<void> postStatisticByMonth() async {
    showLoading();

    final result = await hopRepo.postStatisticByMonth(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );

    result.when(
      success: (success) {
        statisticSubject.add(success);
      },
      error: (error) {},
    );

    showContent();
  }

  Future<void> getDashboard() async {
    showLoading();

    final result = await hopRepo.getDashBoardLichHop(
      startDate.formatApi,
      endDate.formatApi,
    );

    result.when(
      success: (value) {
        listItemSchedule[0].numberOfSchedule = value.soLichChuTri ?? 0;
        listItemSchedule[2].numberOfSchedule = value.soLichSapToi ?? 0;
        listItemSchedule[3].numberOfSchedule = value.soLichTrung ?? 0;
        dashBoardSubject.add(value);
      },
      error: (error) {},
    );

    showContent();
  }

  BehaviorSubject<List<ListPhienHopModel>> phienHopSubject = BehaviorSubject();
  List<ListPhienHopModel> listPhienHop = [];

  Future<void> getDanhSachPhienHop({
    required String id,
  }) async {
    showLoading();
    final result = await hopRepo.getDanhSachPhienHop(id);
    result.when(
      success: (value) {
        listPhienHop = value;
        phienHopSubject.sink.add(listPhienHop);
      },
      error: (error) {},
    );
    showContent();
  }

  void postDSLHWeek() {
    final day = selectDay;
    startDate = day.subtract(Duration(days: day.weekday - 1));
    endDate = day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
    listDSLH.clear();
    page = 1;

    if (isListThongKeSubject.value) {
      postDanhSachThongKe();
    } else {
      getDashboard();
      postEventsCalendar();
      postDanhSachLichHop();
    }
    menuCalendar();
    postStatisticByMonth();

    getDashBoardThongKe();
    postCoCauLichHop();
    postToChucBoiDonVi();
    postTiLeThamDu();
    stateCalendarSubject.add(CalendarController());
  }

  void postDSLHMonth() {
    final day = selectDay;
    startDate = DateTime(day.year, day.month, 1);
    endDate = DateTime(day.year, day.month + 1, 0);

    listDSLH.clear();
    page = 1;
    if (isListThongKeSubject.value) {
      postDanhSachThongKe();
    } else {
      getDashboard();
      postEventsCalendar();
      postDanhSachLichHop();
    }
    menuCalendar();
    postStatisticByMonth();

    getDashBoardThongKe();
    postCoCauLichHop();
    postToChucBoiDonVi();
    postTiLeThamDu();
    stateCalendarSubject.add(CalendarController());
  }

  void postDSLHDay() {
    startDate = selectDay;
    endDate = selectDay;
    listDSLH.clear();
    page = 1;
    if (isListThongKeSubject.value) {
      postDanhSachThongKe();
    } else {
      getDashboard();
      postEventsCalendar();
      postDanhSachLichHop();
    }
    menuCalendar();
    postStatisticByMonth();
    getDashBoardThongKe();
    postCoCauLichHop();
    postToChucBoiDonVi();
    postTiLeThamDu();
    stateCalendarSubject.add(CalendarController());
  }

  Future<void> postDanhSachThongKe() async {
    showLoading();
    final result = await hopRepo.postDanhSachThongKe(
      DanhSachThongKeRequest(
        dateFrom: startDate.formatApiDDMMYYYYSlash,
        dateTo: endDate.formatApiDDMMYYYYSlash,
        pageIndex: page,
        pageSize: 10,
        typeCalendarId: idThongKe,
      ),
    );
    result.when(
      success: (value) {
        totalPage = value.totalPage ?? 1;
        danhSachLichHopSubject.add(value);
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> postDanhSachLichHop([String? search, bool isRefesh = false,]) async {
    showLoading();
    final result = await hopRepo.postDanhSachLichHop(
      DanhSachLichHopRequest(
        Title: search,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
            ? idDonViLanhDao
            : donViId,
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
        isLichHuyBo: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichHuy),
        isLichThuHoi: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichThuHoi),
        isDuyetLich: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.ChoDuyet),
        isChuaCoBaoCao: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichHopCanKLCH),
        isDaCoBaoCao: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichDaKLCH),
        isDuyetPhong: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichDuyetPhong),
        isLichYeuCauChuanBi: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichYeuCauChuanBi),
        isDuyetThietBi: changeItemMenuSubject.value
            .getListLichHop(TypeCalendarMenu.LichDuyetThietBi),
        isChoXacNhan: checkState(changeItemMenuSubject.value)
            ? getStateLDM.value.getListState(stateLDM.ChoXacNhan)
            : null,
        isLichThamGia: checkState(changeItemMenuSubject.value)
            ? getStateLDM.value.getListState(stateLDM.ThamGia)
            : null,
        isLichTuChoi: checkState(changeItemMenuSubject.value)
            ? getStateLDM.value.getListState(stateLDM.TuChoi)
            : null,
        PageIndex: page,
        PageSize: typeLH == Type_Choose_Option_List.DANG_LICH ? 1000 : 10,
        UserId: userId,
      ),
    );
    result.when(
      success: (value) {
        if(isRefesh) {
          listDSLH.clear();
        }
        totalPage = value.totalPage ?? 1;

        listDSLH.addAll(value.items ?? []);

        value.items = listDSLH;
        danhSachLichHopSubject.add(value);
      },
      error: (error) {},
    );
    showContent();
  }

  bool checkState(TypeCalendarMenu type) {
    if (type == TypeCalendarMenu.LichDuocMoi ||
        type == TypeCalendarMenu.ChoDuyet ||
        type == TypeCalendarMenu.LichDuyetPhong ||
        type == TypeCalendarMenu.LichDuyetThietBi ||
        type == TypeCalendarMenu.LichDaCoBaoCao ||
        type == TypeCalendarMenu.LichDuyetKyThuat ||
        type == TypeCalendarMenu.LichYeuCauChuanBi) {
      return true;
    } else {
      return false;
    }
  }

  List<String> listImageLichHopCuaToi = [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.lichCanKlch,
    ImageAssets.lichSapToi,
    ImageAssets.icLichCongTacNuocNgoai,
  ];

  List<String> listImageLichHopThongKe = [
    ImageAssets.icTongSoLichHop,
    ImageAssets.icLichHopTrucTuyen,
    ImageAssets.icLichHopTrucTiep,
  ];

  // them tai lieu tao lich hop
  // Future<void> postFileTaoLichHop({
  //   required int entityType,
  //   required String entityName,
  //   required String entityId,
  //   required bool isMutil,
  //   required List<File> files,
  // }) async {
  //   showLoading();
  //   await hopRepo
  //       .postFileTaoLichHop(entityType, entityName, entityId, isMutil, files)
  //       .then((value) {
  //     value.when(
  //       success: (res) {},
  //       error: (err) {},
  //     );
  //   });
  // }

  dynamic currentTime = DateFormat.MMMMEEEEd().format(DateTime.now());

  DataSource getCalenderDataSource(DanhSachLichHopModel model) {
    List<Appointment> appointments = [];
    RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 2;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.recurrenceCount = 10;
    for (int i = 0; i < (model.items?.length ?? 0); i++) {
      appointments.add(
        Appointment(
          startTime: DateTime.parse(model.items?[i].dateTimeFrom ?? ''),
          endTime: DateTime.parse(model.items?[i].dateTimeTo ?? ''),
          subject: model.items?[i].title ?? '',
          color: textColorMangXaHoi,
          id: model.items?[i].id ?? '',
        ),
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
    } else if (type == Type_Choose_Option_List.DANG_THONG_KE) {
      emit(const LichHopStateDangThongKe(Type_Choose_Option_Day.DAY));
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
    if (state is LichHopStateDangThongKe) {
      emit(LichHopStateDangThongKe(type));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
extension HandleDataCalendar on LichHopCubit {
  // Future<void> updateDataSlideCalendar(DateTime timeSlide) async {
  //   if (!changeDateByClick) {
  //     showLoading();
  //     selectDay = timeSlide;
  //     await postEventsCalendar();
  //     initTimeSubject.add(selectDay);
  //     moveTimeSubject.add(selectDay);
  //
  //     if (stateOptionDay == Type_Choose_Option_Day.DAY) {
  //       await callApiDayCalendar();
  //     }
  //     if (stateOptionDay == Type_Choose_Option_Day.WEEK) {
  //       await callApiWeekCalendar();
  //     }
  //     if (stateOptionDay == Type_Choose_Option_Day.MONTH) {
  //       await callApiMonthCalendar();
  //     }
  //     showContent();
  //   }
  // }
  //
  // Future<void> callApi() async {
  //   showLoading();
  //   listDSLH.clear();
  //   page = 1;
  //   await getListLichLV();
  //   await dataLichLamViec(
  //     startDate: startDates.formatApi,
  //     endDate: endDates.formatApi,
  //   );
  //   await dataLichLamViecRight(
  //     startDate: startDates.formatApi,
  //     endDate: endDates.formatApi,
  //     type: 0,
  //   );
  //   await menuCalendar();
  //   showContent();
  // }
  //
  // void getMatchDate(DataLichLvModel data) {
  //   if ((data.listLichLVModel ?? []).isEmpty) {
  //     return;
  //   }
  //   (data.listLichLVModel ?? []).sort(
  //         (a, b) => DateTime.parse(
  //       a.dateTimeFrom ?? '',
  //     ).compareTo(
  //       DateTime.parse(
  //         b.dateTimeFrom ?? '',
  //       ),
  //     ),
  //   );
  //   for (final ListLichLVModel e in data.listLichLVModel ?? []) {
  //     (data.listLichLVModel ?? [])
  //         .where(
  //           (i) =>
  //       (DateTime.parse(
  //         e.dateTimeTo ?? '',
  //       ).isAfter(
  //         DateTime.parse(
  //           i.dateTimeFrom ?? '',
  //         ),
  //       ) ||
  //           DateTime.parse(
  //             e.dateTimeFrom ?? '',
  //           ).isAtSameMomentAs(
  //             DateTime.parse(
  //               i.dateTimeFrom ?? '',
  //             ),
  //           )) &&
  //           DateTime.parse(
  //             e.dateTimeFrom ?? '',
  //           ).isBefore(
  //             DateTime.parse(
  //               i.dateTimeFrom ?? '',
  //             ),
  //           ) &&
  //           i.id != e.id,
  //     )
  //         .toList()
  //         .forEach((element) {
  //       element.isTrung = true;
  //       e.isTrung = true;
  //     });
  //   }
  // }

  bool isMatch(DateTime? oldData, DateTime? newData) {
    if (oldData == newData) return true;

    return false;
  }
}
