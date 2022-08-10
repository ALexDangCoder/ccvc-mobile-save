import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportWebViewTablet extends StatefulWidget {
  const ReportWebViewTablet({
    Key? key,
    required this.cubit,
    required this.idReport,
    required this.title,
  }) : super(key: key);
  final ReportListCubit cubit;
  final String idReport;
  final String title;

  @override
  State<ReportWebViewTablet> createState() => _ReportWebViewState();
}

class _ReportWebViewState extends State<ReportWebViewTablet> {
  @override
  void initState() {
    widget.cubit.getReportDetail(
      idReport: widget.idReport,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      retry: () {
        widget.cubit.getReportDetail(
          idReport: widget.idReport,
        );
      },
      error: AppException(
        S.current.error,
        S.current.something_went_wrong,
      ),
      textEmpty: S.current.error,
      stream: widget.cubit.stateStream,
      child: Scaffold(
        appBar: AppBarDefaultBack(
          widget.title,
          callback: (){},
        ),
        body: StreamBuilder<String?>(
          stream: widget.cubit.urlReportWebView,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? WebView(
                    initialUrl: snapshot.data,
                    javascriptMode: JavascriptMode.unrestricted,
                    gestureNavigationEnabled: true,
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
