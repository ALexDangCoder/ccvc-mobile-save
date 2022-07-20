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

class DocumentInStatisticalPage extends StatelessWidget {
  final QLVBCCubit cubit;

  const DocumentInStatisticalPage({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 122,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
            child: StreamBuilder<List<InfoItemModel>>(
              stream: cubit.infoItemStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return ListView.builder(
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
                );
              },
            ),
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
                DocumentByDivisionRowChart(
                  data: [
                    RowChartData(
                      title: 'Vụ kế hoạch tài chính',
                      listData: [
                        SubRowChartData(
                          value: 48,
                          color: colorFF4F50,
                        ),
                        SubRowChartData(
                          value: 55,
                          color: color20C997,
                        ),
                      ],
                    ),
                    RowChartData(
                      title: 'Vụ kế hoạch quy hoạch kiến truc',
                      listData: [
                        SubRowChartData(
                          value: 22,
                          color: colorFF4F50,
                        ),
                        SubRowChartData(
                          value: 25,
                          color: color20C997,
                        ),
                      ],
                    )
                  ],
                  listStatusData: [
                    ChartData(
                      S.current.qua_han,
                      70,
                      const Color(0xFFFF4F50),
                    ),
                    ChartData(
                      S.current.trong_han,
                      80,
                      const Color(0xFF20C997),
                    )
                  ],
                ),
              ],
            ),
          ),
          appDivider,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DocumentByDivisionPieChart(
              chartData: [
                ChartData(
                  'Trong hạn',
                  25,
                  color20C997,
                ),
                ChartData(
                  'Quá hạn',
                  75,
                  colorFF4F50,
                ),
              ],
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
