import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_list.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  final String title;
  final ReportListCubit cubit;
  final String id;
  final bool isListView;

  const ReportDetail({
    Key? key,
    required this.title,
    required this.cubit,
    required this.id,
    required this.isListView,
  }) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        widget.title,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 16,
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: borderColor.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: ListViewLoadMore(
              cubit: widget.cubit,
              isListView: widget.isListView,
              checkRatio: 1.5,
              crossAxisSpacing: 17,
              sinkWap: true,
              callApi: (page) => {
                widget.cubit.getListReport(
                  folder: widget.id,
                )
              },
              viewItem: (value, index) => widget.isListView
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportDetail(
                              cubit: widget.cubit,
                              id: value.id ?? '',
                              title: value.name ?? '',
                              isListView: widget.isListView,
                            ),
                          ),
                        ).whenComplete(() {
                          widget.cubit.getListReport(
                            folder: widget.id,
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ItemList(
                          item: value,
                          cubit: widget.cubit,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportDetail(
                              cubit: widget.cubit,
                              id: value.id ?? '',
                              title: value.name ?? '',
                              isListView: widget.isListView,
                            ),
                          ),
                        ).whenComplete(() {
                          widget.cubit.getListReport(
                            folder: widget.id,
                          );
                        });
                      },
                      child: ItemGridView(
                        item: value,
                        cubit: widget.cubit,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
