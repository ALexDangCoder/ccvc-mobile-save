import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowIndicatorTablet extends StatelessWidget {
  final double? paddingleft;
  final List<ChartData> chartData;

  const RowIndicatorTablet({
    Key? key,
    this.paddingleft,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingleft ?? 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 5,
          mainAxisSpacing: 10.0.textScale(space: 4),
          crossAxisSpacing: 10,
          children: List.generate(chartData.length, (index) {
            final result = chartData[index];
            // ignore: avoid_unnecessary_containers
            return GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '${result.title} (${result.value.toInt()})',
                        style: textNormal(
                          infoColor,
                          14.0.textScale(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: result.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class RowIndicatorSmallTablet extends StatelessWidget {
  final double? paddingleft;
  final List<ChartData> chartData;

  const RowIndicatorSmallTablet({
    Key? key,
    this.paddingleft,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingleft ?? 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        mainAxisSpacing: 10.0.textScale(space: 4),
        crossAxisSpacing: 10,
        children: List.generate(chartData.length, (index) {
          final result = chartData[index];
          // ignore: avoid_unnecessary_containers
          return GestureDetector(
            onTap: () {},
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
                Expanded(
                  child: Text(
                    '${result.title} (${result.value.toInt()})',
                    style: textNormal(
                      infoColor,
                      14.0.textScale(),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
