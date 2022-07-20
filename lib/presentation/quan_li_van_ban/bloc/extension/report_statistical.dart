import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:flutter/material.dart';

extension ReportStatistical on QLVBCCubit {
  void generateListTime() {
    yearsList =
        List.generate(20, (index) => (2010 + index).toString()).toList();
    monthsList = [
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
    infoItemStream.sink.add(listInfoItem);
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
