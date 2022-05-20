import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final List<ChartData> listData;
  final Function(ChartData)? onSelectItem;
  final bool showZeroValue;

  const StatusWidget({
    Key? key,
    required this.listData,
    this.onSelectItem,
    this.showZeroValue = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: listData
                .map(
                  (e) => (e.value.toInt() == 0 && showZeroValue == false)
                      ? const SizedBox.shrink()
                      : Expanded(
                          flex: e.value.toInt(),
                          child: GestureDetector(
                            onTap: () {
                              if (onSelectItem != null) {
                                // ignore: prefer_null_aware_method_calls
                                onSelectItem!(e);
                              }
                            },
                            child: Container(
                              color: e.color,
                              child: Center(
                                child: Text(
                                  e.value.toInt().toString(),
                                  style: textNormal(
                                    colorFFFFFF,
                                    14.0.textScale(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 9,
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
                    child: FittedBox(
                      child: Text(
                        '${result.title} (${result.value.toInt()})',
                        style: textNormal(
                          color667793,
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
      ],
    );
  }
}
