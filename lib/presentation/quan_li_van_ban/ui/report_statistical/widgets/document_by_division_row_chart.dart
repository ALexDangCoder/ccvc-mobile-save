import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DocumentByDivisionRowChart extends StatefulWidget {
  final List<RowChartData> data;
  final List<ChartData> listStatusData;

  const DocumentByDivisionRowChart({
    Key? key,
    required this.listStatusData,
    this.data = const [],
  }) : super(key: key);

  @override
  _DocumentByDivisionRowChartState createState() =>
      _DocumentByDivisionRowChartState();
}

class _DocumentByDivisionRowChartState
    extends State<DocumentByDivisionRowChart> {
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
    countRangeChart = getMaxRow(widget.data);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final renderBox =
          globalKey.currentContext?.findRenderObject() as RenderBox?;
      height = renderBox?.size.height ?? 0;
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
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0),
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
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: List.generate(widget.data.length, (index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 8, top: 20, left: 16),
                      child: Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        message: widget.data[index].title,
                        child: Text(
                          widget.data[index].title,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textNormal(
                            infoColor,
                            14.0,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    StreamBuilder<double>(
                      stream: setHeight.stream,
                      builder: (context, snapshot) {
                        final height = snapshot.data ?? 0;
                        return DocumentManagementSeparator(
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
                            children: widget.data.map((element) {
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
                                                  element.listData.map((e) {
                                                sumRowChart += e.value;
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 28,
                                                    width: (e.value) *
                                                        heSo.toDouble(),
                                                    color: e.color,
                                                    child: Center(
                                                      child: Text(
                                                        e.value.toString(),
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
                                            const SizedBox(
                                              width: 6,
                                            ),
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
      ],
    );
  }

  double getTotalRow(List<SubRowChartData> data) {
    double total = 0;
    for (final element in data) {
      total += element.value;
    }
    return total;
  }

  double getMaxRow(List<RowChartData> listData) {
    double value = 0;
    for (final element in listData) {
      final double max = getTotalRow(element.listData);
      if (value < max) {
        value = max;
      }
    }
    final double range = value % 10;
    return (value + (10.0 - range)) / scale;
  }
}

class DocumentManagementSeparator extends StatelessWidget {
  const DocumentManagementSeparator({
    Key? key,
    this.width = 1,
    this.color = colorBlack,
    this.height = 10,
    required this.dashCountRow,
    required this.heSo,
    required this.scale,
  }) : super(key: key);
  final double width;
  final Color color;
  final double height;
  final int dashCountRow;
  final int heSo;
  final int scale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashHeight = 6.0;
        final dashWidth = width;
        final dashCount = (height / (dashHeight * 1.5)).floor() + 1;
        return Row(
          children: List.generate(dashCountRow, (index) {
            final String indexTrucHoanh = (index * scale).toString();
            return SizedBox(
              width: (heSo * scale).toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: List.generate(dashCount, (_) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: dashHeight / 2),
                        child: SizedBox(
                          height: dashHeight,
                          width: dashWidth,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: color),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    indexTrucHoanh,
                    style: textNormal(
                      coloriCon,
                      12,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class RowChartData {
  String title;
  List<SubRowChartData> listData;

  RowChartData({required this.title, required this.listData});
}

class SubRowChartData {
  int value;
  Color color;

  SubRowChartData({required this.value, required this.color});
}
