import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_resquest.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class ChuDeCubit extends BaseCubit<ChuDeState> {
  ChuDeCubit() : super(ChuDeStateInitial());

  final BehaviorSubject<List<ChuDeModel>> _listYKienNguoiDan =
      BehaviorSubject<List<ChuDeModel>>();

  final BehaviorSubject<TuongTacThongKeResponseModel> _dataBaoCaoThongKe =
      BehaviorSubject<TuongTacThongKeResponseModel>();

  final BehaviorSubject<List<ListMenuItemModel>> _dataMenu =
      BehaviorSubject<List<ListMenuItemModel>>();

  final BehaviorSubject<DashBoardModel> _dataDashBoard =
      BehaviorSubject<DashBoardModel>();

  final BehaviorSubject<List<TinTucData>> _listDataSearch =
      BehaviorSubject<List<TinTucData>>();

  List<String> listTitle = [
    S.current.tin_tong_hop,
    S.current.cac_dia_phuong,
    S.current.uy_ban_nhan_dan_tinh,
    S.current.lanh_dao_tinh
  ];
  static const String HOM_NAY = 'hôm nay';
  static const String HOM_QUA = 'hôm qua';
  static const String BAY_NGAY_TRUOC = '7 ngày trước';
  static const String BA_MUOI_NGAY_TRUOC = '30 ngày trước';

  List<String> dropDownItem = [
    HOM_NAY,
    HOM_QUA,
    BAY_NGAY_TRUOC,
    BA_MUOI_NGAY_TRUOC,
  ];

  Stream<List<ChuDeModel>> get listYKienNguoiDan => _listYKienNguoiDan.stream;

  Stream<List<TinTucData>> get listDataSearch => _listDataSearch.stream;

  Stream<List<ListMenuItemModel>> get dataMenu => _dataMenu.stream;

  Stream<DashBoardModel> get streamDashBoard => _dataDashBoard.stream;

  Stream<TuongTacThongKeResponseModel> get dataBaoCaoThongKe =>
      _dataBaoCaoThongKe.stream;

  String startDate = DateTime.now().formatApiStartDay;
  String endDate = DateTime.now().formatApiEndDay;

  Future<void> callApi() async {
    final queue = Queue(parallel: 1);
    unawaited(
      queue.add(
        () => getDashboard(
          startDate,
          endDate,
        ),
      ),
    );
    await queue.add(
      () => getListTatCaCuDe(
        startDate,
        endDate,
      ),
    );
    await queue.add(
      () => getListBaoCaoThongKe(
        startDate,
        endDate,
      ),
    );
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  DashBoardTatCaChuDeRequest dashBoardTatCaChuDeRequest =
      DashBoardTatCaChuDeRequest(
    pageIndex: 1,
    pageSize: 30,
    total: 2220,
    hasNextPage: true,
    fromDate: DateTime.now().formatApiSS,
    toDate: DateTime.now().formatApiSS,
  );
  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();

  Future<void> getListTatCaCuDe(String startDate, String enDate) async {
    showLoading();
    final result = await _BCMXHRepo.getDashListChuDe(
      1,
      30,
      233,
      true,
      startDate,
      endDate,
    );
    showContent();
    result.when(
      success: (res) {
        final result = res.getlistChuDe ?? [];
        _listYKienNguoiDan.sink.add(result);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getListBaoCaoThongKe(String startDate, String enDate) async {
    showLoading();
    final result = await _BCMXHRepo.getTuongTacThongKe(
      1,
      30,
      49,
      true,
      startDate,
      enDate,
    );
    showContent();
    result.when(
      success: (res) {
        final result = res;
        _dataBaoCaoThongKe.sink.add(result);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getDashboard(String startDate, String enDate) async {
    showLoading();
    final result = await _BCMXHRepo.getDashBoardTatCaChuDe(
      1,
      30,
      13847,
      true,
      startDate,
      enDate,
    );
    showContent();
    result.when(
      success: (res) {
        _dataDashBoard.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> search(String startDate, String enDate, String keySearch) async {
    showLoading();
    final result = await _BCMXHRepo.searchTinTuc(
      1,
      20,
      startDate,
      enDate,
      keySearch,
    );
    result.when(
      success: (res) {
        _listDataSearch.sink.add(res.listData);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }

  void getOptionDate(String option) {
    switch (option) {
      case HOM_NAY:
        startDate = DateTime.now().formatApiStartDay;
        endDate = DateTime.now().formatApiEndDay;
        break;
      case HOM_QUA:
        getDateYesterDay();
        break;

      case BAY_NGAY_TRUOC:
        getDateWeek();
        break;

      case BA_MUOI_NGAY_TRUOC:
        getDateMonth();
        break;
      default:
        break;
    }
  }

  String getDateMonth() {
    int millisecondOfMounth = 30 * 24 * 60 * 60 * 1000;
    int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    int prevMonth = millisecondNow - millisecondOfMounth;
    endDate = DateTime.now().formatApiEndDay;
    startDate =
        DateTime.fromMillisecondsSinceEpoch(prevMonth).formatApiStartDay;
    String datePrevMounth =
        DateTime.fromMillisecondsSinceEpoch(prevMonth).formatApiStartDay;
    return datePrevMounth;
  }

  void getDateWeek() {
    int millisecondOfWeek = 7 * 24 * 60 * 60 * 1000;
    int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    int prevWeek = millisecondNow - millisecondOfWeek;
    endDate = DateTime.now().formatApiEndDay;
    startDate = DateTime.fromMillisecondsSinceEpoch(prevWeek).formatApiStartDay;
  }

  void getDateYesterDay() {
    int millisecondOfDay = 24 * 60 * 60 * 1000;
    int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    int prevDay = millisecondNow - millisecondOfDay;
    startDate = DateTime.fromMillisecondsSinceEpoch(prevDay).formatApiStartDay;
    endDate = DateTime.fromMillisecondsSinceEpoch(prevDay).formatApiEndDay;
  }
}
