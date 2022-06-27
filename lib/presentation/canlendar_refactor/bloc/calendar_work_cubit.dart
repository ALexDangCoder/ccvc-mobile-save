import 'dart:async';

import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWorkCubit extends BaseCubit<CalendarWorkState> {
  CalendarWorkCubit() : super(const CalendarViewState());

  CalendarWorkRepository get calendarWorkRepo => Get.find();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime startDateHaveEvent = DateTime.now();
  DateTime endDateHaveEvent = DateTime.now();
  String keySearch = '';
  String keySearchHaveEvent = '';
  String? idDonViLanhDao;
  StateType stateType = StateType.CHO_XAC_NHAN;

  bool apiCalling = false;

  StatusWorkCalendar? statusType = StatusWorkCalendar.LICH_CUA_TOI;

  final CalendarController fCalendarControllerDay = CalendarController();

  final CalendarController fCalendarControllerWeek = CalendarController();

  final CalendarController fCalendarControllerMonth = CalendarController();

  final controller = ChooseTimeController();

  final PagingController<int, ListLichLVModel> worksPagingController =
      PagingController(firstPageKey: 0);

  //data subject

  final BehaviorSubject<DataSourceFCalendar> _listCalendarWorkDaySubject =
      BehaviorSubject();
  Stream<DataSourceFCalendar> get listCalendarWorkDayStream =>
      _listCalendarWorkDaySubject.stream;
  final BehaviorSubject<DataSourceFCalendar> _listCalendarWorkWeekSubject =
      BehaviorSubject();
  Stream<DataSourceFCalendar> get listCalendarWorkWeekStream =>
      _listCalendarWorkWeekSubject.stream;
  final BehaviorSubject<DataSourceFCalendar> _listCalendarWorkMonthSubject =
      BehaviorSubject();
  Stream<DataSourceFCalendar> get listCalendarWorkMonthStream =>
      _listCalendarWorkMonthSubject.stream;

  final BehaviorSubject<List<DateTime>> _listNgayCoLich =
      BehaviorSubject<List<DateTime>>();

  Stream<List<DateTime>> get listNgayCoLichStream => _listNgayCoLich.stream;

  final BehaviorSubject<List<LichLamViecDashBroadItem>> _dashBroadSubject =
      BehaviorSubject();

  Stream<List<LichLamViecDashBroadItem>> get dashBroadStream =>
      _dashBroadSubject.stream;

  final BehaviorSubject<DashBoardLichHopModel> _totalWorkSubject =
      BehaviorSubject();

  Stream<DashBoardLichHopModel> get totalWorkStream => _totalWorkSubject.stream;

  final BehaviorSubject<List<MenuModel>> _menuDataSubject = BehaviorSubject();

  Stream<List<MenuModel>> get menuDataStream => _menuDataSubject.stream;

  //viewSubject

  final BehaviorSubject<String> _titleSubject = BehaviorSubject();

  Stream<String> get titleStream => _titleSubject.stream;

  final BehaviorSubject<bool> _isLichDuocMoiSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isLichDuocMoiStream => _isLichDuocMoiSubject.stream;

  void setMenuChoose({
    String? idDonViLanhDao,
    StatusWorkCalendar? statusType,
  }) {
    if (statusType != null) {
      this.idDonViLanhDao = null;
      this.statusType = statusType;
      if (statusType == StatusWorkCalendar.LICH_DUOC_MOI) {
        _isLichDuocMoiSubject.sink.add(true);
        stateType = StateType.CHO_XAC_NHAN;
      } else {
        _isLichDuocMoiSubject.sink.add(false);
      }
      _titleSubject.sink.add(statusType.getTitle());
    }
    if (idDonViLanhDao != null) {
      this.idDonViLanhDao = idDonViLanhDao;
      this.statusType = null;
    }
  }

  Future<void> refreshApi() async {
    showLoading();
    final Queue queue = Queue();
    unawaited(queue.add(() => getMenuData()));
    unawaited(queue.add(() => getTotalWork()));
    unawaited(queue.add(() => getDashboardSchedule()));
    if (state is CalendarViewState) {
      unawaited(queue.add(() => getFullListWork()));
    } else {
      worksPagingController.refresh();
    }
    await queue.onComplete;
    showContent();
  }

  Future<void> callApiByMenu({
    String? idDonViLanhDao,
    StatusWorkCalendar? status,
  }) async {
    setMenuChoose(
      idDonViLanhDao: idDonViLanhDao,
      statusType: status,
    );
    await refreshApi();
  }

  Future<void> callApiByNewFilter({
    required DateTime startDate,
    required DateTime endDate,
    required String keySearch,
  }) async {
    if (!apiCalling) {
      apiCalling = true;
      this.startDate = startDate;
      this.endDate = endDate;
      this.keySearch = keySearch;
      fCalendarControllerDay.selectedDate = this.startDate;
      fCalendarControllerDay.displayDate = this.startDate;
      fCalendarControllerWeek.selectedDate = this.startDate;
      fCalendarControllerWeek.displayDate = this.startDate;
      fCalendarControllerMonth.selectedDate = this.startDate;
      fCalendarControllerMonth.displayDate = this.startDate;
      await refreshApi();
      apiCalling = false;
    }
  }

  void menuClick(DataItemMenu? value, BaseState) {
    if (BaseState is ListViewState) {
      emitList();
      if (statusType == StatusWorkCalendar.LICH_DUOC_MOI) {
        stateType = StateType.CHO_XAC_NHAN;
        worksPagingController.refresh();
      }
    } else {
      emitCalendar();
    }
    if (value != null) {
      if (value is StatusDataItem) {
        callApiByMenu(status: value.value);
      }
      if (value is LeaderDataItem) {
        callApiByMenu(idDonViLanhDao: value.id);
        _titleSubject.sink.add(value.title);
      }
    }
  }

  void checkDuplicate(List<ListLichLVModel> list) {
    for (final item in list) {
      final currentTimeFrom =
          getDate(item.dateTimeFrom ?? '').millisecondsSinceEpoch;
      final currentTimeTo =
          getDate(item.dateTimeTo ?? '').millisecondsSinceEpoch;
      final listDuplicate = list.where((element) {
        final startTime =
            getDate(element.dateTimeFrom ?? '').millisecondsSinceEpoch;
        if (startTime >= currentTimeFrom && startTime < currentTimeTo) {
          return true;
        }
        return false;
      });
      if (listDuplicate.length > 1) {
        for (int i = 0; i < listDuplicate.length; i++) {
          listDuplicate.elementAt(i).isTrung = true;
        }
      }
    }
  }

  DateTime getDate(String time) =>
      time.convertStringToDate(formatPattern: DateTimeFormat.DATE_TIME_RECEIVE);

  void emitList({CalendarType? type}) =>
      emit(ListViewState(typeView: type ?? state.typeView));

  void emitCalendar({CalendarType? type}) =>
      emit(CalendarViewState(typeView: type ?? state.typeView));
}

extension GetData on CalendarWorkCubit {
  Future<void> getMenuData() async {
    final result = await calendarWorkRepo.getDataMenu(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (value) {
        _menuDataSubject.sink.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> getTotalWork() async {
    final result = await calendarWorkRepo.getLichLv(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (res) {
        _totalWorkSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> dayHaveEvent(
      DateTime? startDate, DateTime? endDate, String? keySearch) async {
    if (startDate != null && endDate != null && keySearch != null) {
      startDateHaveEvent = startDate;
      endDateHaveEvent = endDate;
      this.keySearch = keySearch;
    }
    final result = await calendarWorkRepo.postEventCalendar(
      EventCalendarRequest(
        Title: keySearchHaveEvent,
        DateFrom: startDateHaveEvent.formatApi,
        DateTo: endDateHaveEvent.formatApi,
        DonViId: idDonViLanhDao ??
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
            '',
        IsLichLanhDao: idDonViLanhDao != null ? true : null,
        isLichCuaToi: statusType == StatusWorkCalendar.LICH_CUA_TOI ? true : null,
        isLichDuocMoi: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichTaoHo: statusType == StatusWorkCalendar.LICH_TAO_HO,
        isLichHuyBo: statusType == StatusWorkCalendar.LICH_HUY,
        isLichThuHoi: statusType == StatusWorkCalendar.LICH_THU_HOI,
        isChuaCoBaoCao: statusType == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
        isDaCoBaoCao: statusType == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
        isChoXacNhan: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
        month: startDateHaveEvent.month,
        PageIndex: ApiConstants.PAGE_BEGIN,
        PageSize: 1000,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        year: startDateHaveEvent.year,
      ),
    );
    result.when(
      success: (value) {
        final data = value.map((e) => DateTime.parse(e)).toList();
        _listNgayCoLich.sink.add(data);
      },
      error: (error) {},
    );
  }

  Future<void> getDashboardSchedule() async {
    final LichLamViecRightRequest request = LichLamViecRightRequest(
      dateFrom: startDate.formatApi,
      dateTo: endDate.formatApi,
      type: 0,
    );
    final result = await calendarWorkRepo.getLichLvRight(request);
    result.when(
      success: (res) {
        _dashBroadSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> getListWorkLoadMore({
    int pageIndex = ApiConstants.PAGE_BEGIN,
  }) async {
    try {
      final currentPage = pageIndex ~/ ApiConstants.DEFAULT_PAGE_SIZE;
      List<ListLichLVModel> newItems = [];
      final DanhSachLichLamViecRequest request = getDanhSachLichLVRequest(
        pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
        pageIndex: currentPage + 1,
      );
      final result = await calendarWorkRepo.getListLichLamViec(request);
      result.when(
        success: (res) {
          newItems = res.listLichLVModel ?? [];
          checkDuplicate([...?worksPagingController.itemList, ...newItems]);
        },
        error: (error) {},
      );

      final isLastPage = newItems.length < ApiConstants.DEFAULT_PAGE_SIZE;
      if (isLastPage) {
        worksPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageIndex + newItems.length;
        worksPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      worksPagingController.error = error;
    }
  }

  Future<void> getFullListWork({
    String? idDonViLanhDao,
  }) async {
    final DanhSachLichLamViecRequest data = getDanhSachLichLVRequest(
      pageSize: 10000,
      pageIndex: ApiConstants.PAGE_BEGIN,
    );
    final result = await calendarWorkRepo.getListLichLamViec(data);
    result.when(
      success: (res) {
        _listCalendarWorkDaySubject.sink.add(res.toDataFCalenderSource());
        _listCalendarWorkWeekSubject.sink.add(res.toDataFCalenderSource());
        _listCalendarWorkMonthSubject.sink.add(res.toDataFCalenderSource());
      },
      error: (error) {},
    );

    //to do
  }

  DanhSachLichLamViecRequest getDanhSachLichLVRequest({
    required int pageIndex,
    required int pageSize,
  }) {
    final isLichDuocMoi = statusType == StatusWorkCalendar.LICH_DUOC_MOI;
    return DanhSachLichLamViecRequest(
      DateFrom: startDate.formatApi,
      DateTo: endDate.formatApi,
      DonViId: idDonViLanhDao ??
          HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
          '',
      IsLichLanhDao: idDonViLanhDao != null ? true : null,
      isLichCuaToi: statusType == StatusWorkCalendar.LICH_CUA_TOI ? true : null,
      isLichDuocMoi: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
      isLichTaoHo: statusType == StatusWorkCalendar.LICH_TAO_HO,
      isLichHuyBo: statusType == StatusWorkCalendar.LICH_HUY,
      isLichThuHoi: statusType == StatusWorkCalendar.LICH_THU_HOI,
      isChuaCoBaoCao: statusType == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
      isDaCoBaoCao: statusType == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
      isChoXacNhan: stateType == StateType.CHO_XAC_NHAN &&
          isLichDuocMoi &&
          state is ListViewState,
      isLichThamGia: stateType == StateType.THAM_GIA &&
          isLichDuocMoi &&
          state is ListViewState,
      isLichTuChoi: stateType == StateType.TU_CHOI &&
          isLichDuocMoi &&
          state is ListViewState,
      PageIndex: pageIndex,
      PageSize: pageSize,
      Title: keySearch,
      UserId: HiveLocal.getDataUser()?.userId ?? '',
    );
  }
}

extension ListenCalendarController on CalendarWorkCubit {
  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  void changeCalendarDate(DateTime oldDate, DateTime newDate) {
    final currentDate = getOnlyDate(oldDate);
    final dateSelect = getOnlyDate(newDate);
    if (currentDate.millisecondsSinceEpoch <
        dateSelect.millisecondsSinceEpoch) {
      controller.nextTime();
    }
    if (currentDate.millisecondsSinceEpoch >
        dateSelect.millisecondsSinceEpoch) {
      controller.backTime();
    }
  }

  void propertyChangedDay(String property) {
    if (property == 'displayDate') {
      changeCalendarDate(
          startDate, fCalendarControllerDay.displayDate ?? startDate);
    }
  }

  void propertyChangedWeek(String property) {
    if (property == 'displayDate') {
      changeCalendarDate(
          startDate, fCalendarControllerWeek.displayDate ?? startDate);
    }
  }

  void propertyChangedMonth(String property) {
    if (property == 'displayDate') {
      changeCalendarDate(
          startDate, fCalendarControllerMonth.displayDate ?? startDate);
    }
  }
}

enum TypeCalendar { MeetingSchedule, Schedule }

TypeCalendar getType(String type) {
  switch (type) {
    case 'MeetingSchedule':
      return TypeCalendar.MeetingSchedule;
    case 'Schedule':
      return TypeCalendar.Schedule;
    default:
      return TypeCalendar.Schedule;
  }
}

enum StatusWorkCalendar {
  LICH_CUA_TOI,
  LICH_DUOC_MOI,
  LICH_TAO_HO,
  LICH_HUY,
  LICH_THU_HOI,
  LICH_DA_CO_BAO_CAO,
  LICH_CHUA_CO_BAO_CAO,
}

extension StatusWorkCalendarExt on StatusWorkCalendar {
  String getTitle() {
    switch (this) {
      case StatusWorkCalendar.LICH_CUA_TOI:
        return S.current.lich_cua_toi;
      case StatusWorkCalendar.LICH_DUOC_MOI:
        return S.current.lich_duoc_moi;
      case StatusWorkCalendar.LICH_TAO_HO:
        return S.current.lich_tao_ho;
      case StatusWorkCalendar.LICH_HUY:
        return S.current.lich_huy;
      case StatusWorkCalendar.LICH_THU_HOI:
        return S.current.lich_thu_hoi;
      case StatusWorkCalendar.LICH_DA_CO_BAO_CAO:
        return S.current.lich_da_co_bao_cao;
      case StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO:
        return S.current.lich_chua_co_bao_cao;
    }
  }
}
