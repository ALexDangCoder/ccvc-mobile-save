import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/common_widget.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_line_chart.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_pie_chart.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class DocumentOutStatisticalPage extends StatelessWidget {
  final QLVBCCubit cubit;

  const DocumentOutStatisticalPage({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<List<InfoItemModel>>(
            stream: cubit.infoItemOutStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              return data.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: NodataWidget(),
                    )
                  : Container(
                      height: 122,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.only(
                            right: index == (data.length - 1) ? 0 : 16,
                          ),
                          child: infoItem(
                            title: data[index].name,
                            quantity: data[index].quantity,
                            lastYearQuantity: data[index].lastYearQuantity,
                            color: data[index].color,
                          ),
                        ),
                      ),
                    );
            },
          ),
          appDivider,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: Text(
                    S.current.word_processing_state,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StreamBuilder<List<RowChartData>>(
                  stream: cubit.rowChartDataOutStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return DocumentByDivisionRowChart(
                      data: data,
                    );
                  },
                ),
              ],
            ),
          ),
          appDivider,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder<List<ChartData>>(
              stream: cubit.pieChartDataOutStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return data.length == 2
                    ? DocumentByDivisionPieChart(
                        chartData: [
                          data.first,
                          data.last,
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
          appDivider,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DocumentByDivisionLineChart(
              chartData: [
                ChartData(
                  'Quá hạn',
                  75,
                  colorFF4F50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
