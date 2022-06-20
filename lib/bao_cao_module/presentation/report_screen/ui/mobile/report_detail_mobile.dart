import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_list.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  final String title;
  final ReportListCubit cubit;
  final String id;

  const ReportDetail({
    Key? key,
    required this.title,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return ListViewLoadMore(
      cubit: widget.cubit,
      isListView: true,
      checkRatio: 1.5,
      crossAxisSpacing: 17,
      sinkWap: true,
      callApi: (page) => {
        widget.cubit.getListTree(
          forderId: widget.id,
        )
      },
      viewItem: (value, index) => true
          ? ItemList(
              item: value,
              cubit: widget.cubit,
            )
          : ItemGridView(
              item: value,
              cubit: widget.cubit,
            ),
    );
  }
}
