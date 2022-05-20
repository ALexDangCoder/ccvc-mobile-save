import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;
  final double paddingTop;
  final Function(int)? onTap;
  final bool isSubjectInfo;
  final double paddingLeftSubTitle;
  final bool isThongKeLichHop;
  final TextStyle? tittleStyle;

  const PieChart({
    Key? key,
    required this.chartData,
    this.title = '',
    this.paddingTop = 20,
    this.onTap,
    this.isSubjectInfo = true,
    this.paddingLeftSubTitle = 0,
    this.isThongKeLichHop = true,
    this.tittleStyle,
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
        SizedBox(
          width: 270,
          height: 270,
          child: chartData.indexWhere((element) => element.value != 0) == -1
              ? const NodataWidget()
              : SfCircularChart(
                  margin: EdgeInsets.zero,
                  onDataLabelTapped: (value) {
                    if (onTap != null) {
                      final key = chartData[value.pointIndex];

                      onTap!(value.pointIndex);
                    } else {}
                  },
                  series: [
                    // Renders doughnut chart
                    DoughnutSeries<ChartData, String>(
                        innerRadius: '45',
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        pointRadiusMapper: (ChartData data, _) => data.size,
                        xValueMapper: (ChartData data, _) => data.title,
                        yValueMapper: (ChartData data, _) => data.value,
                        dataLabelMapper: (ChartData data, _) =>
                            percent(data.value),
                        onPointTap: (value) {
                          if (onTap != null) {
                            final key = chartData[value.pointIndex ?? 0];

                            onTap!(
                              value.pointIndex ?? 0,
                            );
                          } else {}
                        },
                        dataLabelSettings: DataLabelSettings(
                          useSeriesColor: true,
                          isVisible: true,
                          showZeroValue: false,
                          textStyle: textNormalCustom(
                            color: backgroundColorApp,
                            fontSize: 14,
                          ),
                        ))
                  ],
                ),
        ),
        if (isSubjectInfo)
          Padding(
            padding: EdgeInsets.only(left: paddingLeftSubTitle),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 9,
              mainAxisSpacing: 10.0.textScale(space: 4),
              crossAxisSpacing: 10,
              children: List.generate(chartData.length, (index) {
                final result = chartData[index];
                // ignore: avoid_unnecessary_containers
                return GestureDetector(
                  onTap: () {
                    if (onTap != null) {
                      onTap!(index);
                    } else {}
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: result.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            '${result.title} (${result.value.toInt()})',
                            style: textNormal(
                              infoColor,
                              14.0.textScale(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        else
          const SizedBox()
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

class ChartData {
  ChartData(this.title, this.value, this.color, {this.size});

  final String title;
  final double value;
  final Color color;
  final String? size;
}
