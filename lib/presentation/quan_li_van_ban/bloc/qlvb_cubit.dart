import 'dart:core';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class QLVBCCubit extends BaseCubit<QLVBState> {
  QLVBCCubit() : super(QLVbStateInitial()) {
    showContent();
  }

  BehaviorSubject<List<bool>> selectTypeVanBanSubject =
      BehaviorSubject.seeded([true, false]);
  final BehaviorSubject<DocumentDashboardModel> _getVbDen =
      BehaviorSubject<DocumentDashboardModel>();

  final BehaviorSubject<DocumentDashboardModel> _getVbDi =
      BehaviorSubject<DocumentDashboardModel>();

  final BehaviorSubject<List<VanBanModel>> _getDanhSachVBDi =
      BehaviorSubject<List<VanBanModel>>();

  final BehaviorSubject<List<VanBanModel>> _getDanhSachVBDen =
      BehaviorSubject<List<VanBanModel>>();

  Stream<List<VanBanModel>> get getDanhSachVbDi => _getDanhSachVBDi.stream;

  Stream<List<VanBanModel>> get getDanhSachVbDen => _getDanhSachVBDen.stream;

  final BehaviorSubject<ChartData> _dataChartVBDen =
      BehaviorSubject<ChartData>();

  final BehaviorSubject<ChartData> _dataChartVBDi =
      BehaviorSubject<ChartData>();
  final List<ChartData> chartDataVbDen = [];
  final List<ChartData> chartDataVbDi = [];
  List<String> maTrangThai = [];
  String documentInStatusCode = '';
  String documentInSubStatusCode = '';
  String documentOutStatusCode = '';

  int index = 1;
  int size = 10;

  Stream<DocumentDashboardModel> get getVbDen => _getVbDen.stream;

  Stream<DocumentDashboardModel> get getVbDi => _getVbDi.stream;

  Stream<ChartData> get dataChatVbDen => _dataChartVBDen.stream;

  Stream<ChartData> get dataChatVbDi => _dataChartVBDi.stream;
  late String startDate;
  late String endDate;

  void callAPi() {
    showLoading();
    initTimeRange();
    dataVBDen();
    dataVBDi();
    listDataDanhSachVBDen(initCall: true);
    listDataDanhSachVBDi();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  Future<void> dataVBDi({
    String? startDate,
    String? endDate,
  }) async {
    final result = await _qLVBRepo.getVBDi(
        startDate ?? this.startDate, endDate ?? this.endDate);
    result.when(
      success: (res) {
        chartDataVbDi.clear();
        final dataVbDi = DocumentDashboardModel(
          soLuongChoTrinhKy: res.soLuongChoTrinhKy,
          soLuongChoXuLy: res.soLuongChoXuLy,
          soLuongDaXuLy: res.soLuongDaXuLy,
          soLuongThuongKhan: res.soLuongThuongKhan,
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_trinh_ky,
            dataVbDi.soLuongChoTrinhKy?.toDouble() ?? 0,
            choTrinhKyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDi.soLuongChoXuLy?.toDouble() ?? 0,
            choXuLyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDi.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        _getVbDi.sink.add(dataVbDi);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dataVBDen({
    String? startDate,
    String? endDate,
  }) async {
    final result = await _qLVBRepo.getVBDen(
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
    result.when(
      success: (res) {
        chartDataVbDen.clear();
        final DocumentDashboardModel dataVbDen = res;
        chartDataVbDen.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDen.soLuongChoXuLy?.toDouble() ?? 0,
            choXuLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.dang_xu_ly,
            dataVbDen.soLuongDangXuLy?.toDouble() ?? 0,
            dangXyLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDen.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.cho_vao_so,
            dataVbDen.soLuongChoVaoSo?.toDouble() ?? 0,
            choVaoSoColor,
          ),
        );
        _getVbDen.sink.add(dataVbDen);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> listDataDanhSachVBDi({
    String? startDate,
    String? endDate,
    bool initCall = false,
  }) async {
    List<VanBanModel> listVbDi = [];
    if (!initCall) {
      showLoading();
    }
    final result = await _qLVBRepo.getDanhSachVbDi(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      index: index,
      size: size,
      isDanhSachChoTrinhKy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == 'CHO_TRINH_KY',
      isDanhSachChoXuLy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == 'CHO_XU_LY',
      isDanhSachDaXuLy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == 'DA_XU_LY',
      trangThaiFilter: statusSearchDocumentOutCode(documentOutStatusCode)
    );
    result.when(
      success: (res) {
        listVbDi = res.pageData ?? [];
        _getDanhSachVBDi.sink.add(listVbDi);
        if (!initCall) {
          showContent();
        }
      },
      error: (err) {
        if (!initCall) {
          showError();
        }
        return err;
      },
    );
  }

  Future<void> listDataDanhSachVBDen({
    String? startDate,
    String? endDate,
    bool initCall = false,
  }) async {
    if (!initCall) {
      showLoading();
    }
    List<VanBanModel> listVbDen = [];
    final result = await _qLVBRepo.getDanhSachVbDen(
      DanhSachVBRequest(
        maTrangThai: statusSearchDocumentInCode(documentInStatusCode),
        index: 1,
        isSortByDoKhan: true,
        thoiGianStartFilter: startDate ?? this.startDate,
        thoiGianEndFilter: endDate ?? this.endDate,
        size: 10,
      ),
    );
    result.when(
      success: (res) {
        listVbDen = res.pageData ?? [];
        _getDanhSachVBDen.sink.add(listVbDen);
        if (!initCall) {
          showContent();
        }
      },
      error: (error) {
        if (!initCall) {
          showError();
        }
        return error;
      },
    );
  }

  Future<void> searchDataDanhSachVBDi({
    required String startDate,
    required String endDate,
    String? keySearch,
  }) async {
    List<VanBanModel> listVbDi = [];
    final result = await _qLVBRepo.getDanhSachVbDi(
      startDate: startDate,
      endDate: endDate,
      index: index,
      size: size,
      keySearch: keySearch ?? '',
    );
    result.when(
      success: (res) {
        listVbDi = res.pageData ?? [];
        _getDanhSachVBDi.sink.add(listVbDi);
      },
      error: (err) {
        return err;
      },
    );
  }

  Future<void> searchDataDanhSachVBDen({
    required String startDate,
    required String endDate,
    String? keySearch,
  }) async {
    List<VanBanModel> listVbDen = [];
    final result = await _qLVBRepo.getDanhSachVbDen(
      DanhSachVBRequest(
        maTrangThai: maTrangThai,
        index: 1,
        isSortByDoKhan: true,
        thoiGianStartFilter: startDate,
        thoiGianEndFilter: endDate,
        size: 10,
        keySearch: keySearch ?? '',
      ),
    );
    result.when(
      success: (res) {
        listVbDen = res.pageData ?? [];
        _getDanhSachVBDen.sink.add(listVbDen);
      },
      error: (error) {
        showError();
      },
    );
  }

  void initTimeRange() {
    final dataDateTime =
        DateTime.now().dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    startDate = dataDateTime.first.formatApi;
    endDate = dataDateTime.last.formatApi;
  }
}
