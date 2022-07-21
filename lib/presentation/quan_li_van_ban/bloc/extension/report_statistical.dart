import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_request.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

extension ReportStatistical on QLVBCCubit {
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

  void selectDateTime() {
    if (selectedMonth == null) {
      getVanBanDonVi(
          VanBanDonViRequest('$selectedYear-01-01', '$selectedYear-12-31'));
    } else {
      final int lastDay =
          DateTime(selectedYear, (selectedMonth ?? 1) + 1, 0).day;
      getVanBanDonVi(
        VanBanDonViRequest(
          '$selectedYear-${selectedMonth ?? 1}-01',
          '$selectedYear-${selectedMonth ?? 1}-$lastDay',
        ),
      );
    }
  }

  void dropDownSelect(int index, {bool selectYear = true}) {
    if (selectYear) {
      selectedYear = int.parse(yearList[index]);
      selectedMonth = null;
      listenableMonthValue.value = !listenableMonthValue.value;
      selectDateTime();
    } else {
      selectedMonth = index + 1;
      selectDateTime();
    }
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

  void getReportStatisticalData() {
    final List<InfoItemModel> listInfoItem = [];
    listInfoItem.addAll(
      [
        InfoItemModel(
          name: 'Tổng số văn bản đến',
          quantity: 2434,
          lastYearQuantity: 2404,
          color: const Color(0xFF374FC7),
        ),
        InfoItemModel(
          name: 'Văn bản hoàn thành trước hạn',
          quantity: 683,
          lastYearQuantity: 661,
          color: const Color(0xFF20C997),
        ),
        InfoItemModel(
          name: 'Văn bản chưa hoàn thành trong hạn',
          quantity: 1474,
          lastYearQuantity: 1498,
          color: const Color(0xFFFF9F43),
        ),
        InfoItemModel(
          name: 'Văn bản chưa hoàn thành quá hạn',
          quantity: 253,
          lastYearQuantity: 269,
          color: const Color(0xFFFF4F50),
        ),
      ],
    );
    infoItemInStream.sink.add(listInfoItem);
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
