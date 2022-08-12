import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/report_list_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_report_share_favorite.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDetailMobile extends StatefulWidget {
  final String title;
  final ReportListCubit cubit;
  final String reportId;
  final bool isListView;
  final bool rootNotification;

  const ReportDetailMobile({
    Key? key,
    required this.title,
    required this.cubit,
    required this.reportId,
    required this.isListView, this.rootNotification = false,
  }) : super(key: key);

  @override
  State<ReportDetailMobile> createState() => _ReportDetailMobileState();
}

class _ReportDetailMobileState extends State<ReportDetailMobile> {

  Future<void> getApi() async {
    await widget.cubit.getListReport(
      idFolder: widget.reportId,
      isTree: true,
    );
  }

  @override
  void initState() {
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        widget.title,
        callback: () {
          if(!widget.rootNotification){
            widget.cubit.mapFolderID.removeAt(widget.cubit.levelFolder-1);
            widget.cubit.levelFolder--;
          }
        },
      ),
      body: Column(
        children: [
          reportLine(left: 16),
          Expanded(
            child: StateStreamLayout(
              retry: () {
                getApi();
              },
              error: AppException(
                S.current.error,
                S.current.something_went_wrong,
              ),
              textEmpty: S.current.list_empty,
              stream: widget.cubit.stateStream,
              child: RefreshIndicator(
                onRefresh: () async {
                  await getApi();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: StreamBuilder<List<ReportItem>?>(
                    stream: widget.cubit.listReportTree,
                    builder: (context, snapshot) {
                      return snapshot.data == null
                          ? const SizedBox.shrink()
                          : ReportListMobile(
                              isListView: widget.cubit.isListView.value,
                              listReport: snapshot.data,
                              cubit: widget.cubit,
                              isTree: true,
                              idFolder: widget.reportId,
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
