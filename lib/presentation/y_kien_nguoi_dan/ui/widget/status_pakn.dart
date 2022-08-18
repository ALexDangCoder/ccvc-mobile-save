import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

Widget statusWidget({
  required List<ChartData> listData,
  required Function(int index) callBack,
  bool? isTablet = false,
}) {
  final data = listData.map((e) => e.value).toList();
  final total = data.reduce((a, b) => a + b);
  final lastStatusChart = listData.last;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listData.map(
            (e) {
              final index = listData.indexOf(e);
              return InkWell(
                onTap: () => callBack(index),
                child: Row(
                  children: [
                    Container(
                      height: 260,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorECEEF7,
                      ),
                      // color: e.color,
                      child: Column(
                        children: [
                          Expanded(
                            flex: (total - (e.value)).toInt(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FittedBox(
                                  child: Text(
                                    e.value.toInt().toString(),
                                    style: textNormal(
                                      textTitleColumn,
                                      14.0.textScale(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: e.value.toInt(),
                            child: Container(
                              width: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: e.color,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isTablet ?? false ? 14.0 : 0.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 8,
          mainAxisSpacing: 10.0.textScale(space: 4),
          crossAxisSpacing: 10,
          children: List.generate(listData.length - 1, (index) {
            final result = listData[index];
            // ignore: avoid_unnecessary_containers
            return InkWell(
              onTap: () => callBack(index),
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
                        14.0,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
      SizedBox(
        height: 10.0.textScale(space: 4),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isTablet ?? false ? 14.0 : 0.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => callBack(listData.length - 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: lastStatusChart.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        '${lastStatusChart.title} (${lastStatusChart.value.toInt()})',
                        style: textNormal(
                          infoColor,
                          14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      )
    ],
  );
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
