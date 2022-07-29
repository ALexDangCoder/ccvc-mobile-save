import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tinh_trang_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/common_widget.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_line_chart.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_pie_chart.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_by_division_row_chart.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class DocumentOutStatisticalPage extends StatefulWidget {
  final QLVBCCubit cubit;

  const DocumentOutStatisticalPage({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<DocumentOutStatisticalPage> createState() =>
      _DocumentOutStatisticalPageState();
}

class _DocumentOutStatisticalPageState extends State<DocumentOutStatisticalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<List<InfoItemModel>>(
            stream: widget.cubit.infoItemOutStream,
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
                            lastYearData: widget.cubit.selectedMonth == null,
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
                    S.current.van_ban_cac_don_vi_soan_thao,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StreamBuilder<List<RowChartData>>(
                  stream: widget.cubit.rowChartDataOutStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return DocumentByDivisionRowChart(
                      key: UniqueKey(),
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
              stream: widget.cubit.pieChartDataOutStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return data.isNotEmpty
                    ? DocumentByDivisionPieChart(
                        title: S.current.tinh_hinh_xu_ly_van_ban_di,
                        chartData: data,
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
          appDivider,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder<Map<String, List<TinhTrangXuLyModel>>>(
              stream: widget.cubit.lineChartDataInStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? {};
                return DocumentByDivisionLineChart(
                  title: S.current.thong_ke_van_ban_den,
                  data: data,
                  getIncomeDocument: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
