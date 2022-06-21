import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWorkCubit extends BaseCubit<CalendarWorkState> {
  CalendarWorkCubit() : super(const CalendarViewState());

  LichLamViecRepository get calendarWorkRepo => Get.find();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String keySearch = '';

  late final CalendarController calendarControllerDay = CalendarController();
  late final CalendarController calendarControllerWeek = CalendarController();
  late final CalendarController calendarControllerMonth = CalendarController();

  final BehaviorSubject<DataLichLvModel> _listCalendarWorkSubject =
      BehaviorSubject();

  Stream<DataLichLvModel> get listCalendarWorkStream =>
      _listCalendarWorkSubject.stream;

  void setDataSearch({
    DateTime? startDate,
    DateTime? endDate,
    String? keySearch,
  }) {
    if (startDate != null) this.startDate = startDate;
    if (endDate != null) this.endDate = endDate;
    if (keySearch != null) this.keySearch = keySearch;
  }

  Future<void> callApi({
    DateTime? startDate,
    DateTime? endDate,
    String? keySearch,
  }) async {
    setDataSearch(
      startDate: startDate,
      endDate: endDate,
      keySearch: keySearch,
    );
  }

  void emitList() => emit(ListViewState(typeView: state.typeView));

  void emitCalendar() => emit(CalendarViewState(typeView: state.typeView));
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

//   Future<void> dayHaveEvent(
//    // TypeCalendarMenu typeCalendar = TypeCalendarMenu.LichCuaToi,
//   ) async {
//     final result = await calendarWorkRepo.postEventCalendar(
//       EventCalendarRequest(
//         DateFrom: startDates.formatApi,
//         DateTo: endDates.formatApi,
//         DonViId:
//             HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
//         isLichCuaToi: typeCalendar == TypeCalendarMenu.LichCuaToi,
//         month: selectDay.month,
//         PageIndex: page,
//         PageSize: 10,
//         UserId: HiveLocal.getDataUser()?.userId ?? '',
//         year: selectDay.year,
//       ),
//     );
//     result.when(
//       success: (value) {
//       },
//       error: (error) {
//       },
//     );
//   }

Future<void> getDashboardSchedule({
  required String startDate,
  required String endDate,
  required int type,
}) async {
  // final LichLamViecRightRequest request = LichLamViecRightRequest(
  //   dateFrom: startDate,
  //   dateTo: endDate,
  //   type: type,
  // );
  // final result = await calendarWorkRepo.getLichLvRight(request);
  // result.when(
  //   success: (res) {
  //   },
  //   error: (err) {
  //
  //   },
  // );
}
//
// Future<void> getListWork() async {
//   final DanhSachLichLamViecRequest data = DanhSachLichLamViecRequest(
//     DateFrom: startDates.formatApi,
//     DateTo: endDates.formatApi,
//     DonViId: changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
//         ? idDonViLanhDao
//         : HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
//     IsLichLanhDao:
//         changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
//             ? true
//             : null,
//     isLichCuaToi: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichCuaToi),
//     isLichDuocMoi: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichDuocMoi),
//     isLichTaoHo: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichTaoHo),
//     isLichHuyBo:
//         changeItemMenuSubject.value.getListLichHop(TypeCalendarMenu.LichHuy),
//     isLichThuHoi: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichThuHoi),
//     isChuaCoBaoCao: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichHopCanKLCH),
//     isDaCoBaoCao: changeItemMenuSubject.value
//         .getListLichHop(TypeCalendarMenu.LichDaKLCH),
//     isChoXacNhan: getStateLDM.value.getListState(stateLDM.ChoXacNhan),
//     isLichThamGia: getStateLDM.value.getListState(stateLDM.ThamGia),
//     isLichTuChoi: getStateLDM.value.getListState(stateLDM.TuChoi),
//     PageIndex: page,
//     PageSize: modeLLV == Type_Choose_Option_List.DANG_LICH ? 1000 : 10,
//     UserId: HiveLocal.getDataUser()?.userId ?? '',
//   );
//   final result = await lichLamViec.getListLichLamViec(data);
//   result.when(
//     success: (res) {
//       totalPage = res.totalPage ?? 1;
//       dataLichLvModel = res;
//       listDSLV.addAll(dataLichLvModel.listLichLVModel ?? []);
//       dataLichLvModel.listLichLVModel = listDSLV;
//       listLichSubject.sink.add(dataLichLvModel);
//     },
//     error: (error) {
//       MessageConfig.show(
//         title: S.current.error,
//         title2: S.current.no_internet,
//         showTitle2: true,
//       );
//     },
//   );
// }
}

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<Appointment> source) {
    appointments = source;
  }
}
