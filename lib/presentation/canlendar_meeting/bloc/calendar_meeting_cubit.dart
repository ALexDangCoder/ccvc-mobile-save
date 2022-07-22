import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_thong_ke_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/thong_ke_linh_vuc.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/src/calendar/common/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class CalendarMeetingCubit extends BaseCubit<CalendarMeetingState> {
  CalendarMeetingCubit() : super( CalendarViewState()) {
    showContent();
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String keySearch = '';
  String? idDonViLanhDao;
  bool isLichLanhDao = false;
  StateType? stateType;
  StatusWorkCalendar? typeCalender = StatusWorkCalendar.LICH_CUA_TOI;

  HopRepository get hopRepo => Get.find();

  List<ChildMenu> listMenuTheoTrangThai = [];

  final BehaviorSubject<String> _titleSubject =
      BehaviorSubject.seeded(S.current.lich_cua_toi);

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

  final BehaviorSubject<List<StatisticByMonthModel>> _statisticSubject =
      BehaviorSubject();

  Stream<List<StatisticByMonthModel>> get statisticStream =>
      _statisticSubject.stream;

  final BehaviorSubject<List<ToChucBoiDonViModel>> _toChucBoiDonViSubject =
      BehaviorSubject();

  Stream<List<ToChucBoiDonViModel>> get toChucBoiDonViStream =>
      _toChucBoiDonViSubject.stream;

  final BehaviorSubject<List<ChartData>> _coCauLichHopSubject =
      BehaviorSubject();

  Stream<List<ChartData>> get coCauLichHopStream => _coCauLichHopSubject.stream;

  final BehaviorSubject<List<ThongKeLinhVucModel>> thongKeLinhVucSubject =
      BehaviorSubject();

  Stream<List<ThongKeLinhVucModel>> get thongKeLinhVucStream =>
      thongKeLinhVucSubject.stream;

  final BehaviorSubject<bool> _isShowStatusFilter =
      BehaviorSubject.seeded(false);

  Stream<bool> get isShowStatusStream => _isShowStatusFilter.stream;

  final BehaviorSubject<StatusWorkCalendar?> _statusWorkSubject =
      BehaviorSubject.seeded(StatusWorkCalendar.LICH_CUA_TOI);

  Stream<StatusWorkCalendar?> get statusWorkSubjectStream =>
      _statusWorkSubject.stream;

  final BehaviorSubject<List<DashBoardThongKeModel>>
      _listDashBoardThongKeSubject = BehaviorSubject();

  Stream<List<DashBoardThongKeModel>> get listDashBoardThongKeStream =>
      _listDashBoardThongKeSubject.stream;

  final BehaviorSubject<DanhSachLichHopModel> _danhSachLichHopSubject =
      BehaviorSubject();

  Stream<DanhSachLichHopModel> get danhSachLichHopStream =>
      _danhSachLichHopSubject.stream;

  void initData() {
    getCountDashboard();
    getMenuLichLanhDao();
    getDanhSachLichHop();
    getDashBoardThongKe();
  }

  void refreshDataDangLich() {
    getCountInDashboard();
    if (typeCalender != StatusWorkCalendar.LICH_HOP_CAN_KLCH) {
      getDanhSachLichHop();
    }
    getMenuLichLanhDao();
    getDaysHaveEvent(
      startDate: startDate,
      endDate: endDate,
    );
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
        title: StatusWorkCalendar.LICH_DUOC_MOI.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_DUOC_MOI,
        ),
        count: (countData.soLichChoXacNhan ?? 0) +
            (countData.soLichThamGia ?? 0) +
            (countData.soLichTuChoi ?? 0),
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_TAO_HO.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_TAO_HO,
        ),
        count: countData.soLichTaoHo ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_HUY.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_HUY,
        ),
        count: countData.soLichHuyBo ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_THU_HOI.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_THU_HOI,
        ),
        count: countData.soLichThuHoi ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.CHO_DUYET.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.CHO_DUYET,
        ),
        count: (countData.soLichCanChuTriDuyetCho ?? 0) +
            (countData.soLichChuTriDaDuyet ?? 0) +
            (countData.soLichChuTriTuChoi ?? 0),
      ),
    ];
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_DUYET_PHONG,
    )){
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_DUYET_PHONG.getTitleMeeting(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_DUYET_PHONG,
          ),
          count: (countData.soLichDuyetPhongCho ?? 0) +
              (countData.soLichDuyetPhongTuChoi ?? 0) +
              (countData.soLichDuyetPhongXacNhan ?? 0),
        ),
      );
    }

    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_DUYET_THIET_BI,
    )) {
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_DUYET_THIET_BI.getTitleMeeting(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_DUYET_THIET_BI,
          ),
          count: (countData.soLichDuyetThietBiXacNhan ?? 0) +
              (countData.soLichDuyetThietBiTuChoi ?? 0) +
              (countData.soLichDuyetThietBiCho ?? 0),
        ),);
    }
     if (HiveLocal.checkPermissionApp(
       permissionType: PermissionType.VPDT,
       permissionTxt: PermissionAppTxt.YEU_CAU_CHUAN_BI,
     )) {
       listMenuTheoTrangThai.add(
         ChildMenu(
           title: StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI.getTitleMeeting(),
           value: StatusDataItem(
             StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
           ),
           count: (countData.soLichDaThucHienYC ?? 0) +
               (countData.soLichChuaThucHienYC ?? 0),
         ),);
     }
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'duyet-ky-thuat',
    )) {
      listMenuTheoTrangThai.add(
        ChildMenu(
          title: StatusWorkCalendar.LICH_DUYET_KY_THUAT.getTitleMeeting(),
          value: StatusDataItem(
            StatusWorkCalendar.LICH_DUYET_KY_THUAT,
          ),
          count: (countData.soLichChoDuyetKyThuat ?? 0) +
              (countData.soLichDaDuyetKyThuat ?? 0) +
              (countData.soLichTuChoiDuyetKyThuat ?? 0),
        ),
      );
    }

    listMenuTheoTrangThai.addAll([
      ChildMenu(
        title: StatusWorkCalendar.LICH_HOP_CAN_KLCH.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_HOP_CAN_KLCH,
        ),
        count: countData.soLichCanBaoCao ?? 0,
      ),
      ChildMenu(
        title: StatusWorkCalendar.LICH_DA_KLCH.getTitleMeeting(),
        value: StatusDataItem(
          StatusWorkCalendar.LICH_DA_KLCH,
        ),
        count: (countData.soLichCoBaoCaoTuChoi ?? 0) +
            (countData.soLichCoBaoCaoDaDuyet ?? 0) +
            (countData.soLichCoBaoCaoChoDuyet ?? 0),
      ),
    ]);

    return listMenuTheoTrangThai;
  }

  DashBoardLichHopModel dashBoardModel  = DashBoardLichHopModel.empty();
  int countLichCanKLCH = 0;

  /// Lấy số lượng các loại lịch
  Future<void> getCountDashboard() async {
    if (typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH) {
      showLoading();
    }
    final result = await hopRepo.getDashBoardLichHop(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (value) {
        dashBoardModel = value;
      },
      error: (error) {},
    );
  }


  Future<void> getCountInDashboard() async {
    final queue = Queue(parallel: 2);
    unawaited(queue.add(() => getCountDashboard()));
    unawaited(queue.add(() => getDanhSachLichCanKLCH()));
    await queue.onComplete;
    dashBoardModel.soLichCanBaoCao = countLichCanKLCH;
    dashBoardModel.soLichChuaCoBaoCao = countLichCanKLCH;
    _totalWorkSubject.add(dashBoardModel);
    queue.dispose();
  }

  /// lấy data cho dashboard
  Future<void> getDashBoardThongKe() async {
    final result = await hopRepo.getDashBoardThongKe(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );
    result.when(
      success: (success) {
        _listDashBoardThongKeSubject.add(success);
      },
      error: (error) {},
    );
  }

  /// lấy danh sách ngày có sự kiện
  Future<void> getDaysHaveEvent({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if(state is ChartViewState){
      _listNgayCoLich.sink.add([]);
      return;
    }
    final result = await hopRepo.postEventCalendar(
      EventCalendarRequest(
        Title: keySearch,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: isLichLanhDao
            ? idDonViLanhDao
            : HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
            '',
        month: startDate.month,
        PageIndex: ApiConstants.PAGE_BEGIN,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        year: startDate.year,
        IsLichLanhDao: isLichLanhDao,
        isLichCuaToi: !isLichLanhDao
            ? typeCalender == StatusWorkCalendar.LICH_CUA_TOI
            : null,
        isDuyetThietBi: typeCalender == StatusWorkCalendar.LICH_DUYET_THIET_BI,
        isChuaCoBaoCao:
            typeCalender == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO ||
                typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH,
        isDaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_DA_CO_BAO_CAO ||
            typeCalender == StatusWorkCalendar.LICH_DA_KLCH,
        isLichDuocMoi: typeCalender == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichYeuCauChuanBi:
            typeCalender == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
        isDuyetPhong: typeCalender == StatusWorkCalendar.LICH_DUYET_PHONG,
        isLichThuHoi: typeCalender == StatusWorkCalendar.LICH_THU_HOI,
        isLichHuyBo: typeCalender == StatusWorkCalendar.LICH_HUY,
        isLichTaoHo: typeCalender == StatusWorkCalendar.LICH_TAO_HO,
        isDuyetLich: typeCalender == StatusWorkCalendar.CHO_DUYET,
        isLichThamGia:
            stateType == StateType.THAM_GIA || stateType == StateType.DA_DUYET,
        isLichTuChoi: stateType == StateType.TU_CHOI,
        isChoXacNhan: stateType == StateType.CHO_XAC_NHAN ||
            stateType == StateType.CHO_DUYET ||
            stateType == StateType.CHUA_THUC_HIEN,
        isChuaChuanBi: stateType == StateType.CHUA_THUC_HIEN,
        isDuyetKyThuat: typeCalender == StatusWorkCalendar.LICH_DUYET_KY_THUAT,
        isDaChuanBi: stateType == StateType.DA_THUC_HIEN,
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
        isDaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_DA_CO_BAO_CAO ||
            typeCalender == StatusWorkCalendar.LICH_DA_KLCH,
        isLichDuocMoi: typeCalender == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichYeuCauChuanBi:
            typeCalender == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
        isDuyetPhong: typeCalender == StatusWorkCalendar.LICH_DUYET_PHONG,
        isLichThuHoi: typeCalender == StatusWorkCalendar.LICH_THU_HOI,
        isLichHuyBo: typeCalender == StatusWorkCalendar.LICH_HUY,
        isLichTaoHo: typeCalender == StatusWorkCalendar.LICH_TAO_HO,
        isDuyetLich: typeCalender == StatusWorkCalendar.CHO_DUYET,
        isLichThamGia:
            stateType == StateType.THAM_GIA || stateType == StateType.DA_DUYET,
        isLichTuChoi: stateType == StateType.TU_CHOI,
        isChoXacNhan: stateType == StateType.CHO_XAC_NHAN ||
            stateType == StateType.CHO_DUYET ||
            stateType == StateType.CHUA_THUC_HIEN,
        isChuaChuanBi: stateType == StateType.CHUA_THUC_HIEN,
        isDuyetKyThuat: typeCalender == StatusWorkCalendar.LICH_DUYET_KY_THUAT,
        isDaChuanBi: stateType == StateType.DA_THUC_HIEN,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        PageIndex: ApiConstants.PAGE_BEGIN,
        trangThaiDuyetKyThuat:
            typeCalender == StatusWorkCalendar.LICH_DUYET_KY_THUAT
                ? stateType?.toInt()
                : null,
      ),
    );
    result.when(
      success: (value) {
        _listCalendarWorkDaySubject.sink.add(value.toDataFCalenderSource());
        _listCalendarWorkWeekSubject.sink.add(value.toDataFCalenderSource());
        _listCalendarWorkMonthSubject.sink.add(value.toDataFCalenderSource());
        checkDuplicate(value.items ?? []);
        _danhSachLichHopSubject.sink.add(value);
      },
      error: (error) {},
    );
    showContent();
  }

  /// lấy danh sách lịch họp cần KLCH
  Future<void> getDanhSachLichCanKLCH() async {
    final result = await hopRepo.getLichCanKLCH(
      DanhSachLichHopRequest(
        Title: keySearch,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id,
        isChuaCoBaoCao: true,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        PageIndex: ApiConstants.PAGE_BEGIN,
      ),
    );
    result.when(
      success: (value) {
        if (typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH) {
          _listCalendarWorkDaySubject.sink.add(value.toDataFCalenderSource());
          _listCalendarWorkWeekSubject.sink.add(value.toDataFCalenderSource());
          _listCalendarWorkMonthSubject.sink.add(value.toDataFCalenderSource());
          checkDuplicate(value.items ?? []);
          _danhSachLichHopSubject.sink.add(value);
        }
        countLichCanKLCH = value.items?.length ?? 0;
      },
      error: (error) {},
    );
    if (typeCalender == StatusWorkCalendar.LICH_HOP_CAN_KLCH) {
      showContent();
    }
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

  String oldTitle = S.current.lich_cua_toi;
  /// handle menu clicked
  void handleMenuSelect({
    DataItemMenu? itemMenu,
    required BaseState state,
  }) {
    stateType = StateType.CHO_DUYET;
    if (state is ListViewState) {
      emitListViewState();
      _titleSubject.sink.add(oldTitle);
    } else if (state is CalendarViewState)  {
      emitCalendarViewState();
      _titleSubject.sink.add(oldTitle);
    } else {
      emitChartViewState();
      getDataDangChart();
      isLichLanhDao = false;
      _titleSubject.sink.add(S.current.bao_cao_thong_ke);
    }

    if (itemMenu != null) {
      idDonViLanhDao = null;
      if(this.state is ChartViewState){
        emitCalendarViewState();
      }
      if (itemMenu is StatusDataItem) {
        isLichLanhDao = false;
        _titleSubject.sink.add(itemMenu.value.getTitleMeeting());
        typeCalender = itemMenu.value;
        _statusWorkSubject.sink.add(itemMenu.value);
        refreshDataDangLich();
      }
      if (itemMenu is LeaderDataItem) {
        isLichLanhDao = true;
        typeCalender = StatusWorkCalendar.LICH_LANH_DAO;
        _statusWorkSubject.sink.add(StatusWorkCalendar.LICH_LANH_DAO);
        _titleSubject.sink.add(itemMenu.title);
        idDonViLanhDao = itemMenu.id;
        refreshDataDangLich();
      }
    }else{
      if(state is! ChartViewState){
        refreshDataDangLich();
      }
    }
    if(state is! ChartViewState){
      oldTitle = _titleSubject.valueOrNull ?? S.current.lich_cua_toi;
    }

  }

  /// Handle chartview
  void getDataDangChart() {
    getStatisticByMonth();
    getDashBoardThongKe();
    getToChucBoiDonVi();
    getThongKeTheoLinhVuc();
    getCoCauLichHop();
    getDaysHaveEvent(
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// lấy số lịch họp trong thời gian
  Future<void> getStatisticByMonth({bool needShowLoading = false}) async {
    showLoading();
    final result = await hopRepo.postStatisticByMonth(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );
    result.when(
      success: (success) {
        _statisticSubject.add(success);
      },
      error: (error) {},
    );
    showContent();
  }

  /// lấy số lịch họp theo đon vị
  Future<void> getToChucBoiDonVi() async {
    final result = await hopRepo.postToChucBoiDonVi(
      startDate.formatApiDDMMYYYYSlash,
      endDate.formatApiDDMMYYYYSlash,
    );
    result.when(
      success: (value) {
        _toChucBoiDonViSubject.add(value);
      },
      error: (error) {},
    );
  }

  /// lấy số lịch họp theo lĩnh vực
  Future<void> getThongKeTheoLinhVuc() async {
    final result = await hopRepo.getLichHopTheoLinhVuc(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (value) {
        thongKeLinhVucSubject.add(value);
      },
      error: (error) {},
    );
  }

  /// get cơ cấu lịch họp
  String idThongKe = '';
  Future<void> getCoCauLichHop() async {
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
              id: i.id ?? '',
            ),
          );
        }
        _coCauLichHopSubject.add(dataCoCauLichHop);
      },
      error: (error) {},
    );
  }

  /// lấy danh sách lịch họp theo cơ cấu lịch họp:
  Future<void> getDanhSachThongKe() async {
    showLoading();
    final result = await hopRepo.postDanhSachThongKe(
      DanhSachThongKeRequest(
        dateFrom: startDate.formatApiDDMMYYYYSlash,
        dateTo: endDate.formatApiDDMMYYYYSlash,
        pageIndex: ApiConstants.PAGE_BEGIN,
        pageSize: 1000,
        typeCalendarId: idThongKe,
      ),
    );
    result.when(
      success: (value) {
        checkDuplicate(value.items ?? []);
        _danhSachLichHopSubject.sink.add(value);      },
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

  bool checkDataRateList(List<TiLeThamGiaModel> data) {
    for (var i in data) {
      if (i.rate != 0) return true;
    }
    return false;
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

  DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  void propertyChanged({
    required String property,
    required Type_Choose_Option_Day typeChoose,
  }) {
    if (property == 'displayDate') {
      if (typeChoose == Type_Choose_Option_Day.DAY) {
        changeCalendarDate(
          startDate,
          fCalendarControllerDay.displayDate ?? startDate,
        );
      } else if (typeChoose == Type_Choose_Option_Day.WEEK) {
        changeCalendarDate(
          startDate,
          fCalendarControllerWeek.displayDate ?? startDate,
        );
      } else {
        changeCalendarDate(
          startDate,
          fCalendarControllerMonth.displayDate ?? startDate,
        );
      }
    }
  }

  void handleChartPicked({required String id, required String title}) {
    emitListViewState(type: state.typeView);
    idThongKe = id;
    _titleSubject.add(title);
    getDanhSachThongKe();
  }
}
