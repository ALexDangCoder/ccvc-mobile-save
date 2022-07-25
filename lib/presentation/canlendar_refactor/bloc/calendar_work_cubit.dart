import 'dart:async';

import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
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
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/common/calendar_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

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
  final BehaviorSubject<List<ListLichLVModel>> _listWorkSubject =
      BehaviorSubject();

  Stream<List<ListLichLVModel>> get listWorkStream => _listWorkSubject.stream;

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

  final BehaviorSubject<StatusWorkCalendar?> _statusWorkSubject =
      BehaviorSubject.seeded(StatusWorkCalendar.LICH_CUA_TOI);

  Stream<StatusWorkCalendar?> get statusWorkSubjectStream =>
      _statusWorkSubject.stream;

  void setMenuChoose({
    String? idDonViLanhDao,
    StatusWorkCalendar? statusType,
  }) {
    if (statusType != null) {
      this.idDonViLanhDao = null;
      this.statusType = statusType;
      _statusWorkSubject.sink.add(statusType);
      if (statusType == StatusWorkCalendar.LICH_DUOC_MOI) {
        stateType = StateType.CHO_XAC_NHAN;
      }
      _titleSubject.sink.add(statusType.getTitleWork());
    }
    if (idDonViLanhDao != null) {
      _statusWorkSubject.sink.add(null);
      this.idDonViLanhDao = idDonViLanhDao;
      this.statusType = null;
    }
  }

  Future<void> refreshApi() async {
    showLoading();
    final Queue queue = Queue(parallel: 5);
    unawaited(queue.add(() => getMenuData()));
    unawaited(queue.add(() => getTotalWork()));
    unawaited(queue.add(() => dayHaveEvent()));
    unawaited(queue.add(() => getDashboardSchedule()));
    unawaited(queue.add(() => getFullListWork()));
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
      showLoading();
      final Queue queue = Queue(parallel: 4);
      unawaited(queue.add(() => getMenuData()));
      unawaited(queue.add(() => getTotalWork()));
      unawaited(queue.add(() => getDashboardSchedule()));
      unawaited(queue.add(() => getFullListWork()));
      await queue.onComplete;
      showContent();
      apiCalling = false;
    }
  }

  void menuClick(DataItemMenu? value, BaseState state) {
    if (state is ListViewState) {
      emitList();
      if (statusType == StatusWorkCalendar.LICH_DUOC_MOI) {
        stateType = StateType.CHO_XAC_NHAN;
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
      if (!item.isTrung) {
        final currentTimeFrom =
            getDate(item.dateTimeFrom ?? '').millisecondsSinceEpoch;
        final currentTimeTo =
            getDate(item.dateTimeTo ?? '').millisecondsSinceEpoch;
        final subTimeCurrent = currentTimeTo - currentTimeFrom;
        for (final element in list) {
          final startTimeCompare =
              getDate(element.dateTimeFrom ?? '').millisecondsSinceEpoch;
          final endTimeCompare =
              getDate(element.dateTimeTo ?? '').millisecondsSinceEpoch;
          final listStartEndTime = [
            currentTimeFrom,
            currentTimeTo,
            startTimeCompare,
            endTimeCompare
          ];
          listStartEndTime.sort();
          final subTimeCompare = endTimeCompare - startTimeCompare;
          if ((listStartEndTime[0] - listStartEndTime[3]).abs() <
                  (subTimeCompare + subTimeCurrent) &&
              item.id != element.id) {
            element.isTrung = true;
            item.isTrung = true;
          }
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

  Future<void> dayHaveEvent({DateTime? startDate, DateTime? endDate}) async {
    if (startDate != null && endDate != null) {
      startDateHaveEvent = startDate;
      endDateHaveEvent = endDate;
    }
    final result = await calendarWorkRepo.postEventCalendar(
      EventCalendarRequest(
        Title: keySearch,
        DateFrom: startDateHaveEvent.formatApi,
        DateTo: endDateHaveEvent.formatApi,
        DonViId: idDonViLanhDao ??
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
            '',
        IsLichLanhDao: idDonViLanhDao != null ? true : null,
        isLichCuaToi:
            statusType == StatusWorkCalendar.LICH_CUA_TOI ? true : null,
        isLichDuocMoi: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichTaoHo: statusType == StatusWorkCalendar.LICH_TAO_HO,
        isLichHuyBo: statusType == StatusWorkCalendar.LICH_HUY,
        isLichThuHoi: statusType == StatusWorkCalendar.LICH_THU_HOI,
        isChuaCoBaoCao: statusType == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
        isDaCoBaoCao: statusType == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
        // isChoXacNhan: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
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

  Future<void> getFullListWork() async {
    final DanhSachLichLamViecRequest data = getDanhSachLichLVRequest();
    final result = await calendarWorkRepo.getListLichLamViec(data);
    result.when(
      success: (res) {
        checkDuplicate(res.listLichLVModel ?? []);
        _listCalendarWorkDaySubject.sink.add(res.toDataFCalenderSource());
        _listCalendarWorkWeekSubject.sink.add(res.toDataFCalenderSource());
        _listCalendarWorkMonthSubject.sink.add(res.toDataFCalenderSource());
        _listWorkSubject.sink.add(res.listLichLVModel ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> updateList() async {
    showLoading();
    final Queue queue = Queue();
    unawaited(queue.add(() => getTotalWork()));
    unawaited(queue.add(() => getFullListWork()));
    await queue.onComplete;
    showContent();
  }

  DanhSachLichLamViecRequest getDanhSachLichLVRequest() {
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
      isChoXacNhan: stateType == StateType.CHO_XAC_NHAN && isLichDuocMoi,
      isLichThamGia: stateType == StateType.THAM_GIA && isLichDuocMoi,
      isLichTuChoi: stateType == StateType.TU_CHOI && isLichDuocMoi,
      PageIndex: null,
      PageSize: null,
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
        startDate,
        fCalendarControllerDay.displayDate ?? startDate,
      );
    }
  }

  void propertyChangedWeek(String property) {
    if (property == 'displayDate') {
      changeCalendarDate(
        startDate,
        fCalendarControllerWeek.displayDate ?? startDate,
      );
    }
  }

  void propertyChangedMonth(String property) {
    if (property == 'displayDate') {
      changeCalendarDate(
        startDate,
        fCalendarControllerMonth.displayDate ?? startDate,
      );
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
  CHO_DUYET,
  LICH_HOP_CAN_KLCH,
  LICH_DA_KLCH,
  LICH_DUYET_PHONG,
  LICH_DUYET_THIET_BI,
  LICH_DUYET_KY_THUAT,
  LICH_YEU_CAU_CHUAN_BI,
  LICH_CAN_DUYET,
  LICH_LANH_DAO,
}

extension StatusWorkCalendarExt on StatusWorkCalendar {
  String getTitleMeeting() {
    switch (this) {
      case StatusWorkCalendar.LICH_CUA_TOI:
        return S.current.lich_hop_cua_toi;
      case StatusWorkCalendar.LICH_DUOC_MOI:
        return S.current.lich_hop_duoc_moi;
      case StatusWorkCalendar.LICH_TAO_HO:
        return S.current.lich_hop_tao_ho;
      case StatusWorkCalendar.LICH_HUY:
        return S.current.lich_hop_huy;
      case StatusWorkCalendar.LICH_THU_HOI:
        return S.current.lich_hop_thu_hoi;
      case StatusWorkCalendar.LICH_DA_CO_BAO_CAO:
        return S.current.lich_da_co_bao_cao;
      case StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO:
        return S.current.lich_chua_co_bao_cao;
      case StatusWorkCalendar.CHO_DUYET:
        return S.current.lich_hop_cho_duyet;
      case StatusWorkCalendar.LICH_HOP_CAN_KLCH:
        return S.current.lich_hop_can_klch;
      case StatusWorkCalendar.LICH_DA_KLCH:
        return S.current.lich_hop_da_klch;
      case StatusWorkCalendar.LICH_DUYET_PHONG:
        return S.current.lich_hop_duyet_phong;
      case StatusWorkCalendar.LICH_DUYET_THIET_BI:
        return S.current.lich_hop_duyet_thiet_bi;
      case StatusWorkCalendar.LICH_DUYET_KY_THUAT:
        return S.current.lich_hop_duyet_ky_thuat;
      case StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI:
        return S.current.lich_hop_duyet_yeu_cau_tb;
      case StatusWorkCalendar.LICH_CAN_DUYET:
        return S.current.lich_hop_can_duyet;
      case StatusWorkCalendar.LICH_LANH_DAO:
        return S.current.lich_hop_lanh_dao;
    }
  }

  String getTitleWork() {
    switch (this) {
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
      default:
        return S.current.lich_cua_toi;
    }
  }
}
