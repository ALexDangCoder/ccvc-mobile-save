import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class HanXuLyWidget extends StatelessWidget {
  final List<ChartData> data;
  final double paddingLeftSubTitle;
  final Function(int)? onTap;

  const HanXuLyWidget({
    Key? key,
    this.data = const [],
    this.paddingLeftSubTitle = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(data.length, (index) {
            final result = data[index];
            return result.value == 0
                ? const SizedBox()
                : Expanded(
                    flex: result.value.toInt(),
                    child: GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(index);
                        } else {}
                      },
                      child: Container(
                        height: 38,
                        color: result.color,
                        alignment: Alignment.center,
                        child: Text(
                          result.value.toInt().toString(),
                          style: textNormal(Colors.white, 14),
                        ),
                      ),
                    ),
                  );
          }),
        ),
        const SizedBox(
          height: 23,
        ),
        Padding(
          padding: EdgeInsets.only(left: paddingLeftSubTitle),
          child: GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 9,
            mainAxisSpacing: 10.0.textScale(space: 4),
            crossAxisSpacing: 10,
            children: List.generate(data.length, (index) {
              final result = data[index];
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
      ],
    );
  }
}
