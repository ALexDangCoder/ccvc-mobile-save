import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
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
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMeetingCubit extends BaseCubit<CalendarMeetingState> {
  CalendarMeetingCubit() : super(const CalendarViewState()) {
    showContent();
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String keySearch = '';
  String? idDonViLanhDao;
  StateType? stateType;
  StatusWorkCalendar? typeCalender = StatusWorkCalendar.LICH_CUA_TOI;

  HopRepository get hopRepo => Get.find();

  List<ChildMenu> listMenuTheoTrangThai = [];

  final BehaviorSubject<String> _titleSubject = BehaviorSubject();

  Stream<String> get titleStream => _titleSubject.stream;

  final controller = ChooseTimeController();

  final CalendarController fCalendarControllerDay = CalendarController();

  final CalendarController fCalendarControllerWeek = CalendarController();

  final CalendarController fCalendarControllerMonth = CalendarController();

  final BehaviorSubject<List<MenuModel>> _menuDataSubject = BehaviorSubject();

  Stream<List<MenuModel>> get menuDataStream => _menuDataSubject.stream;

  final BehaviorSubject<DashBoardLichHopModel> _totalWorkSubject =
      BehaviorSubject();

  Stream<DashBoardLichHopModel> get totalWorkStream => _totalWorkSubject.stream;

  final BehaviorSubject<List<DateTime>> _listNgayCoLich =
      BehaviorSubject<List<DateTime>>();

  Stream<List<DateTime>> get listNgayCoLichStream => _listNgayCoLich.stream;

  final BehaviorSubject<bool> _isLichDuocMoiSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isLichDuocMoiStream => _isLichDuocMoiSubject.stream;

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

  // final PagingController<int, ListLichLVModel> worksPagingController =
  // PagingController(firstPageKey: 0);

  void initData() {
    getCountDashboard();
    getMenuLichLanhDao();
    getDanhSachLichHop();
  }

  void refreshData({bool isLichLanhDao = false}) {
    getCountDashboard();
    getDanhSachLichHop(isLichLanhDao: isLichLanhDao);
    getDaysHaveEvent(
        startDate: startDate, endDate: endDate, keySearch: keySearch,);
  }

  /// Lấy danh sách menu lịch lãnh đạo:
  Future<void> getMenuLichLanhDao() async {
    final result = await hopRepo.getDataMenu(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (value) {
        _menuDataSubject.sink.add(value);
      },
      error: (error) {},
    );
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Lấy danh sách menu theo trạng thaí lịch:
  List<ChildMenu> getMenuLichTheoTrangThai(DashBoardLichHopModel countData) {
     listMenuTheoTrangThai = [
      ChildMenu(
        title: StatusWorkCalendar.LICH_DUOC_MOI.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_DUOC_MOI,
        ),
        count: countData.tongLichDuocMoi ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_TAO_HO.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_TAO_HO,
        ),
        count: countData.soLichTaoHo ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_HUY.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_HUY,
        ),
        count: countData.soLichHuyBo ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_THU_HOI.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_THU_HOI,
        ),
        count: countData.soLichThuHoi ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.CHO_DUYET.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.CHO_DUYET,
        ),
        count: 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_HOP_CAN_KLCH.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_HOP_CAN_KLCH,
        ),
        count: countData.soLichCanBaoCao ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_DA_KLCH.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_DA_KLCH,
        ),
        count: countData.tongSoLichCoBaoCao ?? 0,
      ),
    ];
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'quyen-duyet-phong',
    )){
      listMenuTheoTrangThai.add(
        ChildMenu(
        title: StatusWorkCalendar.LICH_DUYET_PHONG.getTitle(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_DUYET_PHONG,
        ),
        count: countData.tongSoLichDuyetPhong ?? 0,
      ),);
    }

    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'quyen-duyet-thiet-bi',
    )) {
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_DUYET_THIET_BI.getTitle(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_DUYET_THIET_BI,
          ),
          count: countData.tongSoLichDuyetThietBi ?? 0,
        ),);
    }
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'duyet-ky-thuat',
    )) {
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_DUYET_KY_THUAT.getTitle(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_DUYET_KY_THUAT,
          ),
          count: countData.tongSoLichDuyetKyThuat ?? 0,
        ),);
    }
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'yeu-cau-chuan-bi',
    )) {
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI.getTitle(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
          ),
          count: countData.tongSoLichCoYeuCau ?? 0,
        ),);
    }

    return listMenuTheoTrangThai;
  }

  /// Lấy số lượng các loại lịch
  Future<void> getCountDashboard() async {
    final result = await hopRepo.getDashBoardLichHop(
      startDate.formatApi,
      endDate.formatApi,
    );

    result.when(
      success: (value) {
        getMenuLichTheoTrangThai(value);
        _totalWorkSubject.sink.add(value);
      },
      error: (error) {},
    );
  }

  /// lấy danh sách ngày có sự kiện
  Future<void> getDaysHaveEvent({
    required DateTime startDate,
    required DateTime endDate,
    required String keySearch,
  }) async {
    final result = await hopRepo.postEventCalendar(
      EventCalendarRequest(
        Title: keySearch,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId:
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
        month: startDate.month,
        PageIndex: ApiConstants.PAGE_BEGIN,
        PageSize: 1000,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        year: startDate.year,
        isLichCuaToi: typeCalender == StatusWorkCalendar.LICH_CUA_TOI,
        isDuyetThietBi: typeCalender == StatusWorkCalendar.LICH_DUYET_THIET_BI,
        isChuaCoBaoCao:
        typeCalender == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO ||
            typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH,
        isDaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
        isLichDuocMoi: typeCalender == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichYeuCauChuanBi:
        typeCalender == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
        isDuyetPhong: typeCalender == StatusWorkCalendar.LICH_DUYET_PHONG,
        isLichThuHoi: typeCalender == StatusWorkCalendar.LICH_THU_HOI,
        isLichHuyBo: typeCalender == StatusWorkCalendar.LICH_HUY,
        isLichTaoHo: typeCalender == StatusWorkCalendar.LICH_TAO_HO,
        isDuyetLich: typeCalender == StatusWorkCalendar.CHO_DUYET,
        isLichThamGia: stateType == StateType.THAM_GIA,
        isLichTuChoi: stateType == StateType.TU_CHOI,
        isChoXacNhan:
        stateType != StateType.TU_CHOI && stateType != StateType.THAM_GIA,

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

  /// lấy danh sách lịch họp
  Future<void> getDanhSachLichHop({
    bool isRefresh = false,
    String? keySearch,
    bool isLichLanhDao = false,
  }) async {
    showLoading();
    final result = await hopRepo.postDanhSachLichHop(
      DanhSachLichHopRequest(
        Title: keySearch,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: isLichLanhDao
            ? idDonViLanhDao
            : HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
                '',
        IsLichLanhDao: isLichLanhDao,
        isLichCuaToi: typeCalender == StatusWorkCalendar.LICH_CUA_TOI,
        isDuyetThietBi: typeCalender == StatusWorkCalendar.LICH_DUYET_THIET_BI,
        isChuaCoBaoCao:
            typeCalender == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO ||
                typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH,
        isDaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
        isLichDuocMoi: typeCalender == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichYeuCauChuanBi:
            typeCalender == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
        isDuyetPhong: typeCalender == StatusWorkCalendar.LICH_DUYET_PHONG,
        isLichThuHoi: typeCalender == StatusWorkCalendar.LICH_THU_HOI,
        isLichHuyBo: typeCalender == StatusWorkCalendar.LICH_HUY,
        isLichTaoHo: typeCalender == StatusWorkCalendar.LICH_TAO_HO,
        isDuyetLich: typeCalender == StatusWorkCalendar.CHO_DUYET,
        isLichThamGia: stateType == StateType.THAM_GIA,
        isLichTuChoi: stateType == StateType.TU_CHOI,
        isChoXacNhan:
            stateType != StateType.TU_CHOI && stateType != StateType.THAM_GIA,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        PageIndex: 1,
        PageSize: 1000,
      ),
    );
    result.when(
      success: (value) {
        if (isRefresh) {}
        _listCalendarWorkDaySubject.sink.add(value.toDataFCalenderSource());
        _listCalendarWorkWeekSubject.sink.add(value.toDataFCalenderSource());
        _listCalendarWorkMonthSubject.sink.add(value.toDataFCalenderSource());
      },
      error: (error) {},
    );
    showContent();
  }

  DateTime getDate(String time) =>
      time.convertStringToDate(formatPattern: DateTimeFormat.DATE_TIME_RECEIVE);

  void checkDuplicate(List<ItemDanhSachLichHop> list) {
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

  void emitListViewState({CalendarType? type}) =>
      emit(ListViewState(typeView: type ?? state.typeView));

  void emitCalendarViewState({CalendarType? type}) =>
      emit(CalendarViewState(typeView: type ?? state.typeView));

  void emitChartViewState({CalendarType? type}) =>
      emit(ChartViewState(typeView: type ?? state.typeView));

  void handleDatePicked({
    required DateTime startDate,
    required DateTime endDate,
    required String keySearch,
  }) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.keySearch = keySearch;
    fCalendarControllerDay.selectedDate = this.startDate;
    fCalendarControllerDay.displayDate = this.startDate;
    fCalendarControllerWeek.selectedDate = this.startDate;
    fCalendarControllerWeek.displayDate = this.startDate;
    fCalendarControllerMonth.selectedDate = this.startDate;
    fCalendarControllerMonth.displayDate = this.startDate;
  }

  void handleMenuSelect({
    DataItemMenu? itemMenu,
    required BaseState state,
  }) {
    stateType = StateType.CHO_XAC_NHAN;
    if (state is ListViewState) {
      emitListViewState();
      if (typeCalender == StatusWorkCalendar.LICH_DUOC_MOI) {
        stateType = StateType.CHO_XAC_NHAN;
        // worksPagingController.refresh();
      }
    } else if (state is CalendarViewState) {
      emitCalendarViewState();
    } else {
      emitChartViewState();
    }
    if (itemMenu != null) {
      idDonViLanhDao = null;
      if (itemMenu is StatusDataItem) {
        _titleSubject.sink.add(itemMenu.value.getTitle());
        typeCalender = itemMenu.value;
        refreshData();
      }
      if (itemMenu is LeaderDataItem) {
        _titleSubject.sink.add(itemMenu.title);
        idDonViLanhDao = itemMenu.id;
        refreshData(isLichLanhDao: true);
      }
    }
  }
}
