import 'dart:async';
import 'dart:developer';

import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/views/show_loading_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWorkCubit extends BaseCubit<CalendarWorkState> {
  CalendarWorkCubit() : super(const CalendarViewState());

  LichLamViecRepository get calendarWorkRepo => Get.find();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String keySearch = '';
  String? idDonViLanhDao;

  bool isMyWork = true;

  StatusWorkCalendar? statusType;
  bool apiCalling = false;

  final CalendarController fCalendarController = CalendarController();

  BehaviorSubject<List<DateTime>> get listNgayCoLich => _listNgayCoLich;
  final controller = ChooseTimeController();

  final BehaviorSubject<DataLichLvModel> _listCalendarWorkSubject =
      BehaviorSubject();
  final BehaviorSubject<List<DateTime>> _listNgayCoLich =
      BehaviorSubject<List<DateTime>>();

  Stream<DataLichLvModel> get listCalendarWorkStream =>
      _listCalendarWorkSubject.stream;

  void setMenuChoose({
    String? idDonViLanhDao,
    StatusWorkCalendar? statusType,
    bool? isMyWork,
  }) {
    if (isMyWork != null) {
      this.isMyWork = isMyWork;
      this.idDonViLanhDao = null;
      this.statusType = null;
    }
    if (statusType != null) {
      this.isMyWork = false;
      this.idDonViLanhDao = null;
      this.statusType = statusType;
    }
    if (idDonViLanhDao != null) {
      this.isMyWork = false;
      this.idDonViLanhDao = idDonViLanhDao;
      this.statusType = null;
    }
  }

  Future<void> refreshApi() async {
    apiCalling = true;

    final Queue queue = Queue(parallel: 3);
    unawaited(queue.add(() => getMenuData()));
    unawaited(queue.add(() => getTotalWork()));
    unawaited(queue.add(() => getDashboardSchedule()));
    if (state is CalendarViewState) {
      unawaited(queue.add(() => getFullListWork()));
    }
    await queue.onComplete;

    apiCalling = false;
  }

  Future<void> callApiByMenu({
    String? idDonViLanhDao,
    StatusWorkCalendar? status,
    bool? isMyWork,
  }) async {
    setMenuChoose(
      idDonViLanhDao: idDonViLanhDao,
      statusType: status,
      isMyWork: isMyWork,
    );
    await refreshApi();
  }

  Future<void> callApiByNewFilter({
    required DateTime startDate,
    required DateTime endDate,
    required String keySearch,
  }) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.keySearch = keySearch;
    fCalendarController.selectedDate = this.startDate;
    await refreshApi();
  }

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
      success: (value) {},
      error: (error) {},
    );
  }

  Future<void> getTotalWork() async {
    final result = await calendarWorkRepo.getLichLv(
      startDate.formatApi,
      endDate.formatApi,
    );
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> dayHaveEvent(DateTime startDate,DateTime endDate,String keySearch) async {
    final result = await calendarWorkRepo.postEventCalendar(
      EventCalendarRequest(
        Title: keySearch,
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId:
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
        isLichCuaToi: isMyWork,
        month: startDate.month,
        PageIndex: ApiConstants.PAGE_BEGIN,
        PageSize: 1000,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        year: startDate.year,
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
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> getListWorkLoadMore({
    int pageIndex = ApiConstants.PAGE_BEGIN,
  }) async {
    final DanhSachLichLamViecRequest data = getDanhSachLichLVRequest(
      pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
      pageIndex: ApiConstants.PAGE_BEGIN,
    );
    final result = await calendarWorkRepo.getListLichLamViec(data);
    result.when(
      success: (res) {},
      error: (error) {},
    );
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
      success: (res) {},
      error: (error) {},
    );
  }

  DanhSachLichLamViecRequest getDanhSachLichLVRequest({
    required int pageIndex,
    required int pageSize,
  }) {
    return DanhSachLichLamViecRequest(
      DateFrom: startDate.formatApi,
      DateTo: endDate.formatApi,
      DonViId: idDonViLanhDao ??
          HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ??
          '',
      IsLichLanhDao: idDonViLanhDao != null ? true : null,
      isLichCuaToi: isMyWork != null ? true : null,
      isLichDuocMoi: statusType == StatusWorkCalendar.LICH_DUOC_MOI,
      isLichTaoHo: statusType == StatusWorkCalendar.LICH_TAO_HO,
      isLichHuyBo: statusType == StatusWorkCalendar.LICH_HUY,
      isLichThuHoi: statusType == StatusWorkCalendar.LICH_THU_HOI,
      isChuaCoBaoCao: statusType == StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
      isDaCoBaoCao: statusType == StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
      isChoXacNhan: false,
      isLichThamGia: false,
      isLichTuChoi: false,
      PageIndex: pageIndex,
      PageSize: pageSize,
      Title: keySearch,
      UserId: HiveLocal.getDataUser()?.userId ?? '',
    );
  }
}

extension ListenCalendarController on CalendarWorkCubit {
  void setFCalendarListener() {
    fCalendarController.addPropertyChangedListener((propertyChanged) {
      if (propertyChanged == 'displayDate') {
        final dateSelect = fCalendarController.displayDate ?? startDate;
        if (dateSelect.millisecondsSinceEpoch <
            controller.selectDate.value.millisecondsSinceEpoch) {
          controller.backTime();
        } else {
          controller.nextTime();
        }
      }
    });
  }
}

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<Appointment> source) {
    appointments = source;
  }
}

enum StatusWorkCalendar {
  LICH_DUOC_MOI,
  LICH_TAO_HO,
  LICH_HUY,
  LICH_THU_HOI,
  LICH_DA_CO_BAO_CAO,
  LICH_CHUA_CO_BAO_CAO,
}
