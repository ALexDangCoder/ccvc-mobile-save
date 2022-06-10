import 'package:ccvc_mobile/data/response/bao_cao/report_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/bao_cao/report_service.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/domain/repository/bao_cao/report_repository.dart';

class ReportImpl implements ReportRepository {
  final ReportService _reportService;

  ReportImpl(
    this._reportService,
  );

  @override
  Future<Result<List<ReportItem>>> getListReport(
    String folderId,
    int sort,
    String keyWord,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReport(
        folderId,
        sort,
        keyWord,
      ),
      (res) =>
          res.dataResponse.listReportItem?.map((e) => e.toModel()).toList() ??
          [],
    );
  }
}
