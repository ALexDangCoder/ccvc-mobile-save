import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/report_list.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  final String title;
  final ReportListCubit cubit;
  final String idFolder;
  final bool isListView;

  const ReportDetail({
    Key? key,
    required this.title,
    required this.cubit,
    required this.idFolder,
    required this.isListView,
  }) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  void initState() {
    widget.cubit.getListReport(
      idFolder: widget.idFolder,
      isTree: true,
    );
    super.initState();
  }

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
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: borderColor.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: StateStreamLayout(
              retry: () {
                widget.cubit.getListReport(
                  idFolder: widget.idFolder,
                  isTree: true,
                );
              },
              error: AppException(
                S.current.error,
                S.current.something_went_wrong,
              ),
              textEmpty: S.current.list_empty,
              stream: widget.cubit.stateStream,
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.getListReport(
                    idFolder: widget.idFolder,
                    isTree: true,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: StreamBuilder<List<ReportItem>>(
                      stream: widget.cubit.listReportTree,
                      builder: (context, snapshot) {
                        final list = snapshot.data ?? [];
                        return ReportList(
                          isListView: widget.cubit.isListView.value,
                          listReport: list,
                          cubit: widget.cubit,
                          isTree: true,
                          idFolder: widget.idFolder,
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
