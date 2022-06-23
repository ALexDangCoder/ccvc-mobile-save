import 'package:ccvc_mobile/bao_cao_module/data/request/users_ngoai_he_thong_truy_cap_truy_cap_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/ds_user_ngoai_he_thong_duoc_truy_cap_res.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/folder_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/group_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/list_tree_report_respose.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/report_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/services/bao_cao/report_service.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/bao_cao/report_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';

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
          res.dataResponse?.listReportItem?.map((e) => e.toModel()).toList() ??
          [],
    );
  }

  @override
  Future<Result<List<NhomCungHeThong>>> getListGroup(String appId) {
    return runCatchingAsync<GroupImplResponse, List<NhomCungHeThong>>(
      () => _reportService.getListGroup(
        appId,
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
  Future<Result<ReportItem>> getFolderID(
    String appId,
  ) {
    return runCatchingAsync<FolderResponse, ReportItem>(
      () => _reportService.getFolderID(appId),
      (res) => res.data?.toDomain() ?? ReportItem(),
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
    String folderId,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReportFavorite(appId, folderId),
      (res) =>
          res.dataResponse?.listReportItem?.map((e) => e.toModel()).toList() ??
          [],
    );
  }

  @override
  Future<Result<List<ReportItem>>> getListReportTree(
    String appId,
    String folderId,
  ) {
    return runCatchingAsync<ListTreeReportResponse, List<ReportItem>>(
      () => _reportService.getListReportTree(
        appId,
        folderId,
      ),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<String>> addNewMember(
      Map<String, String> mapMember, String appId) {
    return runCatchingAsync<PostDataResponse, String>(
      () => _reportService.addNewUser(
        mapMember,
        appId,
      ),
      (res) => res.message ?? '',
    );
  }

  @override
  Future<Result<String>> shareReport(
      List<ShareReport> mapMember, String idReport, String appId,) {
    return runCatchingAsync<PostDataResponse, String>(
      () => _reportService.shareReport(
        idReport,
        mapMember,
        appId,
      ),
      (res) => res.message ?? '',
    );
  }

  @override
  Future<Result<List<UserNgoaiHeThongDuocTruyCapModel>>>
      getUsersNgoaiHeThongTruyCap(
          String appId, int pageIndex, int pageSize, String keyword) {
    return runCatchingAsync<UserNgoaiHeThongTruyCapTotalResponse,
        List<UserNgoaiHeThongDuocTruyCapModel>>(
      () => _reportService.getUsersNgoaiHeThongDuocTruyCap(
        appId,
        UsersNgoaiHeThongTruyCapRequest(
          pageIndex: pageIndex,
          pageSize: pageSize,
          keyword: keyword,
        ),
      ),
      (res) => res.data?.items?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}