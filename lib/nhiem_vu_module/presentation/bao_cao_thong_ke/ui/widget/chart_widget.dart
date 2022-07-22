import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/my_separator.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChartWidget extends StatefulWidget {
  final List<List<ChartData>> listData;
  final List<ChartData> listStatusData;
  final List<String> listTitle;
  final BaoCaoThongKeCubit cubit;
  final int titleFlex;
  final int chartFlex;

  const ChartWidget({
    Key? key,
    required this.listData,
    required this.listStatusData,
    required this.listTitle,
    required this.cubit,
    this.titleFlex = 4,
    this.chartFlex = 7,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final heSo = 10;
  final scale = 5;
  GlobalKey globalKey = GlobalKey();
  late double height = 10;
  late int sumRowChart = 0;
  late double countRangeChart = 0;
  final BehaviorSubject<double> setHeight = BehaviorSubject.seeded(0);

  @override
  void initState() {
    super.initState();
    countRangeChart = getMaxRow(widget.listData);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final renderBox =
          globalKey.currentContext?.findRenderObject() as RenderBox;
      height = renderBox.size.height;
      setHeight.sink.add(height);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: widget.titleFlex,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(widget.listTitle.length, (index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 8, top: 20, left: 16),
                      child: Text(
                        widget.listTitle[index],
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textNormal(
                          infoColor,
                          14.0,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: widget.chartFlex,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    StreamBuilder<double>(
                      stream: setHeight.stream,
                      builder: (context, snapshot) {
                        final height = snapshot.data ?? 0;
                        return MySeparator(
                          heSo: heSo,
                          scale: scale,
                          dashCountRow: countRangeChart.floor(),
                          height: height,
                          color: colorECEEF7,
                        );
                      },
                    ),
                    Column(
                      key: globalKey,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: widget.listData.map((element) {
                              sumRowChart = 0;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                          top: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Row(
                                              children:
                                                  element.reversed.map((e) {
                                                sumRowChart += e.value.toInt();
                                                return GestureDetector(
                                                  onTap: () {
                                                    //todo
                                                  },
                                                  child: Container(
                                                    height: 28,
                                                    width: (e.value) * heSo,
                                                    color: e.color,
                                                    child: Center(
                                                      child: Text(
                                                        e.value
                                                            .toInt()
                                                            .toString(),
                                                        style: textNormal(
                                                          backgroundColorApp,
                                                          14.0.textScale(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            spaceW6,
                                            Text(
                                              sumRowChart.toString(),
                                              style: textNormal(
                                                infoColor,
                                                14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            bottom: 20.0,
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 9,
            mainAxisSpacing: 10.0.textScale(space: 4),
            crossAxisSpacing: 10,
            children: List.generate(widget.listStatusData.length, (index) {
              final result = widget.listStatusData[index];
              return GestureDetector(
                onTap: () {
                  //todo
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: result.color,
                      ),
                      height: 14,
                      width: 14,
                    ),
                    spaceW12,
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          result.title,
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
        ),
      ],
    );
  }

  double getTotalRow(List<ChartData> data) {
    double total = 0;
    for (final element in data) {
      total += element.value;
    }
    return total;
  }

  double getMaxRow(List<List<ChartData>> listData) {
    double value = 0;
    for (final element in listData) {
      final double max = getTotalRow(element);
      if (value < max) {
        value = max;
      }
    }
    final double range = value % 10;
    return (value + (10.0 - range)) / scale;
  }
}
