import 'dart:async';
import 'dart:core';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tinh_trang_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class QLVBCCubit extends BaseCubit<QLVBState> {
  QLVBCCubit() : super(QLVbStateInitial()) {
    // showContent();
  }

  BehaviorSubject<List<bool>> selectTypeVanBanSubject =
      BehaviorSubject.seeded([true, false]);
  final BehaviorSubject<DocumentDashboardModel> _getVbDen =
      BehaviorSubject<DocumentDashboardModel>();

  final BehaviorSubject<DocumentDashboardModel> _getVbDi =
      BehaviorSubject<DocumentDashboardModel>();

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
  String keySearch = '';

  final BehaviorSubject<bool> showSearchSubject =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get showSearchStream => showSearchSubject.stream;

  void setSelectSearch() {
    showSearchSubject.sink.add(!showSearchSubject.value);
  }

  ///Report Statistical variable
  List<String> monthList = [];
  List<String> yearList = [];
  int selectedYear = DateTime.now().year;
  int? selectedMonth;
  List<TinhTrangXuLyModel> currentYearData = [];
  List<TinhTrangXuLyModel> lastYearData = [];

  final ValueNotifier<bool> listenableMonthValue = ValueNotifier(false);

  final BehaviorSubject<List<InfoItemModel>> infoItemInStream =
      BehaviorSubject();
  final BehaviorSubject<List<InfoItemModel>> infoItemOutStream =
      BehaviorSubject();
  final BehaviorSubject<List<RowChartData>> rowChartDataInStream =
      BehaviorSubject();
  final BehaviorSubject<List<RowChartData>> rowChartDataOutStream =
      BehaviorSubject();
  final BehaviorSubject<List<ChartData>> pieChartDataInStream =
      BehaviorSubject();
  final BehaviorSubject<List<ChartData>> pieChartDataOutStream =
      BehaviorSubject();
  final BehaviorSubject<Map<String, List<TinhTrangXuLyModel>>>
      lineChartDataInStream = BehaviorSubject();
  final BehaviorSubject<List<TinhTrangXuLyModel>> lineChartDataOutStream =
      BehaviorSubject();

  ///End declare Report Statistical variable

  Future<void> callAPi({bool initTime = true}) async {
    final queue = Queue();
    showLoading();
    // ignore: unnecessary_statements
    initTime ? initTimeRange() : null;
    unawaited(queue.add(() => getDashBoardIncomeDocument()));
    unawaited(queue.add(() => getDashBoardOutcomeDocument()));
    await queue.onComplete;
    showContent();
  }

  final QLVBRepository qLVBRepo = Get.find();

  Future<void> getDashBoardOutcomeDocument({
    String? startDate,
    String? endDate,
  }) async {
    final result = await qLVBRepo.getVBDi(
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
            color5A8DEE,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDi.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_cap_so,
            dataVbDi.soLuongChoCapSo?.toDouble() ?? 0,
            choCapSoColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_ban_hanh,
            dataVbDi.soLuongChoBanHanh?.toDouble() ?? 0,
            choBanHanhColor,
          ),
        );
        _getVbDi.sink.add(dataVbDi);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getDashBoardIncomeDocument({
    String? startDate,
    String? endDate,
  }) async {
    final result = await qLVBRepo.getVBDen(
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
            color5A8DEE,
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

  Future<List<VanBanModel>> getListIncomeDocumentTest({
    String? startDate,
    String? endDate,
    int? page,
  }) async {
    List<VanBanModel> listVbDen = [];
    final result = await qLVBRepo.getDanhSachVbDen(
      DanhSachVBRequest(
        maTrangThai: statusSearchDocumentInCode(documentInStatusCode),
        index: page ?? ApiConstants.PAGE_BEGIN,
        isSortByDoKhan: true,
        thoiGianStartFilter: startDate ?? this.startDate,
        thoiGianEndFilter: endDate ?? this.endDate,
        size: ApiConstants.DEFAULT_PAGE_SIZE,
        keySearch: keySearch,
        trangThaiXuLy: statusSearchDocumentInSubCode(documentInSubStatusCode),
        isDanhSachDaXuLy: documentInSubStatusCode.isNotEmpty ? false : null,
      ),
    );
    result.when(
      success: (res) {
        listVbDen = res.pageData ?? [];
      },
      error: (error) {
        return error;
      },
    );
    return listVbDen;
  }

  Future<void> fetchIncomeDocument({
    required int pageKey,
    required PagingController<int, VanBanModel> documentPagingController,
  }) async {
    try {
      final currentPage = pageKey ~/ ApiConstants.DEFAULT_PAGE_SIZE;
      final newItems = await getListIncomeDocumentTest(
        page: currentPage + 1,
      );
      final isLastPage = newItems.length < ApiConstants.DEFAULT_PAGE_SIZE;
      if (isLastPage) {
        documentPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        documentPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      documentPagingController.error = error;
    }
  }

  Future<List<VanBanModel>> getListOutcomeDocumentTest({
    String? startDate,
    String? endDate,
    int? page,
  }) async {
    List<VanBanModel> listVbDi = [];
    final result = await qLVBRepo.getDanhSachVbDi(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      index: page ?? ApiConstants.PAGE_BEGIN,
      size: ApiConstants.DEFAULT_PAGE_SIZE,
      isDanhSachChoTrinhKy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == DocumentState.CHO_TRINH_KY,
      isDanhSachChoXuLy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == DocumentState.CHO_XU_LY,
      isDanhSachDaXuLy: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == DocumentState.DA_XU_LY,
      isDanhSachChoBanHanh: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == DocumentState.CHO_BAN_HANH,
      isDanhSachChoCapSo: documentOutStatusCode == ''
          ? null
          : documentOutStatusCode == DocumentState.CHO_CAP_SO,
      trangThaiFilter: statusSearchDocumentOutCode(documentOutStatusCode),
      keySearch: keySearch,
    );
    result.when(
      success: (res) {
        listVbDi = res.pageData ?? [];
      },
      error: (err) {
        return err;
      },
    );
    return listVbDi;
  }

  Future<void> fetchOutcomeDocument({
    required int pageKey,
    required PagingController<int, VanBanModel> documentPagingController,
  }) async {
    try {
      final currentPage = pageKey ~/ ApiConstants.DEFAULT_PAGE_SIZE;
      final newItems = await getListOutcomeDocumentTest(
        page: currentPage + 1,
      );
      final isLastPage = newItems.length < ApiConstants.DEFAULT_PAGE_SIZE;
      if (isLastPage) {
        documentPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        documentPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      documentPagingController.error = error;
    }
  }

  void initTimeRange() {
    final dataDateTime = DateTime.now();
    startDate =
        DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day - 30)
            .formatApi;
    endDate = dataDateTime.formatApi;
  }
}
