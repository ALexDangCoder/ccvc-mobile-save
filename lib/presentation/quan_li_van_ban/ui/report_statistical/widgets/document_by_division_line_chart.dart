import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tinh_trang_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DocumentByDivisionLineChart extends StatelessWidget {
  final String title;
  final Map<String, List<TinhTrangXuLyModel>> data;
  final bool getIncomeDocument;

  const DocumentByDivisionLineChart({
    Key? key,
    required this.title,
    required this.data,
    this.getIncomeDocument = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TinhTrangXuLyModel> currentYearData = data.getListValue(
      CURRENT_YEAR_DATA,
    );
    final List<TinhTrangXuLyModel> lastYearData = data.getListValue(
      LAST_YEAR_DATA,
    );

    return Column(
      children: [
        if (title.isEmpty)
          const SizedBox()
        else
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FittedBox(
                child: Text(
                  title,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        if (currentYearData.isEmpty ||
            currentYearData.length != currentYearData.length)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: NodataWidget(),
          )
        else
          _LineChartView(
            currentYearData: currentYearData,
            lastYearData: lastYearData,
            getIncomeDocument: getIncomeDocument,
          )
      ],
    );
  }
}

class _LineChartView extends StatefulWidget {
  final List<TinhTrangXuLyModel> currentYearData;
  final List<TinhTrangXuLyModel> lastYearData;
  final bool getIncomeDocument;

  const _LineChartView({
    Key? key,
    required this.currentYearData,
    required this.lastYearData,
    required this.getIncomeDocument,
  }) : super(key: key);

  @override
  State<_LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<_LineChartView> {
  List<_ChartData> chartData = [];

  @override
  void initState() {
    genChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultLineChart();
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      onLegendTapped: (_) {},
      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.top,
      ),
      primaryXAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.outside,
        visibleMaximum: 12,
        interval: 1,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '',
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
        color: color5A8DEE,
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: S.current.nam_nay,
        markerSettings: const MarkerSettings(
          isVisible: true,
          color: color5A8DEE,
        ),
      ),
      LineSeries<_ChartData, num>(
        color: colorFF9F43,
        animationDuration: 2500,
        dataSource: chartData,
        width: 2,
        name: S.current.nam_truoc,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        markerSettings:
            const MarkerSettings(isVisible: true, color: colorFF9F43),
      )
    ];
  }

  void genChartData() {
    if (widget.getIncomeDocument) {
      for (int i = 0; i < widget.currentYearData.length; i++) {
        chartData.add(
          _ChartData(
            i + 1,
            widget.currentYearData[i].VanBanDen,
            widget.lastYearData[i].VanBanDen,
          ),
        );
      }
    } else {
      for (int i = 0; i < widget.currentYearData.length; i++) {
        chartData.add(
          _ChartData(
            i + 1,
            widget.currentYearData[i].VanBanDi,
            widget.lastYearData[i].VanBanDi,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final int x;
  final int y;
  final int y2;
}
