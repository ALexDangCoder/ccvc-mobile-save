
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/items/situation_of_handling_people_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class StatusColumnChart extends StatelessWidget {
  final List<ChartData> listData;

  const StatusColumnChart({Key? key, required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = listData.map((e) => e.value).toList();
    final total = data.reduce((a, b) => a + b);
    return Stack(
      children: [
        SizedBox(
          height: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              8,
              (index) => const MySeparator(
                color: lineColor,
                height: 2,
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: listData
                    .map(
                      (e) => Row(
                        children: [
                          Container(
                            height: 260,
                            width: 38,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lineColor,
                            ),
                            // color: e.color,
                            child: e.value.toInt() == 0
                                ? FittedBox(
                                    child: Text(
                                      e.value.toInt().toString(),
                                      style: textNormal(
                                        textTitleColumn,
                                        14.0.textScale(),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Expanded(
                                        flex: (total - (e.value)).toInt(),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                            const SizedBox(
                                              height: 6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: e.value.toInt(),
                                        child: Container(
                                          width: 38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: e.color,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 5,
              mainAxisSpacing: 10.0.textScale(space: 4),
              crossAxisSpacing: 10,
              children: List.generate(listData.length, (index) {
                final result = listData[index];
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

                      Flexible(
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
          ],
        ),
      ],
    );
  }
}
