import 'dart:async';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/bao_cao_thong_ke/bao_cao_thong_ke_qlvb_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_request.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tinh_trang_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tong_so_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:queue/queue.dart';

const String CURRENT_YEAR_DATA = 'current_year_data';
const String LAST_YEAR_DATA = 'last_year_data';

extension ReportStatistical on QLVBCCubit {
  Future<void> getAllDataReportStatistical() async {
    final queue = Queue();
    showLoading();
    generateListTime();
    unawaited(queue.add(() => selectDateTime()));
    unawaited(queue.add(() => buildLineChart()));
    await queue.onComplete;
    showContent();
  }

  Future<void> selectDateTime() async {
    if (selectedMonth == null) {
      await getVanBanCacDonViSoanThao();
      await getVanBanDonVi(
        VanBanDonViRequest('$selectedYear-01-01', '$selectedYear-12-31'),
      );
      await getReportStatisticalData();
    } else {
      final int lastDay =
          DateTime(selectedYear, (selectedMonth ?? 1) + 1, 0).day;
      await getVanBanCacDonViSoanThao();
      await getVanBanDonVi(
        VanBanDonViRequest(
          '$selectedYear-${selectedMonth ?? 1}-01',
          '$selectedYear-${selectedMonth ?? 1}-$lastDay',
        ),
      );
      await getReportStatisticalData();
    }
  }

  Future<void> buildLineChart() async {
    final queue = Queue();
    final Map<String, List<TinhTrangXuLyModel>> dataMap = {};
    unawaited(queue.add(() => getLineChartData()));
    unawaited(queue.add(() => getLineChartData(getLastYearData: true)));
    await queue.onComplete;
    dataMap.putIfAbsent(CURRENT_YEAR_DATA, () => currentYearData);
    dataMap.putIfAbsent(LAST_YEAR_DATA, () => lastYearData);
    lineChartDataInStream.sink.add(dataMap);
  }

  Future<void> getVanBanDonVi(VanBanDonViRequest request) async {
    final result = await qLVBRepo.getDataVanBanDonVi(request);
    result.when(
      success: (res) {
        final data = convertData(res ?? []);
        rowChartDataInStream.sink.add(data);
      },
      error: (err) {},
    );
  }

  Future<List<TongSoVanBanModel>> getTotalIncomeDocument(
      BaoCaoThongKeQLVBRequest request) async {
    List<TongSoVanBanModel> data = [];
    final result = await qLVBRepo.getTongSoBanBan(request);
    result.when(
      success: (res) {
        data = res;
      },
      error: (err) {},
    );
    return data;
  }

  Future<void> getLineChartData({bool getLastYearData = false}) async {
    final BaoCaoThongKeQLVBRequest request = BaoCaoThongKeQLVBRequest(
      '${DateTime.now().year - (getLastYearData ? 1 : 0)}-01-01',
      '${DateTime.now().year - (getLastYearData ? 1 : 0)}-12-31',
      [],
    );
    final result = await qLVBRepo.getLineChartData(request);
    result.when(
      success: (res) {
        if (getLastYearData) {
          lastYearData = res;
        } else {
          currentYearData = res;
        }
      },
      error: (err) {
        if (getLastYearData) {
          lastYearData = [];
        } else {
          currentYearData = [];
        }
      },
    );
  }

  Future<void> getVanBanCacDonViSoanThao() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final List<ChartData> listDataPieChart = [
      ChartData(
        S.current.cho_xu_ly,
        20,
        textColorBlog,
      ),
      ChartData(
        S.current.da_ban_hanh,
        30,
        color20C997,
      ),
      ChartData(
        S.current.cho_ban_hanh,
        50,
        colorFF9F43,
      ),
    ];
    final List<RowChartData> listRowChartData = [
      RowChartData(
        title: 'Vụ vật liệu xây dựng',
        listData: [
          SubRowChartData(
            color: bgrChart,
            value: 220,
            title: '',
          ),
        ],
      ),
      RowChartData(
        title: 'Cục kinh tế xây dựng',
        listData: [
          SubRowChartData(
            color: bgrChart,
            value: 223,
            title: '',
          ),
        ],
      ),
      RowChartData(
        title: 'Vụ Quy hoạch - Kiến trúc',
        listData: [
          SubRowChartData(
            color: bgrChart,
            value: 8492,
            title: '',
          ),
        ],
      ),
      RowChartData(
        title: 'Vụ Kế hoạch - Tài chính',
        listData: [
          SubRowChartData(
            color: bgrChart,
            value: 499,
            title: '',
          ),
        ],
      ),
    ];
    pieChartDataOutStream.sink.add(listDataPieChart);
    rowChartDataOutStream.sink.add(listRowChartData);
  }

  Future<void> dropDownSelect(int index, {bool selectYear = true}) async {
    showLoading();
    if (selectYear) {
      selectedYear = int.parse(yearList[index]);
      selectedMonth = null;
      listenableMonthValue.value = !listenableMonthValue.value;
      await selectDateTime();
    } else {
      selectedMonth = index + 1;
      await selectDateTime();
    }
    showContent();
  }

  void generateListTime() {
    yearList = List.generate(
      20,
      (index) => (DateTime.now().year - 10 + index).toString(),
    ).toList();
    monthList = [
      S.current.january,
      S.current.february,
      S.current.march,
      S.current.april,
      S.current.may,
      S.current.june,
      S.current.july,
      S.current.august,
      S.current.september,
      S.current.october,
      S.current.november,
      S.current.december,
    ];
  }

  Future<void> getReportStatisticalData() async {
    List<TongSoVanBanModel> currentData = [];
    List<TongSoVanBanModel> oldData = [];

    if (selectedMonth == null) {
      currentData = await getTotalIncomeDocument(
        createRequest(
          month: null,
          year: selectedYear,
        ),
      );
      oldData = await getTotalIncomeDocument(
        createRequest(
          month: null,
          year: selectedYear - 1,
        ),
      );
    } else {
      currentData = await getTotalIncomeDocument(
        createRequest(
          month: selectedMonth,
          year: selectedYear,
        ),
      );
      late BaoCaoThongKeQLVBRequest request;
      if (selectedMonth == 1) {
        request = createRequest(
          month: (selectedMonth ?? 2) - 1,
          year: selectedYear,
        );
      } else {
        request = createRequest(
          month: 12,
          year: selectedYear - 1,
        );
      }
      oldData = await getTotalIncomeDocument(request);
    }

    final List<InfoItemModel> listInfoItem = [];


    infoItemInStream.sink.add(listInfoItem);
    infoItemOutStream.sink.add(listInfoItem);
  }

  List<RowChartData> convertData(List<VanBanDonViModel> list) {
    int outDateSum = 0;
    int inDueDateSum = 0;
    final List<RowChartData> listData = [];
    for (final e in list) {
      listData.add(
        RowChartData(
          title: e.label,
          listData: [
            SubRowChartData(
              title: S.current.den_han,
              value: e.dataXuLy.denHan + e.dataXuLy.trongHan,
              color: color20C997,
            ),
            SubRowChartData(
              title: S.current.qua_han,
              value: e.dataXuLy.quaHan,
              color: colorFF4F50,
            ),
          ],
        ),
      );
      inDueDateSum += e.dataXuLy.denHan + e.dataXuLy.trongHan;
      outDateSum += e.dataXuLy.quaHan;
    }
    pieChartDataInStream.sink.add([
      ChartData(S.current.qua_han, outDateSum.toDouble(), colorFF4F50),
      ChartData(S.current.den_han, inDueDateSum.toDouble(), color20C997)
    ]);
    return listData;
  }

  BaoCaoThongKeQLVBRequest createRequest({
    required int? month,
    required int year,
  }) {
    if (month == null) {
      return BaoCaoThongKeQLVBRequest(
        '$year-01-01',
        '$year-12-31',
        [],
      );
    } else {
      final int lastDay = DateTime(year, month + 1, 0).day;
      return BaoCaoThongKeQLVBRequest(
        '$year-$month-01',
        '$year-$month-$lastDay',
        [],
      );
    }
  }
}

class InfoItemModel {
  String name;
  int quantity;
  int lastYearQuantity;
  Color color;

  InfoItemModel({
    required this.name,
    required this.quantity,
    required this.lastYearQuantity,
    required this.color,
  });
}

class DocumentByDivisionModel {
  String name;
  int inDueDateQuantity;
  int outDateQuantity;

  DocumentByDivisionModel({
    required this.name,
    required this.inDueDateQuantity,
    required this.outDateQuantity,
  });
}

extension GetList on Map<String, dynamic> {
  List<TinhTrangXuLyModel> getListValue(String key) {
    List<TinhTrangXuLyModel> vl = [];
    try {
      vl = this[key];
    } catch (_) {}
    return vl;
  }
}
