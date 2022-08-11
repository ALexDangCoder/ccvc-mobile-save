import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/widget/report_list_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDetailTablet extends StatefulWidget {
  final String title;
  final ReportListCubit cubit;
  final ReportItem reportModel;
  final bool isListView;

  const ReportDetailTablet({
    Key? key,
    required this.title,
    required this.cubit,
    required this.reportModel,
    required this.isListView,
  }) : super(key: key);

  @override
  State<ReportDetailTablet> createState() => _ReportDetailTabletState();
}

class _ReportDetailTabletState extends State<ReportDetailTablet> {

  Future<void> getApi() async {
    await widget.cubit.getListReport(
      idFolder: widget.reportModel.id ?? '',
      isTree: true,
      isShare: (!widget.cubit.isCheckOwner(
                  listAccess: widget.reportModel.accesses ?? []) ||
              widget.reportModel.isSourceShare == true) ||
          (widget.reportModel.shareToMe ?? false),
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
        callback: (){
          widget.cubit.mapFolderID.removeAt(widget.cubit.levelFolder-1);
          widget.cubit.levelFolder--;
        },
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
                          : ReportListTablet(
                              isListView: widget.cubit.isListView.value,
                              listReport: snapshot.data ,
                              cubit: widget.cubit,
                              isTree: true,
                              idFolder: widget.reportModel.id ?? '',
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
