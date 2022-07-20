import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DocumentByDivisionPieChart extends StatelessWidget {
  final List<ChartData> chartData;

  const DocumentByDivisionPieChart({Key? key, required this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PieChart(
      title: 'Tình hình xử lý văn bản đến',
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
          SfCircularChart(
            margin: EdgeInsets.zero,
            onDataLabelTapped: (value) {},
            series: [
              DoughnutSeries<ChartData, String>(
                innerRadius: '45',
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                pointRadiusMapper: (ChartData data, _) => data.size,
                xValueMapper: (ChartData data, _) => data.title,
                yValueMapper: (ChartData data, _) => data.value,
                dataLabelMapper: (ChartData data, _) =>
                    '${data.title} ${percent(data.value)}',
                onPointTap: (value) {},
                dataLabelSettings: DataLabelSettings(
                  builder: (
                    data,
                    point,
                    series,
                    pointIndex,
                    seriesIndex,
                  ) {
                    return SizedBox(
                      width: 75,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.title,
                            style: textNormal(
                              color3D5586,
                              16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            percent(data.value),
                            style: textNormal(
                              data.color,
                              24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                  useSeriesColor: true,
                  isVisible: true,
                  showZeroValue: false,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
              )
            ],
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
    return '${percent.toStringAsFixed(2).replaceAll('.00', '')}%';
  }
}
