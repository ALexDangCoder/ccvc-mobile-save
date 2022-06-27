import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
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

  StatusWorkCalendar typeCalender = StatusWorkCalendar.LICH_CUA_TOI;

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

  final BehaviorSubject<DashBoardLichHopModel> _totalWorkSubject = BehaviorSubject();

  Stream<DashBoardLichHopModel> get totalWorkStream => _totalWorkSubject.stream;


  void initData() {
    getCountDashboard();
    getMenuLichLanhDao();
  }

  /// Lấy danh sách menu:
  Future<void> getMenuLichLanhDao() async {
    showLoading();
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
    showContent();
  }

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

  Future<void> postEventsCalendar({
    required String keySearch,
  }) async {
    showLoading();
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
        isDuyetKyThuat: typeCalender == StatusWorkCalendar.LICH_DUYET_KY_THUAT,
        isChoXacNhan: typeCalender == StatusWorkCalendar.CHO_DUYET,
        isDuyetThietBi: typeCalender == StatusWorkCalendar.LICH_DUYET_THIET_BI,
        isChuaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
        isDaCoBaoCao: typeCalender == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
        isLichDuocMoi: typeCalender == StatusWorkCalendar.LICH_DUOC_MOI,
        isLichYeuCauChuanBi:
            typeCalender == StatusWorkCalendar.LICH_YEU_CAU_CHUAN_BI,
        isDuyetPhong: typeCalender == StatusWorkCalendar.LICH_DUYET_PHONG,
        isLichThuHoi: typeCalender == StatusWorkCalendar.LICH_THU_HOI,
        isLichHuyBo: typeCalender == StatusWorkCalendar.LICH_HUY,
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
}
