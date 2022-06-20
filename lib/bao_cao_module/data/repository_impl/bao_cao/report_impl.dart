import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/list_tree_report_respose.dart';
import 'package:ccvc_mobile/data/response/bao_cao/folder_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/group_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/report_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/bao_cao/report_service.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/folder_model.dart';
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
    String appId,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReport(
        folderId,
        sort,
        keyWord,
        appId,
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

  @override
  Future<Result<FolderModel>> getFolderID(
    String appId,
  ) {
    return runCatchingAsync<FolderResponse, FolderModel>(
      () => _reportService.getFolderID(appId),
      (res) => res.data?.toDomain() ?? FolderModel(),
    );
  }

  @override
  Future<Result<bool>> postLikeReportFavorite(
    List<String> idReport,
    String appId,
  ) {
    return runCatchingAsync<dynamic, bool>(
      () => _reportService.postLikeReport(
        idReport,
        appId,
      ),
      (res) {
        try {
          return (res as Map<String, dynamic>)['succeeded'];
        } catch (e) {
          return false;
        }
      },
    );
  }

  @override
  Future<Result<bool>> putDislikeReportFavorite(
    List<String> idReport,
    String appId,
  ) {
    return runCatchingAsync<dynamic, bool>(
        () => _reportService.putDisLikeReport(
              idReport,
              appId,
            ), (res) {
      try {
        return (res as Map<String, dynamic>)['succeeded'];
      } catch (e) {
        return false;
      }
    });
  }

  @override
  Future<Result<List<ReportItem>>> getListReportFavorite(
    String appId,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReportFavorite(appId),
      (res) =>
          res.dataResponse.listReportItem?.map((e) => e.toModel()).toList() ??
          [],
    );
  }

  @override
  Future<Result<List<FolderModel>>> getListReportTree(
    String appId,
    String folderId,
  ) {
    return runCatchingAsync<ListTreeReportResponse, List<FolderModel>>(
      () => _reportService.getListReportTree(
        appId,
        folderId,
      ),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
