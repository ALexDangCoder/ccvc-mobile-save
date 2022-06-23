import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
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

  final _listDataSearch = BehaviorSubject<List<TinTucData>?>();
  final List<ChuDeModel> listChuDeLoadMore = [];
  bool isFirstCall = true;
  ChuDeModel hotNewData = ChuDeModel();

  int page = 1;
  int pageSize = 10;
  int totalPage = 1;
  int totalItem = 1;

  List<String> listTitle = [
    S.current.tin_tong_hop,
    S.current.cac_dia_phuong,
    S.current.uy_ban_nhan_dan_tinh,
    S.current.lanh_dao_tinh
  ];
  static const String HOM_NAY = 'Hôm nay';
  static const String HOM_QUA = 'Hôm qua';
  static const String BAY_NGAY_TRUOC = '7 ngày trước';
  static const String BA_MUOI_NGAY_TRUOC = '30 ngày trước';

  List<String> dropDownItem = [
    HOM_NAY,
    HOM_QUA,
    BAY_NGAY_TRUOC,
    BA_MUOI_NGAY_TRUOC,
  ];

  Stream<List<ChuDeModel>> get listYKienNguoiDan => _listYKienNguoiDan.stream;

  Stream<List<TinTucData>?> get listDataSearch => _listDataSearch.stream;

  Stream<List<ListMenuItemModel>> get dataMenu => _dataMenu.stream;

  Stream<DashBoardModel> get streamDashBoard => _dataDashBoard.stream;

  Stream<TuongTacThongKeResponseModel> get dataBaoCaoThongKe =>
      _dataBaoCaoThongKe.stream;

  String startDate = DateTime.now().formatApiStartDay;
  String endDate = DateTime.now().formatApiEndDay;

  Future<void> callApi() async {
    showLoading();
    final queue = Queue(parallel: 3);
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
    await queue.onComplete.then((_) => showContent());
    queue.dispose();
  }

  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();

  Future<void> getListTatCaCuDe(
    String startDate,
    String enDate, {
    int pageIndex = ApiConstants.PAGE_BEGIN,
    bool isShow = false,
  }) async {
    if (isShow) showLoading();
    final result = await _BCMXHRepo.getDashListChuDe(
      pageIndex,
      5,
      0,
      true,
      startDate,
      endDate,
    );
    result.when(
      success: (res) {
        if (isShow) showContent();
        totalPage = res.totalPages ?? 1;
        totalItem = res.totalItems ?? 1;
        final result = res.getlistChuDe ?? [];
        if (isFirstCall) {
          hotNewData = result.removeAt(0);
          isFirstCall = false;
        }
        listChuDeLoadMore.addAll(result);
        _listYKienNguoiDan.sink.add(listChuDeLoadMore);
      },
      error: (err) {
        page = 1;
        showEmpty();
      },
    );
  }

  Future<void> getListBaoCaoThongKe(
    String startDate,
    String enDate, {
    bool isShow = false,
  }) async {
    if (isShow) showLoading();
    final result = await _BCMXHRepo.getTuongTacThongKe(
      1,
      30,
      49,
      true,
      startDate,
      enDate,
    );
    result.when(
      success: (res) {
        if (isShow) showContent();
        final result = res;
        _dataBaoCaoThongKe.sink.add(result);
      },
      error: (err) {
        showEmpty();
      },
    );
  }

  Future<void> getDashboard(
    String startDate,
    String enDate, {
    bool isShow = false,
  }) async {
    if (isShow) showLoading();
    final result = await _BCMXHRepo.getDashBoardTatCaChuDe(
      1,
      30,
      13847,
      true,
      startDate,
      enDate,
    );
    result.when(
      success: (res) {
        if (isShow) showContent();
        _dataDashBoard.sink.add(res);
      },
      error: (err) {
        showEmpty();
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
        showContent();
        _listDataSearch.sink.add(res.listData);
      },
      error: (err) {
        showEmpty();
      },
    );
  }

  void getOptionDate(String option) {
    switch (option) {
      case HOM_NAY:
        startDate = DateTime.now().formatApiStartDay;
        endDate = DateTime.now().formatApiEndDay;
        break;
      case HOM_QUA:
        getDateYesterday();
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
    const int millisecondOfMonth = 30 * 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevMonth = millisecondNow - millisecondOfMonth;
    endDate = DateTime.now().formatApiEndDay;
    startDate =
        DateTime.fromMillisecondsSinceEpoch(prevMonth).formatApiStartDay;
    final String datePrevMounth =
        DateTime.fromMillisecondsSinceEpoch(prevMonth).formatApiStartDay;
    return datePrevMounth;
  }

  void getDateWeek() {
    const int millisecondOfWeek = 7 * 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevWeek = millisecondNow - millisecondOfWeek;
    endDate = DateTime.now().formatApiEndDay;
    startDate = DateTime.fromMillisecondsSinceEpoch(prevWeek).formatApiStartDay;
  }

  void getDateYesterday() {
    const int millisecondOfDay = 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevDay = millisecondNow - millisecondOfDay;
    startDate = DateTime.fromMillisecondsSinceEpoch(prevDay).formatApiStartDay;
    endDate = DateTime.fromMillisecondsSinceEpoch(prevDay).formatApiEndDay;
  }

  void clear() {
    _listDataSearch.value?.clear();
  }

  void addNull() {
    _listDataSearch.sink.add(null);
  }
}
