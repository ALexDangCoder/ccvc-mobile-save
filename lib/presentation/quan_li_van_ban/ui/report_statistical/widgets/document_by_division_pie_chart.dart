import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/common_info.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class DocumentByDivisionPieChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;

  const DocumentByDivisionPieChart({
    Key? key,
    required this.chartData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PieChart(
      title: title,
      tittleStyle: textNormalCustom(
        color: textTitle,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      chartData: List.generate(
        chartData.length,
        (index) => ChartData(
          chartData[index].title,
          chartData[index].value,
          chartData[index].color,
        ),
      ),
    );
  }
}

class _PieChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;
  final double paddingTop;
  final TextStyle? tittleStyle;
  final bool useVerticalLegend;

  const _PieChart({
    Key? key,
    required this.chartData,
    this.title = '',
    this.paddingTop = 20,
    this.tittleStyle,
    this.useVerticalLegend = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title.isEmpty)
          const SizedBox()
        else
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: FittedBox(
                child: Text(
                  title,
                  style: tittleStyle ??
                      textNormalCustom(
                        color: infoColor,
                        fontSize: 16,
                      ),
                ),
              ),
            ),
          ),
        if (chartData.indexWhere((element) => element.value != 0) == -1)
          const NodataWidget()
        else
          CommonInformationDocumentManagement(
            chartData: chartData,
            onPieTap: (value) {},
            onStatusTap: (key) {},
          ),
      ],
    );
  }

  String percent(double vl) {
    double sum = 0;
    for (final vl in chartData) {
      sum += vl.value;
    }
    final double percent = (vl / sum) * 100;
    return '${percent.round()}%';
  }
}
