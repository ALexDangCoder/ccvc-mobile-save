import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class ChartCircleWidget extends StatelessWidget {
  final List<ChartData> listChartNote;
  final List<ChartData> chartData;

  const ChartCircleWidget({
    Key? key,
    required this.listChartNote,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PieChart(
          isSubjectInfo: false,
          chartData: chartData,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 9,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10,
          children: List.generate(listChartNote.length, (index) {
            final result = listChartNote[index];
            return Row(
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
                      '${result.title} (${result.value})',
                      style: textNormal(
                        infoColor,
                        14.0,
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ],
    );
  }
}
