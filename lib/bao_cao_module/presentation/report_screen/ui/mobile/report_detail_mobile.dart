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
  final String idFolder;
  final bool isListView;

  const ReportDetailMobile({
    Key? key,
    required this.title,
    required this.cubit,
    required this.idFolder,
    required this.isListView,
  }) : super(key: key);

  @override
  State<ReportDetailMobile> createState() => _ReportDetailMobileState();
}

class _ReportDetailMobileState extends State<ReportDetailMobile> {
  List<ReportItem> listReportDetail = [];
  bool isCheckInit = true;
  bool isCheckData = false;
  bool isInit = false;

  @override
  void initState() {
    widget.cubit.getListReport(
      idFolder: widget.idFolder,
      isTree: true,
    );
    super.initState();
    isInit = true;
    if (isCheckInit) {
      widget.cubit.isCheckData.listen((value) {
        if (value) {
          isCheckData = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        widget.title,
      ),
      body: Column(
        children: [
          reportLine(left: 16),
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
                  isCheckData = true;
                  isInit = true;
                  await widget.cubit.getListReport(
                    idFolder: widget.idFolder,
                    isTree: true,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: StreamBuilder<List<ReportItem>?>(
                    stream: widget.cubit.listReportTree,
                    builder: (context, snapshot) {
                      if (isCheckData && isInit) {
                        listReportDetail.addAll(snapshot.data ?? []);
                        isCheckInit = false;
                        isCheckData = false;
                        isInit = false;
                      }
                      return snapshot.data == null
                          ? const SizedBox.shrink()
                          : ReportListMobile(
                              isListView: widget.cubit.isListView.value,
                              listReport: listReportDetail,
                              cubit: widget.cubit,
                              isTree: true,
                              idFolder: widget.idFolder,
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
