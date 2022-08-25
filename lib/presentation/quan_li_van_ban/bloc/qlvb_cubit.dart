import 'dart:async';
import 'dart:core';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/document_in.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/document_out.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class QLVBCCubit extends BaseCubit<QLVBState> {
  QLVBCCubit() : super(QLVbStateInitial()) {
    // showContent();
  }

  BehaviorSubject<List<bool>> selectTypeVanBanSubject =
      BehaviorSubject.seeded([true, false]);
  final BehaviorSubject<DocumentDashboardModel> getVbDen = BehaviorSubject();

  final BehaviorSubject<DocumentDashboardModel> getVbDi = BehaviorSubject();

  final BehaviorSubject<ChartData> dataChartVBDen =
      BehaviorSubject<ChartData>();

  final BehaviorSubject<ChartData> dataChartVBDi = BehaviorSubject<ChartData>();

  final List<ChartData> chartDataVbDen = [];
  final List<ChartData> chartDataVbDi = [];
  List<String> maTrangThai = [];
  String documentInStatusCode = '';
  String documentInSubStatusCode = '';
  String documentOutStatusCode = '';

  bool vbDiLoading = false;
  bool vbDiLoadMore = true;
  List<VanBanModel> listVBDi = [];

  bool vbDenLoading = false;
  bool vbDenLoadMore = true;
  List<VanBanModel> listVBDen = [];

  Future<void> refreshDocumentList({bool showLoad = true}) async {
    if (showLoad) {
      showLoading();
    }
    await Future.wait([
      fetchIncomeDocumentCustom(initLoad: true, loadingCircle: false),
      fetchOutcomeDocumentCustom(initLoad: true, loadingCircle: false),
    ]);
    if (showLoad) {
      showContent();
    }
  }

  Stream<ChartData> get dataChatVbDen => dataChartVBDen.stream;

  Stream<ChartData> get dataChatVbDi => dataChartVBDi.stream;

  BehaviorSubject<List<VanBanModel>?> danhSachVBDi = BehaviorSubject();

  BehaviorSubject<List<VanBanModel>> danhSachVBDen = BehaviorSubject();

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

  ///End declare Report Statistical variable

  Future<void> callAPi({bool initTime = true}) async {
    final queue = Queue();
    showLoading();
    if (initTime) {
      initTimeRange();
    }
    unawaited(queue.add(() => getDashBoardIncomeDocument()));
    unawaited(queue.add(() => getDashBoardOutcomeDocument()));
    unawaited(
      queue.add(
        () => refreshDocumentList(showLoad: false),
      ),
    );
    await queue.onComplete;
    showContent();
  }

  final QLVBRepository qLVBRepo = Get.find();

  void initTimeRange() {
    final dataDateTime = DateTime.now();
    startDate =
        DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day - 30)
            .formatApi;
    endDate = dataDateTime.formatApi;
  }

  bool? getStatus(String status) {
    if (status.isEmpty) {
      return null;
    }
    return documentOutStatusCode == status;
  }
}
