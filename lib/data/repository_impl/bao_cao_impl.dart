import 'package:ccvc_mobile/data/response/bao_cao/group_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/report_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/bao_cao/report_service.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
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

  @override
  Future<Result<List<NhomCungHeThong>>> getListGroup() {
    return runCatchingAsync<GroupImplResponse, List<NhomCungHeThong>>(
      () => _reportService.getListGroup(
        'c3c5aba1-fb93-4ab1-a865-718001d47788',
        ApiConstants.PAGE_BEGIN.toString(),
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (res) => res.data?.toListResponse() ?? [],
    );
  }

  @override
  Future<Result<List<ThanhVien>>> getListThanhVien(String groupId) {
    return runCatchingAsync<GroupImplResponse, List<ThanhVien>>(
          () => _reportService.getListThanhVien(
            groupId,
        ApiConstants.PAGE_BEGIN.toString(),
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
          (res) => res.data?.toListThanhVien() ?? [],
    );
  }
}
