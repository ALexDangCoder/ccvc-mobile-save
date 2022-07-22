import 'package:ccvc_mobile/bao_cao_module/data/request/new_member_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/request/users_ngoai_he_thong_truy_cap_truy_cap_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/can_bo_chia_se_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/ds_user_ngoai_he_thong_duoc_truy_cap_res.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/folder_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/group_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/report_detail_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/report_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/services/report_common_service.dart';
import 'package:ccvc_mobile/bao_cao_module/data/services/report_service.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_detail_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

class ReportImpl implements ReportRepository {
  final ReportService _reportService;
  final ReportCommonService _reportCommonService;

  ReportImpl(this._reportService, this._reportCommonService);

  @override
  Future<Result<List<ReportItem>>> getListReport(
    String folderId,
    int sort,
    String keyWord,
    String appId,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReport(
        appId,
        folderId,
        sort,
        keyWord,
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
    int sort,
  ) {
    return runCatchingAsync<ReportResponse, List<ReportItem>>(
      () => _reportService.getListReportFavorite(
        appId,
        folderId,
        sort,
      ),
      (res) =>
          res.dataResponse?.listReportItem?.map((e) => e.toModel()).toList() ??
          [],
    );
  }

  @override
  Future<Result<String>> addNewMember(NewUserRequest mapMember, String appId) {
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
    List<ShareReport> mapMember,
    String idReport,
    String appId,
  ) {
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
    String appId,
    int pageIndex,
    int pageSize,
    String keyword,
    int status,
    bool isLock,
  ) {
    return runCatchingAsync<UserNgoaiHeThongTruyCapTotalResponse,
        List<UserNgoaiHeThongDuocTruyCapModel>>(
      () => _reportService.getUsersNgoaiHeThongDuocTruyCap(
        appId,
        [
          UsersNgoaiHeThongTruyCapRequest(
            fullname: keyword,
            status: status,
            isLock: isLock,
          ),
          UsersNgoaiHeThongTruyCapRequest(
            email: keyword,
            status: status,
            isLock: isLock,
          ),
          UsersNgoaiHeThongTruyCapRequest(
            position: keyword,
            status: status,
            isLock: isLock,
          ),
          UsersNgoaiHeThongTruyCapRequest(
            unit: keyword,
            status: status,
            isLock: isLock,
          ),
        ],
        pageIndex,
        pageSize,
      ),
      (res) => res.data?.items?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ReportDetailModel>> getReportDetail(
    String appId,
    String idReport,
  ) {
    return runCatchingAsync<ReportDetailResponse, ReportDetailModel>(
      () => _reportService.getReportDetail(appId, idReport),
      (res) => res.dataResponse?.toModel() ?? ReportDetailModel(),
    );
  }

  @override
  Future<Result<List<Node<DonViModel>>>> getUserPaging({
    required String donViId,
    required String appId,
    String hoTen = '',
    bool isGetAll = false,
    int pageIndex = 1,
    int pageSize = 9999,
  }) {
    return runCatchingAsync<CanBoChiaSeResponse, List<Node<DonViModel>>>(
      () => _reportCommonService.getUserPaging(
        donViId,
        appId,
        hoTen,
        isGetAll,
        pageIndex,
        pageSize,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<DonViModel>>> getUserPagingNhiemVu({
    required String donViId,
    required String appId,
    String hoTen = '',
    bool isGetAll = false,
    int pageIndex = 1,
    int pageSize = 9999,
  }) {
    return runCatchingAsync<CanBoChiaSeResponse, List<DonViModel>>(
      () => _reportCommonService.getUserPaging(
        donViId,
        appId,
        hoTen,
        isGetAll,
        pageIndex,
        pageSize,
      ),
      (res) => res.toDomainNhiemVu(),
    );
  }
}
